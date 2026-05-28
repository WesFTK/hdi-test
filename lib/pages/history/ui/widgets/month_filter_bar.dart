import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hdi_test/pages/history/ui/widgets/filter_chip_item.dart';
import 'package:hdi_test/utils/utils_function.dart';

class MonthFilterBar extends StatelessWidget {
  final DateTime? selected;
  final ValueChanged<DateTime?> onChanged;

  const MonthFilterBar({super.key, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final months = List.generate(6, (i) => DateTime(now.year, now.month - (5 - i), 1));

    return SizedBox(
      height: 34.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          FilterChipItem(label: 'All', isSelected: selected == null, onTap: () => onChanged(null)),
          ...months.map(
            (m) => FilterChipItem(
              label: UtilsFunction.formatDate(m, pattern: 'MMM yy'),
              isSelected: selected != null && selected!.year == m.year && selected!.month == m.month,
              onTap: () => onChanged(m),
            ),
          ),
        ],
      ),
    );
  }
}
