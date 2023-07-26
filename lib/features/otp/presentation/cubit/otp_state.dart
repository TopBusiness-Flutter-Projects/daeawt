part of 'otp_cubit.dart';

@immutable
abstract class OtpState {}

class OtpInitial extends OtpState {}
class CheckCodeFailure extends OtpState {}
class CheckCodeLoading extends OtpState {}
class CheckCodeSuccess extends OtpState {}
