import 'package:bloc/bloc.dart';
import 'package:daeawt/core/remote/service.dart';
import 'package:meta/meta.dart';

part 'invited_state.dart';

class InvitedCubit extends Cubit<InvitedState> {
  InvitedCubit(this.api) : super(InvitedInitial());
  ServiceApi api;
}
