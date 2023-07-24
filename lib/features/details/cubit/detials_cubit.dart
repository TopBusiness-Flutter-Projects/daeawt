import 'package:bloc/bloc.dart';
import 'package:daeawt/core/model/InvitationDataModel.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/app_strings.dart';
import '../../../core/utils/assets_manager.dart';

part 'detials_state.dart';

class DetailsCubit extends Cubit<DetialsState> {
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
  DetailsCubit() : super(DetialsInitial());

  void setdata(InvitationModel homeListItemModel) {
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


}
