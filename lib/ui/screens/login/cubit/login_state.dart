part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class PhoneNumberSubmit extends LoginState {}
class CodeSentSuccess extends LoginState {}
class LoginSuccess extends LoginState {}
class UserCancelled extends LoginState {}
class LoginFailed extends LoginState {
  final String message;

  LoginFailed(this.message);
}
class LoginTimeout extends LoginState {
  final String message;

  LoginTimeout(this.message);
}
