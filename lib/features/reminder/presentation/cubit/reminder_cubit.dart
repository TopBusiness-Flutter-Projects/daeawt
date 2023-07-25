import 'package:bloc/bloc.dart';
import 'package:daeawt/core/model/InvitationDataModel.dart';
import 'package:daeawt/core/remote/service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/appwidget.dart';
import '../../../../core/utils/toast_message_method.dart';
import '../../../home/cubit/home_cubit.dart';

part 'reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  List<Invitee> invitees=[];
  List<Invitee> inviteess=[];
  List<Invitee> selectedinvitee=[];

  InvitationModel? homeListItemModel;

  ReminderCubit(this.api) : super(ReminderInitial());
  ServiceApi api ;

  void setdata(InvitationModel homeListItemModel) {
    this.homeListItemModel=homeListItemModel;
    invitees=homeListItemModel.invitees;
    inviteess.addAll(homeListItemModel.invitees);

    emit(RemiderLoaded());
  }

  void changevalue(int index) {
    Invitee invitee=invitees.elementAt(index);
    invitee.isselected=!invitee.isselected;
    invitees.removeAt(index);
    invitees.insert(index, invitee);
    if(invitee.isselected==true){
      if(!selectedinvitee.contains(invitee)){
        selectedinvitee.add(invitee);
      }
    }
    else{
      if(selectedinvitee.contains(invitee)){
        selectedinvitee.remove(invitee);
      }
    }
    emit(RemiderLoaded());
  }

  void changeall() {
    for(int i=0;i<invitees.length;i++){
      invitees.elementAt(i).isselected=!invitees.elementAt(i).isselected;
    }
    if(invitees.elementAt(0).isselected==true){
      selectedinvitee.clear();
      selectedinvitee.addAll(invitees);
    }
    else{
      selectedinvitee.clear();
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
  void sendReminder(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    final response = await api.sendReminder(selectedinvitee,homeListItemModel!.id);
    response.fold(
          (failure) =>
      {Navigator.pop(context), toastMessage("fail send".tr(), context)},
          (loginModel) {
        if (loginModel.code == 200) {
          Navigator.pop(context);
          context.read<HomeCubit>().geInvitationsHome();
          Navigator.pushNamed(context, Routes.homeRoute);
        } else {
          toastMessage("fail send".tr(), context);
        }
      },
    );
  }

}
