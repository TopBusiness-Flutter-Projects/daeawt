part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ChangingApplicationLanguageState extends ProfileState {}
class OnUserDataVaild extends ProfileState {}
class SettingHomeError extends ProfileState {}
class SettingLoaded extends ProfileState {}
