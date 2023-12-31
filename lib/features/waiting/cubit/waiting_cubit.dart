import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/model/InvitationDataModel.dart';

part 'waiting_state.dart';

class WaitingCubit extends Cubit<WaitingState> {
  WaitingCubit() : super(WaitingInitial());
  List<Invitee> invitees=[];
  List<Invitee> inviteess=[];
  void setdata(InvitationModel homeListItemModel) {
    invitees=homeListItemModel.all_waiting;
    inviteess.addAll(homeListItemModel.all_waiting);

    emit(WaitingLoaded());
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
    emit(WaitingLoaded());

  }
}
