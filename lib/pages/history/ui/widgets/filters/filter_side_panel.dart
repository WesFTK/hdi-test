import 'package:flutter/material.dart';
import 'package:hdi_test/core/theme/app_typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hdi_test/pages/history/bloc/history_bloc.dart';
import 'package:hdi_test/pages/history/ui/widgets/filters/filter_chip_item.dart';
import 'package:hdi_test/pages/history/ui/widgets/filters/filter_section_label.dart';
import 'package:hdi_test/utils/enums/transaction_category.dart';
import 'package:hdi_test/utils/enums/transaction_status.dart';
import 'package:hdi_test/utils/utils_function.dart';

class FilterSidePanel extends StatelessWidget {
  final HistoryBloc bloc;
  final DateTime? selectedMonth;
  final TransactionStatus? selectedStatus;
  final TransactionCategory? selectedCategory;

  const FilterSidePanel({
    super.key,
    required this.bloc,
    required this.selectedMonth,
    required this.selectedStatus,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final months = List.generate(6, (i) => DateTime(now.year, now.month - (5 - i), 1));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Filters', style: AppTypography.sectionTitle),
        Gap(20.h),
        const FilterSectionLabel(label: 'Month'),
        Gap(8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            FilterChipItem(
              label: 'All',
              isSelected: selectedMonth == null,
              onTap: () => bloc.add(HistoryEvent.filterChanged(
                selectedStatus: selectedStatus,
                selectedCategory: selectedCategory,
              )),
            ),
            ...months.map((m) => FilterChipItem(
                  label: UtilsFunction.formatDate(m, pattern: 'MMM yy'),
                  isSelected: selectedMonth != null &&
                      selectedMonth!.year == m.year &&
                      selectedMonth!.month == m.month,
                  onTap: () => bloc.add(HistoryEvent.filterChanged(
                    selectedMonth: m,
                    selectedStatus: selectedStatus,
                    selectedCategory: selectedCategory,
                  )),
                )),
          ],
        ),
        Gap(20.h),
        const FilterSectionLabel(label: 'Status'),
        Gap(8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            FilterChipItem(
              label: 'All',
              isSelected: selectedStatus == null,
              onTap: () => bloc.add(HistoryEvent.filterChanged(
                selectedMonth: selectedMonth,
                selectedCategory: selectedCategory,
              )),
            ),
            ...TransactionStatus.values.map((s) => FilterChipItem(
                  label: s.label,
                  isSelected: selectedStatus == s,
                  onTap: () => bloc.add(HistoryEvent.filterChanged(
                    selectedMonth: selectedMonth,
                    selectedStatus: s == selectedStatus ? null : s,
                    selectedCategory: selectedCategory,
                  )),
                )),
          ],
        ),
        Gap(20.h),
        const FilterSectionLabel(label: 'Category'),
        Gap(8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            FilterChipItem(
              label: 'All',
              isSelected: selectedCategory == null,
              onTap: () => bloc.add(HistoryEvent.filterChanged(
                selectedMonth: selectedMonth,
                selectedStatus: selectedStatus,
              )),
            ),
            ...TransactionCategory.values.map((c) => FilterChipItem(
                  label: c.label,
                  isSelected: selectedCategory == c,
                  onTap: () => bloc.add(HistoryEvent.filterChanged(
                    selectedMonth: selectedMonth,
                    selectedStatus: selectedStatus,
                    selectedCategory: c == selectedCategory ? null : c,
                  )),
                )),
          ],
        ),
      ],
    );
  }
}
