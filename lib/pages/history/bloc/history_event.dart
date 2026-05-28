part of 'history_bloc.dart';

@freezed
abstract class HistoryEvent with _$HistoryEvent {
  const factory HistoryEvent.loadHistory() = LoadHistory;
  const factory HistoryEvent.filterChanged({
    DateTime? selectedMonth,
    TransactionStatus? selectedStatus,
    TransactionCategory? selectedCategory,
  }) = FilterChanged;
}
