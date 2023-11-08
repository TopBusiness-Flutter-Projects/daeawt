part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class OnLoginVaildFaild extends LoginState {}
class OnLoginVaild extends LoginState {}
class LoginFailure extends LoginState {}
class LoginLoaded extends LoginState {}
class LoginWithGoogleLoading extends LoginState {}
class LoginWithGoogleFailure extends LoginState {}
class LoginWithGoogleSuccess extends LoginState {}
class LoginWithAppleFailure extends LoginState {}
class LoginWithAppleSuccess extends LoginState {}
class LoadingSignWithGoogle extends LoginState {}