import 'package:flutter/material.dart';
import 'package:hdi_test/core/theme/app_typography.dart';
import 'package:hdi_test/utils/extensions/build_context_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterChipItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterChipItem({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? cs.primary : cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          label,
          style: (isSelected ? AppTypography.badge : context.textTheme.bodySmall)
              ?.copyWith(color: isSelected ? cs.onPrimary : cs.onSurfaceVariant),
        ),
      ),
    );
  }
}
