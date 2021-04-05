part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class LoggedOut extends DashboardState {}

class DashboardGetRandomNumber extends DashboardState {
  final int currentRandomNumber;
  final int previousRandomNumber;

  DashboardGetRandomNumber(this.currentRandomNumber, this.previousRandomNumber);
}

class DashboardGenerateRandomNumberFailed extends DashboardState {
  final String message;

  DashboardGenerateRandomNumberFailed(this.message);
}
