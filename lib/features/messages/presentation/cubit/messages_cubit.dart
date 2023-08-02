import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/model/InvitationDataModel.dart';
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
  List<Invitee> invitees=[];
  List<Invitee> inviteess=[];
  void setdata(InvitationModel homeListItemModel) {
    invitees=homeListItemModel.invitees_messages;
    inviteess.addAll(homeListItemModel.invitees_messages);

    emit(MessageLoaded());
  }
  onSearchTextChanged(String text) async {
    invitees.clear();

    print("dlflfllf");
    print(inviteess.length);
    for (Invitee userDetail in inviteess) {
      print(text+"dddd");
      if (userDetail.name.toLowerCase().contains(text.toLowerCase()) )
        invitees.add(userDetail);
    }
    emit(MessageLoaded());

  }
}
