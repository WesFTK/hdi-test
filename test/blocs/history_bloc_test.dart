import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hdi_test/models/transaction_model.dart';
import 'package:hdi_test/pages/history/bloc/history_bloc.dart';
import 'package:hdi_test/repositories/transaction_repository.dart';
import 'package:hdi_test/utils/enums/status_state.dart';
import 'package:hdi_test/utils/enums/transaction_category.dart';
import 'package:hdi_test/utils/enums/transaction_status.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

class MockTransactionRepository extends Mock implements TransactionRepository {}

final List<TransactionModel> _fixtures = [
  TransactionModel(
    id: 'T1',
    date: DateTime(2026, 5, 10),
    category: TransactionCategory.food,
    amount: 100000,
    status: TransactionStatus.paid,
    description: 'Grocery',
  ),
  TransactionModel(
    id: 'T2',
    date: DateTime(2026, 5, 20),
    category: TransactionCategory.electronics,
    amount: 500000,
    status: TransactionStatus.pending,
    description: 'Gadget',
  ),
  TransactionModel(
    id: 'T3',
    date: DateTime(2026, 4, 5),
    category: TransactionCategory.food,
    amount: 75000,
    status: TransactionStatus.paid,
    description: 'Snacks',
  ),
];

void main() {
  late MockTransactionRepository mockRepo;

  setUp(() {
    mockRepo = MockTransactionRepository();
    when(() => mockRepo.getTransactions())
        .thenAnswer((_) async => Success(_fixtures));
  });

  HistoryBloc buildBloc() => HistoryBloc(transactionRepository: mockRepo);

  group('HistoryBloc — LoadHistory', () {
    blocTest<HistoryBloc, HistoryState>(
      'emits loading then loaded with all transactions',
      build: buildBloc,
      act: (bloc) => bloc.add(const HistoryEvent.loadHistory()),
      expect: () => [
        const HistoryState(status: StatusState.loading),
        HistoryState(
          status: StatusState.loaded,
          allTransactions: _fixtures,
          filteredTransactions: _fixtures,
        ),
      ],
    );
  });

  group('HistoryBloc — FilterChanged', () {
    blocTest<HistoryBloc, HistoryState>(
      'filters by status: only paid transactions shown',
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const HistoryEvent.loadHistory());
        await Future.delayed(Duration.zero);
        bloc.add(const HistoryEvent.filterChanged(
          selectedStatus: TransactionStatus.paid,
        ));
      },
      skip: 2,
      expect: () => [
        isA<HistoryState>().having(
          (s) => s.filteredTransactions.length,
          'filteredTransactions length',
          2,
        ),
      ],
    );

    blocTest<HistoryBloc, HistoryState>(
      'filters by category: only food transactions shown',
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const HistoryEvent.loadHistory());
        await Future.delayed(Duration.zero);
        bloc.add(const HistoryEvent.filterChanged(
          selectedCategory: TransactionCategory.food,
        ));
      },
      skip: 2,
      expect: () => [
        isA<HistoryState>().having(
          (s) => s.filteredTransactions.length,
          'filteredTransactions length',
          2,
        ),
      ],
    );

    blocTest<HistoryBloc, HistoryState>(
      'filters by month: only May 2026 transactions shown',
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const HistoryEvent.loadHistory());
        await Future.delayed(Duration.zero);
        bloc.add(HistoryEvent.filterChanged(
          selectedMonth: DateTime(2026, 5),
        ));
      },
      skip: 2,
      expect: () => [
        isA<HistoryState>().having(
          (s) => s.filteredTransactions.length,
          'filteredTransactions length',
          2,
        ),
      ],
    );

    blocTest<HistoryBloc, HistoryState>(
      'combined filters: May 2026 + paid = 1 result',
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const HistoryEvent.loadHistory());
        await Future.delayed(Duration.zero);
        bloc.add(HistoryEvent.filterChanged(
          selectedMonth: DateTime(2026, 5),
          selectedStatus: TransactionStatus.paid,
        ));
      },
      skip: 2,
      expect: () => [
        isA<HistoryState>().having(
          (s) => s.filteredTransactions.length,
          'filteredTransactions length',
          1,
        ),
      ],
    );

    blocTest<HistoryBloc, HistoryState>(
      'clearing all filters restores full list',
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const HistoryEvent.loadHistory());
        await Future.delayed(Duration.zero);
        bloc.add(const HistoryEvent.filterChanged(
          selectedStatus: TransactionStatus.paid,
        ));
        await Future.delayed(Duration.zero);
        bloc.add(const HistoryEvent.filterChanged());
      },
      skip: 3,
      expect: () => [
        isA<HistoryState>().having(
          (s) => s.filteredTransactions.length,
          'filteredTransactions length',
          3,
        ),
      ],
    );
  });
}
