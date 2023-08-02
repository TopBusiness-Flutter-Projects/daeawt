import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/model/InvitationDataModel.dart';

part 'scanned_state.dart';

class ScannedCubit extends Cubit<ScannedState> {
  ScannedCubit() : super(ScannedInitial());
  List<Invitee> invitees=[];
  List<Invitee> inviteess=[];
  void setdata(InvitationModel homeListItemModel) {
    invitees=homeListItemModel.all_scanned;
    inviteess.addAll(homeListItemModel.all_scanned);

    emit(ScannedLoaded());
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
    emit(ScannedLoaded());

  }
}
