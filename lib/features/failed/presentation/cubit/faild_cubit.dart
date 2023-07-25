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
    for (Invitee userDetail in inviteess) {
      print(text+"dddd");
      if (userDetail.name.contains(text) )
        invitees.add(userDetail);
    }
    emit(FaildLoaded());

  }
}
