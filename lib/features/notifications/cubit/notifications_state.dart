part of 'notifications_cubit.dart';

@immutable
abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}
class NotificationLoaded extends NotificationsState {}
class NotificationError extends NotificationsState {}
class NotificationLoading extends NotificationsState {}
