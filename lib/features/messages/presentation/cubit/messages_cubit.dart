import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/remote/service.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit( this.api) : super(MessagesInitial());
  ServiceApi api;
  bool isVisible = false;
  changeVisibility(){
    isVisible = !isVisible;
    emit(ChangingVisibilityState());
  }
}
