import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hdi_test/models/member_model.dart';
import 'package:hdi_test/models/transaction_model.dart';
import 'package:hdi_test/pages/dashboard/repository/dashboard_repository.dart';
import 'package:hdi_test/utils/enums/status_state.dart';

part 'dashboard_bloc.freezed.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final MemberRepository _memberRepository;
  final TransactionRepository _transactionRepository;

  DashboardBloc({required MemberRepository memberRepository, required TransactionRepository transactionRepository})
      : _memberRepository = memberRepository,
        _transactionRepository = transactionRepository,
        super(const DashboardState()) {
    on<DashboardEvent>(_onEvent);
  }

  Future<void> _onEvent(DashboardEvent event, Emitter<DashboardState> emit) async {
    await event.when(
      loadDashboard: () => _onLoadDashboard(emit),
    );
  }

  Future<void> _onLoadDashboard(Emitter<DashboardState> emit) async {
    emit(state.copyWith(status: StatusState.loading, errorMessage: null));
    final memberResult = await _memberRepository.getMember();
    final txResult = await _transactionRepository.getTransactions();

    memberResult.fold(
      (member) => txResult.fold(
        (transactions) => emit(state.copyWith(status: StatusState.loaded, member: member, transactions: transactions)),
        (failure) => emit(state.copyWith(status: StatusState.error, errorMessage: failure.toString())),
      ),
      (failure) => emit(state.copyWith(status: StatusState.error, errorMessage: failure.toString())),
    );
  }
}
