import 'package:flutter/material.dart';
import 'package:hdi_test/core/theme/app_typography.dart';
import 'package:hdi_test/utils/extensions/build_context_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hdi_test/pages/history/bloc/history_bloc.dart';
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
    final months =
        List.generate(6, (i) => DateTime(now.year, now.month - (5 - i), 1));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Filters', style: AppTypography.sectionTitle),
        Gap(20.h),
        FilterSectionLabel(label: 'Month'),
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
        FilterSectionLabel(label: 'Status'),
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
        FilterSectionLabel(label: 'Category'),
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

class FilterSectionLabel extends StatelessWidget {
  final String label;
  const FilterSectionLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTypography.badge.copyWith(color: context.colorScheme.onSurfaceVariant),
    );
  }
}

class MonthFilterBar extends StatelessWidget {
  final DateTime? selected;
  final ValueChanged<DateTime?> onChanged;

  const MonthFilterBar({super.key, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final months =
        List.generate(6, (i) => DateTime(now.year, now.month - (5 - i), 1));

    return SizedBox(
      height: 34.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          FilterChipItem(
            label: 'All',
            isSelected: selected == null,
            onTap: () => onChanged(null),
          ),
          ...months.map((m) => FilterChipItem(
                label: UtilsFunction.formatDate(m, pattern: 'MMM yy'),
                isSelected: selected != null &&
                    selected!.year == m.year &&
                    selected!.month == m.month,
                onTap: () => onChanged(m),
              )),
        ],
      ),
    );
  }
}

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
              child: Text(
                '$label:',
                style: AppTypography.badge.copyWith(color: cs.onSurfaceVariant),
              ),
            ),
          ),
          FilterChipItem(
            label: 'All',
            isSelected: selected == null,
            onTap: () => onSelected(null),
          ),
          ...values.map((v) => FilterChipItem(
                label: labelOf(v),
                isSelected: selected == v,
                onTap: () => onSelected(v == selected ? null : v),
              )),
        ],
      ),
    );
  }
}

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
