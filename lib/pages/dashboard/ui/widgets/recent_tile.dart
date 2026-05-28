import 'package:flutter/material.dart';
import 'package:hdi_test/core/theme/app_typography.dart';
import 'package:hdi_test/utils/extensions/build_context_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hdi_test/models/transaction_model.dart';
import 'package:hdi_test/utils/utils_function.dart';

class RecentTile extends StatelessWidget {
  final TransactionModel transaction;
  const RecentTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style:
                      AppTypography.tileTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(3.h),
                Text(
                  UtilsFunction.formatDate(transaction.date),
                  style:
                      context.textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant),
                ),
              ],
            ),
          ),
          Text(
            UtilsFunction.formatCurrency(transaction.amount),
            style: AppTypography.tileAmount,
          ),
        ],
      ),
    );
  }
}
