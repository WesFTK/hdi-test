import 'package:flutter/material.dart';
import 'package:hdi_test/core/theme/app_typography.dart';
import 'package:hdi_test/utils/extensions/build_context_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hdi_test/pages/history/ui/widgets/filter_chip_item.dart';

class ChipFilterRow<T> extends StatelessWidget {
  final String label;
  final List<T> values;
  final T? selected;
  final String Function(T) labelOf;
  final ValueChanged<T?> onSelected;

  const ChipFilterRow({
    super.key,
    required this.label,
    required this.values,
    required this.selected,
    required this.labelOf,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;

    return SizedBox(
      height: 34.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Center(
              child: Text('$label:', style: AppTypography.badge.copyWith(color: cs.onSurfaceVariant)),
            ),
          ),
          FilterChipItem(label: 'All', isSelected: selected == null, onTap: () => onSelected(null)),
          ...values.map(
            (v) => FilterChipItem(
              label: labelOf(v),
              isSelected: selected == v,
              onTap: () => onSelected(v == selected ? null : v),
            ),
          ),
        ],
      ),
    );
  }
}
