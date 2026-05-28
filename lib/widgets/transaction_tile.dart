import 'package:flutter/material.dart';
import 'package:hdi_test/core/theme/app_typography.dart';
import 'package:hdi_test/utils/extensions/build_context_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hdi_test/core/theme/app_colors.dart';
import 'package:hdi_test/models/transaction_model.dart';
import 'package:hdi_test/utils/enums/transaction_category.dart';
import 'package:hdi_test/utils/enums/transaction_status.dart';
import 'package:hdi_test/utils/utils_function.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: _categoryColor(transaction.category).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              _categoryIcon(transaction.category),
              color: _categoryColor(transaction.category),
              size: 20.sp,
            ),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: AppTypography.tileTitle.copyWith(color: cs.onSurface),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(3.h),
                Row(
                  children: [
                    Text(
                      transaction.category.label,
                      style: context.textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant),
                    ),
                    Text(
                      ' · ',
                      style: context.textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant.withValues(alpha: 0.5)),
                    ),
                    Text(
                      UtilsFunction.formatDate(transaction.date),
                      style: context.textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap(8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatAmount(transaction.amount),
                style: AppTypography.tileAmount.copyWith(color: cs.onSurface),
              ),
              Gap(4.h),
              _StatusChip(status: transaction.status),
            ],
          ),
        ],
      ),
    );
  }

  String _formatAmount(double amount) => UtilsFunction.formatCurrency(amount);

  Color _categoryColor(TransactionCategory cat) {
    return switch (cat) {
      TransactionCategory.food          => AppColors.warning,
      TransactionCategory.electronics   => const Color(0xFF3B82F6),
      TransactionCategory.clothing      => const Color(0xFF8B5CF6),
      TransactionCategory.health        => AppColors.emerald500,
      TransactionCategory.entertainment => const Color(0xFFEC4899),
      TransactionCategory.travel        => const Color(0xFF06B6D4),
      TransactionCategory.other         => AppColors.grey500,
    };
  }

  IconData _categoryIcon(TransactionCategory cat) {
    return switch (cat) {
      TransactionCategory.food          => Icons.restaurant_rounded,
      TransactionCategory.electronics   => Icons.devices_rounded,
      TransactionCategory.clothing      => Icons.checkroom_rounded,
      TransactionCategory.health        => Icons.favorite_rounded,
      TransactionCategory.entertainment => Icons.movie_rounded,
      TransactionCategory.travel        => Icons.flight_rounded,
      TransactionCategory.other         => Icons.category_rounded,
    };
  }
}

class _StatusChip extends StatelessWidget {
  final TransactionStatus status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    final color = switch (status) {
      TransactionStatus.paid     => cs.tertiary,
      TransactionStatus.pending  => AppColors.warning,
      TransactionStatus.failed   => cs.error,
      TransactionStatus.refunded => cs.onSurfaceVariant,
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status.label,
        style: AppTypography.micro.copyWith(fontWeight: FontWeight.w600, color: color),
      ),
    );
  }
}
