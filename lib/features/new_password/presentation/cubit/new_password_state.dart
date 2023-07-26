part of 'new_password_cubit.dart';

@immutable
abstract class NewPasswordState {}

class NewPasswordInitial extends NewPasswordState {}
class NewPasswordLoadingState extends NewPasswordState {}
class NewPasswordSuccessState extends NewPasswordState {}
class NewPasswordFailureState extends NewPasswordState {}
