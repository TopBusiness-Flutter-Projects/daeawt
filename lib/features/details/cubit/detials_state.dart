part of 'detials_cubit.dart';

@immutable
abstract class DetialsState {}

class DetialsInitial extends DetialsState {}
class ChangingBottomDetailsVisibleState extends DetialsState {}
class DetialsLoaded extends DetialsState {}
class DetialsLoading extends DetialsState {}
