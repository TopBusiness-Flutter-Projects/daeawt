part of 'messages_cubit.dart';

@immutable
abstract class MessagesState {}

class MessagesInitial extends MessagesState {}
class ChangingVisibilityState extends MessagesState {}
