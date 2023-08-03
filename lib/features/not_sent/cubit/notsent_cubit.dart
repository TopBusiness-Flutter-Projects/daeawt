import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/model/InvitationDataModel.dart';

part 'notsent_state.dart';

class NotsentCubit extends Cubit<NotsentState> {
  NotsentCubit() : super(NotsentInitial());
  List<Invitee> invitees=[];
  List<Invitee> inviteess=[];
  void setdata(InvitationModel homeListItemModel) {
    invitees=homeListItemModel.all_not_sent;
    inviteess.addAll(homeListItemModel.all_not_sent);

    emit(NotSendLoaded());
  }
  onSearchTextChanged(String text) async {
    invitees.clear();

    print("dlflfllf");
    print(inviteess.length);
    if(text.isEmpty){
      invitees.addAll(inviteess);
    }
    else{
      for (Invitee userDetail in inviteess) {
        print(text+"dddd");

        if (userDetail.name.toLowerCase().contains(text.toLowerCase()))
          invitees.add(userDetail);
      }
    }
    emit(NotSendLoaded());

  }
}
