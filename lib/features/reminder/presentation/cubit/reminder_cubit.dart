import 'package:bloc/bloc.dart';
import 'package:daeawt/core/model/InvitationDataModel.dart';
import 'package:daeawt/core/remote/service.dart';
import 'package:meta/meta.dart';

part 'reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  List<Invitee> invitees=[];
  List<Invitee> inviteess=[];
  ReminderCubit(this.api) : super(ReminderInitial());
  ServiceApi api ;

  void setdata(InvitationModel homeListItemModel) {
    invitees=homeListItemModel.invitees;
    inviteess.addAll(homeListItemModel.invitees);

    emit(RemiderLoaded());
  }

  void changevalue(int index) {
    Invitee invitee=invitees.elementAt(index);
    invitee.isselected=!invitee.isselected;
    invitees.removeAt(index);
    invitees.insert(index, invitee);
    emit(RemiderLoaded());
  }

  void changeall() {
    for(int i=0;i<invitees.length;i++){
      invitees.elementAt(i).isselected=!invitees.elementAt(i).isselected;
    }
    emit(RemiderLoaded());
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
    emit(RemiderLoaded());

  }
}
