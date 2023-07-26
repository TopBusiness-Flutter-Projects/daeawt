part of 'edit_profile_cubit.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}
class OnEditProfileVaildFaild extends EditProfileState {}
class OnEditProfileVaild extends EditProfileState {}
class AddProfilePickImageSuccess extends EditProfileState {}
class EditProfileFailure extends EditProfileState {}
