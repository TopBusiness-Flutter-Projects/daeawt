import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  ReminderCubit() : super(ReminderInitial());
}
