import 'package:flutter/material.dart';
import 'package:hdi_test/core/theme/app_typography.dart';
import 'package:hdi_test/utils/extensions/build_context_extension.dart';

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
