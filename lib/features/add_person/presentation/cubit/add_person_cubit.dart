import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/model/InvitationDataModel.dart';

part 'add_person_state.dart';

class AddPersonCubit extends Cubit<AddPersonState> {
  AddPersonCubit() : super(AddPersonInitial());
  List<Invitee> invitees=[];
  List<Invitee> inviteess=[];
  void setdata(InvitationModel homeListItemModel) {
    invitees=homeListItemModel.invitees;
    inviteess.addAll(homeListItemModel.invitees);

    emit(PersonLoaded());
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
    emit(PersonLoaded());

  }
  incrementNumberOfInvitedPeople(int index) {
invitees.elementAt(index).inviteesNumber++;
print(";;;;;;;");
    emit(PersonLoaded());
  }

  decrementNumberOfInvitedPeople(int index) {
    if (invitees.elementAt(index).inviteesNumber <=
        0) {
      invitees.elementAt(index).inviteesNumber = 0;
    } else {
      invitees.elementAt(index).inviteesNumber--;
    }
    emit(PersonLoaded());
  }

}
