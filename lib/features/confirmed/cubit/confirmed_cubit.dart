import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/model/InvitationDataModel.dart';

part 'confirmed_state.dart';

class ConfirmedCubit extends Cubit<ConfirmedState> {
  ConfirmedCubit() : super(ConfirmedInitial());
  List<Invitee> invitees=[];
  List<Invitee> inviteess=[];
  void setdata(InvitationModel homeListItemModel) {
    invitees=homeListItemModel.all_confirmed;
    inviteess.addAll(homeListItemModel.all_confirmed);

    emit(ConfirmedLoaded());
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
    emit(ConfirmedLoaded());

  }
}
