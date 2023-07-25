import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:meta/meta.dart';
import '../../../core/model/InvitationDataModel.dart';
import '../../../core/remote/service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {

  HomeCubit(this.api) : super(HomeInitial()){
    geInvitationsHome();
  }

  final ServiceApi api;
  List<InvitationModel> invitationsList = [];

  TextEditingController searchController=TextEditingController();












  geInvitationsHome() async {
    //  print("ddldlldld0");
    // print(selectedIndividualType);
    invitationsList.clear();
    emit(InvitationsHomeLoading());
    final response = await api.getInvitationHome(searchController.value.text);
    response.fold(
          (l) => emit(InvitationsHomeError()),
          (r) {
            invitationsList = r.data;
        emit(InvitationsHomeLoaded());
      },
    );
  }

}
