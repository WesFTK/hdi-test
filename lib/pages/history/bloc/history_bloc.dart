import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hdi_test/models/transaction_model.dart';
import 'package:hdi_test/pages/dashboard/repository/dashboard_repository.dart';
import 'package:hdi_test/utils/enums/status_state.dart';
import 'package:hdi_test/utils/enums/transaction_category.dart';
import 'package:hdi_test/utils/enums/transaction_status.dart';

part 'history_bloc.freezed.dart';
part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final TransactionRepository _transactionRepository;

  HistoryBloc({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository,
        super(const HistoryState()) {
    on<HistoryEvent>(_onEvent);
  }

  Future<void> _onEvent(HistoryEvent event, Emitter<HistoryState> emit) async {
    await event.when(
      loadHistory: () => _onLoadHistory(emit),
      filterChanged: (selectedMonth, selectedStatus, selectedCategory) =>
          _onFilterChanged(selectedMonth, selectedStatus, selectedCategory, emit),
    );
  }

  Future<void> _onLoadHistory(Emitter<HistoryState> emit) async {
    emit(state.copyWith(status: StatusState.loading, errorMessage: null));
    final result = await _transactionRepository.getTransactions();
    result.fold(
      (transactions) => emit(
        state.copyWith(status: StatusState.loaded, allTransactions: transactions, filteredTransactions: transactions),
      ),
      (failure) => emit(state.copyWith(status: StatusState.error, errorMessage: failure.toString())),
    );
  }

  Future<void> _onFilterChanged(
    DateTime? selectedMonth,
    TransactionStatus? selectedStatus,
    TransactionCategory? selectedCategory,
    Emitter<HistoryState> emit,
  ) async {
    if (state.status != StatusState.loaded) return;

    final filtered = state.allTransactions.where((t) {
      final matchMonth = selectedMonth == null ||
          (t.date.year == selectedMonth.year && t.date.month == selectedMonth.month);
      final matchStatus = selectedStatus == null || t.status == selectedStatus;
      final matchCategory = selectedCategory == null || t.category == selectedCategory;
      return matchMonth && matchStatus && matchCategory;
    }).toList();

    emit(
      state.copyWith(
        filteredTransactions: filtered,
        selectedMonth: selectedMonth,
        selectedStatus: selectedStatus,
        selectedCategory: selectedCategory,
      ),
    );
  }
}
