part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}




class InvitationsHomeLoaded extends HomeState {}
class InvitationsHomeError extends HomeState {}
class InvitationsHomeLoading extends HomeState {}
class OnUserDataVaild extends HomeState {}
