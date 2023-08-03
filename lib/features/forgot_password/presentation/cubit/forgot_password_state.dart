part of 'forgot_password_cubit.dart';

@immutable
abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}
class ResetPasswordLoading extends ForgotPasswordState {}
class ResetPasswordFailure extends ForgotPasswordState {}
class ResetPasswordSuccess extends ForgotPasswordState {}
class InvalidEmailState extends ForgotPasswordState {}
class verificationFailed extends ForgotPasswordState {}
class OnSmsCodeSent extends ForgotPasswordState {}
