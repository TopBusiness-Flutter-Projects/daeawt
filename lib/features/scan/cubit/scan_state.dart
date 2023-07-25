part of 'scan_cubit.dart';

@immutable
abstract class ScanState {}

class ScanInitial extends ScanState {}
class InvitationsSacanLoaded extends ScanState {}
class InvitationsSacanError extends ScanState {}
class InvitationsSacanLoading extends ScanState {}
