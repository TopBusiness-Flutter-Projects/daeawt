part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class OnLoginVaildFaild extends LoginState {}
class OnLoginVaild extends LoginState {}
