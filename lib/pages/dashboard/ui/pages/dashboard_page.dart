import 'package:flutter/material.dart';
import 'package:hdi_test/core/theme/app_typography.dart';
import 'package:hdi_test/utils/extensions/build_context_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hdi_test/core/theme/app_colors.dart';
import 'package:hdi_test/models/member_model.dart';
import 'package:hdi_test/models/transaction_model.dart';
import 'package:hdi_test/pages/auth/bloc/auth_bloc.dart';
import 'package:hdi_test/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:hdi_test/pages/dashboard/ui/widgets/member_info_card.dart';
import 'package:hdi_test/pages/dashboard/ui/widgets/recent_tile.dart';
import 'package:hdi_test/pages/dashboard/ui/widgets/spend_chart.dart';
import 'package:hdi_test/pages/dashboard/repository/dashboard_repository.dart';
import 'package:hdi_test/router/router_constants.dart';
import 'package:hdi_test/utils/enums/status_state.dart';
import 'package:hdi_test/widgets/shimmer_box.dart';
import 'package:hdi_test/widgets/summary_card.dart';
import 'package:hdi_test/utils/utils_function.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) =>
          DashboardBloc(dashboardRepository: ctx.read<DashboardRepository>())
            ..add(const DashboardEvent.loadDashboard()),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            tooltip: 'Personalization',
            onPressed: () => context.pushNamed(RouteNames.personalization),
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Logout',
            onPressed: () => context.read<AuthBloc>().add(const AuthEvent.logoutRequested()),
          ),
        ],
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state.status == StatusState.loading || state.status == StatusState.idle) {
            return _buildShimmer(context);
          }
          if (state.status == StatusState.error) {
            return _buildError(context, state.errorMessage ?? 'Unknown error');
          }
          if (state.member == null) return const SizedBox.shrink();
          return _buildContent(context, state.member!, state.transactions);
        },
      ),
    );
  }

  Widget _buildShimmer(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerBox(height: 100.h, borderRadius: 16.r),
            Gap(20.h),
            Row(
              children: List.generate(
                3,
                (i) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: i < 2 ? 10.w : 0),
                    child: ShimmerBox(height: 110.h, borderRadius: 16.r),
                  ),
                ),
              ),
            ),
            Gap(20.h),
            ShimmerBox(height: 200.h, borderRadius: 16.r),
          ],
        ),
      ),
      tablet: (_) => SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  ShimmerBox(height: 120.h, borderRadius: 20.r),
                  Gap(16.h),
                  Row(
                    children: List.generate(
                      3,
                      (i) => Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: i < 2 ? 10.w : 0),
                          child: ShimmerBox(height: 90.h, borderRadius: 16.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(20.w),
            Expanded(
              child: Column(
                children: [
                  ShimmerBox(height: 220.h, borderRadius: 16.r),
                  Gap(16.h),
                  ...List.generate(
                    3,
                    (i) => Padding(
                      padding: EdgeInsets.only(bottom: i < 2 ? 10.h : 0),
                      child: ShimmerBox(height: 64.h, borderRadius: 12.r),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, MemberModel member, List<TransactionModel> transactions) {
    final cs = context.colorScheme;
    final sorted = [...transactions]..sort((a, b) => b.date.compareTo(a.date));
    final paidThisMonth = UtilsFunction.formatCurrency(UtilsFunction.calcMonthPaid(transactions));
    final lastDate = sorted.isNotEmpty ? UtilsFunction.formatDate(sorted.first.date) : '-';
    final recentTiles = sorted.take(3).map((t) => RecentTile(transaction: t)).toList();

    void onRefresh() => context.read<DashboardBloc>().add(const DashboardEvent.loadDashboard());
    void onSeeAll() => context.pushNamed(RouteNames.history);

    return ScreenTypeLayout.builder(
      mobile: (_) => _buildMobile(onRefresh, member, paidThisMonth, cs, lastDate, transactions, onSeeAll, recentTiles),
      tablet: (_) => _buildTablet(onRefresh, member, paidThisMonth, cs, lastDate, transactions, onSeeAll, recentTiles),
    );
  }

  RefreshIndicator _buildMobile(
    void Function() onRefresh,
    MemberModel member,
    String paidThisMonth,
    ColorScheme cs,
    String lastDate,
    List<TransactionModel> transactions,
    void Function() onSeeAll,
    List<RecentTile> recentTiles,
  ) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MemberInfoCard(member: member),
            Gap(20.h),
            Text('Summary', style: AppTypography.sectionTitle),
            Gap(12.h),
            Row(
              children: [
                Expanded(
                  child: SummaryCard(
                    label: 'Paid This Month',
                    value: paidThisMonth,
                    icon: Icons.payments_rounded,
                    iconColor: cs.primary,
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: SummaryCard(
                    label: 'Last Transaction',
                    value: lastDate,
                    icon: Icons.calendar_today_rounded,
                    iconColor: cs.secondary,
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: SummaryCard(
                    label: 'Status',
                    value: member.membershipStatus,
                    icon: Icons.workspace_premium_rounded,
                    iconColor: AppColors.warning,
                  ),
                ),
              ],
            ),
            Gap(20.h),
            Text('Monthly Spend (Last 6 Months)', style: AppTypography.sectionTitle),
            Gap(12.h),
            SpendChart(transactions: transactions),
            Gap(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Transactions', style: AppTypography.sectionTitle),
                TextButton(
                  onPressed: onSeeAll,
                  child: Text('See All', style: AppTypography.captionMedium.copyWith(color: cs.primary)),
                ),
              ],
            ),
            Gap(8.h),
            ...recentTiles,
            Gap(20.h),
          ],
        ),
      ),
    );
  }

  RefreshIndicator _buildTablet(
    void Function() onRefresh,
    MemberModel member,
    String paidThisMonth,
    ColorScheme cs,
    String lastDate,
    List<TransactionModel> transactions,
    void Function() onSeeAll,
    List<RecentTile> recentTiles,
  ) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(24.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MemberInfoCard(member: member),
                  Gap(20.h),
                  Text('Summary', style: AppTypography.sectionTitle),
                  Gap(12.h),
                  Row(
                    children: [
                      Expanded(
                        child: SummaryCard(
                          label: 'Paid This Month',
                          value: paidThisMonth,
                          icon: Icons.payments_rounded,
                          iconColor: cs.primary,
                        ),
                      ),
                      Gap(10.w),
                      Expanded(
                        child: SummaryCard(
                          label: 'Last Transaction',
                          value: lastDate,
                          icon: Icons.calendar_today_rounded,
                          iconColor: cs.secondary,
                        ),
                      ),
                      Gap(10.w),
                      Expanded(
                        child: SummaryCard(
                          label: 'Status',
                          value: member.membershipStatus,
                          icon: Icons.workspace_premium_rounded,
                          iconColor: AppColors.warning,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Monthly Spend (Last 6 Months)', style: AppTypography.sectionTitle),
                  Gap(12.h),
                  SpendChart(transactions: transactions, barWidth: 32),
                  Gap(20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recent Transactions', style: AppTypography.sectionTitle),
                      TextButton(
                        onPressed: onSeeAll,
                        child: Text('See All', style: AppTypography.captionMedium.copyWith(color: cs.primary)),
                      ),
                    ],
                  ),
                  Gap(8.h),
                  ...recentTiles,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String msg) {
    final cs = context.colorScheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48.sp, color: cs.error),
            Gap(12.h),
            Text(
              msg,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(color: cs.onSurface.withValues(alpha: 0.6)),
            ),
            Gap(16.h),
            ElevatedButton(
              onPressed: () => context.read<DashboardBloc>().add(const DashboardEvent.loadDashboard()),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
