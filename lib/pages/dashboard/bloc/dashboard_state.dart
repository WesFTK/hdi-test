part of 'dashboard_bloc.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default(StatusState.idle) StatusState status,
    MemberModel? member,
    @Default([]) List<TransactionModel> transactions,
    String? errorMessage,
  }) = _DashboardState;
}
