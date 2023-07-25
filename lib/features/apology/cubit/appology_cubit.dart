import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/model/InvitationDataModel.dart';

part 'appology_state.dart';

class AppologyCubit extends Cubit<AppologyState> {
  AppologyCubit() : super(AppologyInitial());
  List<Invitee> invitees=[];
  List<Invitee> inviteess=[];
  void setdata(InvitationModel homeListItemModel) {
    invitees=homeListItemModel.all_apologized;
    inviteess.addAll(homeListItemModel.all_apologized);

    emit(AppologyLoaded());
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
    emit(AppologyLoaded());

  }
}
