part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}
class OnRegisterVaildFaild extends SignupState {}
class OnRegisterVaild extends SignupState {}
class RegisterFailure extends SignupState {}

class RegisterWithGoogleFailure extends SignupState {}
class RegisterWithGoogleSuccess extends SignupState {}
class RegisterWithGoogleLoading extends SignupState {}
