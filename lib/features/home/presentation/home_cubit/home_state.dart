part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class SelectButtonChangingState extends HomeState {}
class SelectInvitationImageState extends HomeState {}
class ChangeWithBarcodeCheckListTileState extends HomeState {}
class ChangeWithSendingDateCheckListTileState extends HomeState {}
class ChangeLocationState extends HomeState {}
class LocationPermissionSuccessState extends HomeState {}
class LocationPermissionFailedState extends HomeState {}
