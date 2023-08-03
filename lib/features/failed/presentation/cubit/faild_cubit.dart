import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/model/InvitationDataModel.dart';

part 'faild_state.dart';

class FaildCubit extends Cubit<FaildState> {
  FaildCubit() : super(FaildInitial());
  List<Invitee> invitees=[];
  List<Invitee> inviteess=[];
  void setdata(InvitationModel homeListItemModel) {
    invitees=homeListItemModel.all_failed;
    inviteess.addAll(homeListItemModel.all_failed);

    emit(FaildLoaded());
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
    emit(FaildLoaded());

  }
}
