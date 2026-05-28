import 'package:hdi_test/models/transaction_model.dart';
import 'package:hdi_test/utils/enums/transaction_status.dart';
import 'package:intl/intl.dart';

class UtilsFunction {
  const UtilsFunction._();

  static String formatCurrency(double amount) =>
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(amount);

  static String formatCurrencyCompact(double amount) =>
      NumberFormat.compactCurrency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(amount);

  static String formatDate(DateTime date, {String pattern = 'dd MMM yyyy'}) => DateFormat(pattern).format(date);

  static double calcMonthPaid(List<TransactionModel> transactions, {DateTime? month}) {
    final target = month ?? DateTime.now();
    return transactions
        .where((t) => t.status == TransactionStatus.paid && t.date.year == target.year && t.date.month == target.month)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  static ({List<DateTime> months, List<double> amounts}) last6MonthsSpend(List<TransactionModel> transactions) {
    final now = DateTime.now();
    final months = List.generate(6, (i) => DateTime(now.year, now.month - (5 - i), 1));
    final amounts = months.map((m) => calcMonthPaid(transactions, month: m)).toList();
    return (months: months, amounts: amounts);
  }
}
