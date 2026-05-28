import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hdi_test/core/theme/app_typography.dart';
import 'package:hdi_test/utils/extensions/build_context_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hdi_test/models/transaction_model.dart';
import 'package:hdi_test/utils/utils_function.dart';

class SpendChart extends StatelessWidget {
  final List<TransactionModel> transactions;
  final double? barWidth;
  const SpendChart({super.key, required this.transactions, this.barWidth});

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;

    final (:months, :amounts) = UtilsFunction.last6MonthsSpend(transactions);
    final maxVal = amounts.reduce((a, b) => a > b ? a : b);
    final chartMax = (maxVal > 0 ? maxVal * 1.3 : 1000000).toDouble();

    return Container(
      height: 200.h,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: BarChart(
        BarChartData(
          maxY: chartMax,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => cs.inverseSurface,
              getTooltipItem: (group, groupIdx, rod, rodIdx) {
                return BarTooltipItem(
                  'Rp ${UtilsFunction.formatCurrencyCompact(rod.toY)}',
                  AppTypography.chartTooltip.copyWith(color: cs.onInverseSurface),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final idx = value.toInt();
                  if (idx < 0 || idx >= months.length) {
                    return const SizedBox.shrink();
                  }
                  return Text(
                    UtilsFunction.formatDate(months[idx], pattern: 'MMM'),
                    style: AppTypography.micro.copyWith(color: cs.onSurfaceVariant),
                  );
                },
              ),
            ),
          ),
          gridData: FlGridData(
            drawVerticalLine: false,
            horizontalInterval: chartMax / 4,
            getDrawingHorizontalLine: (_) => FlLine(color: cs.outline.withValues(alpha: 0.8), strokeWidth: 1),
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(6, (i) {
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: amounts[i],
                  color: i == 5 ? cs.primary : cs.primary.withValues(alpha: 0.35),
                  width: barWidth ?? 20.w,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(6.r), topRight: Radius.circular(6.r)),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
