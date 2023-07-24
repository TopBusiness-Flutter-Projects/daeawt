import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'scanned_state.dart';

class ScannedCubit extends Cubit<ScannedState> {
  ScannedCubit() : super(ScannedInitial());
}
