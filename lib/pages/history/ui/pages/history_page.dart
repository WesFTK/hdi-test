import 'package:flutter/material.dart';
import 'package:hdi_test/core/theme/app_typography.dart';
import 'package:hdi_test/utils/extensions/build_context_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hdi_test/pages/history/bloc/history_bloc.dart';
import 'package:hdi_test/pages/history/ui/widgets/history_filters.dart';
import 'package:hdi_test/pages/dashboard/repository/dashboard_repository.dart';
import 'package:hdi_test/utils/enums/status_state.dart';
import 'package:hdi_test/utils/enums/transaction_category.dart';
import 'package:hdi_test/utils/enums/transaction_status.dart';
import 'package:hdi_test/widgets/shimmer_box.dart';
import 'package:hdi_test/widgets/transaction_tile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) =>
          HistoryBloc(transactionRepository: ctx.read<TransactionRepository>())..add(const HistoryEvent.loadHistory()),
      child: const _HistoryView(),
    );
  }
}

class _HistoryView extends StatelessWidget {
  const _HistoryView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Purchase History')),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state.status == StatusState.loading || state.status == StatusState.idle) {
            return _buildShimmer(context);
          }
          if (state.status == StatusState.error) {
            return _buildError(context, state.errorMessage ?? 'Unknown error');
          }
          return _buildContent(
            context,
            state.filteredTransactions,
            state.selectedMonth,
            state.selectedStatus,
            state.selectedCategory,
          );
        },
      ),
    );
  }

  Widget _buildShimmer(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(20.r),
      itemCount: 6,
      itemBuilder: (_, _) => Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: ShimmerBox(height: 72.h, borderRadius: 14.r),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    List filtered,
    DateTime? month,
    TransactionStatus? status,
    TransactionCategory? category,
  ) {
    final bloc = context.read<HistoryBloc>();

    return ScreenTypeLayout.builder(
      mobile: (_) => _buildMobileContent(context, bloc, filtered, month, status, category),
      tablet: (_) => _buildTabletContent(context, bloc, filtered, month, status, category),
    );
  }

  Widget _buildMobileContent(
    BuildContext context,
    HistoryBloc bloc,
    List filtered,
    DateTime? month,
    TransactionStatus? status,
    TransactionCategory? category,
  ) {
    final cs = context.colorScheme;

    return Column(
      children: [
        Container(
          color: cs.surface,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MonthFilterBar(
                selected: month,
                onChanged: (v) => bloc.add(
                  HistoryEvent.filterChanged(selectedMonth: v, selectedStatus: status, selectedCategory: category),
                ),
              ),
              Gap(10.h),
              ChipFilterRow<TransactionStatus>(
                label: 'Status',
                values: TransactionStatus.values,
                selected: status,
                labelOf: (s) => s.label,
                onSelected: (v) => bloc.add(
                  HistoryEvent.filterChanged(selectedMonth: month, selectedStatus: v, selectedCategory: category),
                ),
              ),
              Gap(8.h),
              ChipFilterRow<TransactionCategory>(
                label: 'Category',
                values: TransactionCategory.values,
                selected: category,
                labelOf: (c) => c.label,
                onSelected: (v) => bloc.add(
                  HistoryEvent.filterChanged(selectedMonth: month, selectedStatus: status, selectedCategory: v),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: filtered.isEmpty
              ? _buildEmpty(context)
              : ListView.builder(
                  padding: EdgeInsets.all(16.r),
                  itemCount: filtered.length,
                  itemBuilder: (_, i) => TransactionTile(transaction: filtered[i]),
                ),
        ),
      ],
    );
  }

  Widget _buildTabletContent(
    BuildContext context,
    HistoryBloc bloc,
    List filtered,
    DateTime? month,
    TransactionStatus? status,
    TransactionCategory? category,
  ) {
    final cs = context.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            color: cs.surface,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.r),
              child: FilterSidePanel(
                bloc: bloc,
                selectedMonth: month,
                selectedStatus: status,
                selectedCategory: category,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: filtered.isEmpty
              ? _buildEmpty(context)
              : ListView.builder(
                  padding: EdgeInsets.all(16.r),
                  itemCount: filtered.length,
                  itemBuilder: (_, i) => TransactionTile(transaction: filtered[i]),
                ),
        ),
      ],
    );
  }

  Widget _buildEmpty(BuildContext context) {
    final cs = context.colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined, size: 56.sp, color: cs.onSurface.withValues(alpha: 0.2)),
          Gap(12.h),
          Text(
            'No transactions found',
            style: AppTypography.captionLarge.copyWith(color: cs.onSurface.withValues(alpha: 0.5)),
          ),
          Gap(4.h),
          Text(
            'Try adjusting the filters',
            style: AppTypography.captionMedium.copyWith(color: cs.onSurface.withValues(alpha: 0.35)),
          ),
        ],
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
              onPressed: () => context.read<HistoryBloc>().add(const HistoryEvent.loadHistory()),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
