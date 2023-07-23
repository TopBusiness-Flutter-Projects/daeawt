import 'package:bloc/bloc.dart';
import 'package:daeawt/core/remote/service.dart';
import 'package:meta/meta.dart';

part 'reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  ReminderCubit(this.api) : super(ReminderInitial());
  ServiceApi api ;
}
