part of 'history_bloc.dart';

@freezed
abstract class HistoryState with _$HistoryState {
  const factory HistoryState({
    @Default(StatusState.idle) StatusState status,
    @Default([]) List<TransactionModel> allTransactions,
    @Default([]) List<TransactionModel> filteredTransactions,
    DateTime? selectedMonth,
    TransactionStatus? selectedStatus,
    TransactionCategory? selectedCategory,
    String? errorMessage,
  }) = _HistoryState;
}
