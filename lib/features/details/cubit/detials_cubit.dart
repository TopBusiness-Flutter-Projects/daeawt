import 'package:bloc/bloc.dart';
import 'package:daeawt/core/model/InvitationDataModel.dart';
import 'package:daeawt/core/remote/service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/appwidget.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/toast_message_method.dart';
import '../../home/cubit/home_cubit.dart';

part 'detials_state.dart';

class DetailsCubit extends Cubit<DetialsState> {
  InvitationModel? homeListItemModel;


  DetailsCubit(this.api) : super(DetialsInitial());



  ServiceApi api ;
  List<String> detailsIconsList = [ImageAssests.messagesIcon,ImageAssests.invitedIcon,
    ImageAssests.scannedIcon,ImageAssests.confirmedIcon,ImageAssests.apologiesIcon,
    ImageAssests.waitingIcon,ImageAssests.notSentIcon,ImageAssests.failedIcon];

  List<String> detailsLabels = [AppStrings.theMessage,AppStrings.invited,AppStrings.scanned,
    AppStrings.confirmation,AppStrings.apologies,AppStrings.wait,AppStrings.notSent,AppStrings.failed];
  bool isBottomDetailsWidgetVisible = true; //TODO-->

  List<String> detailsdata = [];
  visibleBottomDetailsWidget(){
    isBottomDetailsWidgetVisible = !isBottomDetailsWidgetVisible;
    emit(ChangingBottomDetailsVisibleState());
  }


  void setdata(InvitationModel homeListItemModel) {
    this.homeListItemModel=homeListItemModel;
    emit(DetialsLoading());
    detailsdata.clear();
    detailsdata.add(homeListItemModel.messages.toString());
    detailsdata.add(homeListItemModel.invitees.length.toString());
    detailsdata.add(homeListItemModel.scanned.toString());
    detailsdata.add(homeListItemModel.confirmed.toString());
    detailsdata.add(homeListItemModel.apologized.toString());
    detailsdata.add(homeListItemModel.waiting.toString());
    detailsdata.add(homeListItemModel.notSent.toString());
    detailsdata.add(homeListItemModel.failed.toString());
    emit(DetialsLoaded());

  }

  void delete(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    final response = await api.deleteinvitation(homeListItemModel!.id);
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
