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
class RemoveSelectedContactState extends HomeState {}
class IncrementNumberOfInvitedPeopleState extends HomeState {}
class DecrementNumberOfInvitedPeopleState extends HomeState {}
class ChangingLanguageState extends HomeState {}
class ChangingApplicationLanguageState extends HomeState {}
class ChangingBottomDetailsVisibleState extends HomeState {}
class InvitationsHomeLoaded extends HomeState {}
class InvitationsHomeError extends HomeState {}
class InvitationsHomeLoading extends HomeState {}
