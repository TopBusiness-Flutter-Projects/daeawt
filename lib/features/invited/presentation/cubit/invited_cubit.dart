import 'package:bloc/bloc.dart';
import 'package:daeawt/core/remote/service.dart';
import 'package:meta/meta.dart';

import '../../../../core/model/InvitationDataModel.dart';

part 'invited_state.dart';

class InvitedCubit extends Cubit<InvitedState> {
  InvitedCubit(this.api) : super(InvitedInitial());
  ServiceApi api;
  List<Invitee> invitees=[];
  List<Invitee> inviteess=[];
  void setdata(InvitationModel homeListItemModel) {
    invitees=homeListItemModel.invitees;
    inviteess.addAll(homeListItemModel.invitees);

    emit(InvitedLoaded());
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
    emit(InvitedLoaded());

  }

}
