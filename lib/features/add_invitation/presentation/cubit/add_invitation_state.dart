part of 'add_invitation_cubit.dart';

@immutable
abstract class AddInvitationState {}

class AddInvitationInitial extends AddInvitationState {}
class SelectInvitationImageState extends AddInvitationState {}
class ChangeWithBarcodeCheckListTileState extends AddInvitationState {}
class ChangeWithSendingDateCheckListTileState extends AddInvitationState {}
class SelectButtonChangingState extends AddInvitationState {}
class IncrementNumberOfInvitedPeopleState extends AddInvitationState {}
class DecrementNumberOfInvitedPeopleState extends AddInvitationState {}
class RemoveSelectedContactState extends AddInvitationState {}
class LocationPermissionSuccessState extends AddInvitationState {}
class LocationPermissionFailedState extends AddInvitationState {}
class ChangeLocationState extends AddInvitationState {}
class ChangingLanguageState extends AddInvitationState {}
class InvitationDateSelected extends AddInvitationState {}
class InvitationVaild extends AddInvitationState {}
class CameraMoveState extends AddInvitationState {}
