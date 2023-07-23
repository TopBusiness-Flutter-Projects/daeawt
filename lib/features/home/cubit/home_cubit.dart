import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:daeawt/core/utils/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../core/model/InvitationDataModel.dart';
import '../../../core/remote/service.dart';
import '../models/contact_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ServiceApi api;
  List<InvitationModel> invitationsList = [];

  TextEditingController searchController=TextEditingController();
  HomeCubit(this.api) : super(HomeInitial()){
    geInvitationsHome();
  }











  String englishSymbol = "En";
  String arabicSymbol = "ع";
  bool isEnglish = true;









  changeApplicationLanguage(BuildContext context){
    Locale appLocale = Localizations.localeOf(context);

    if(appLocale==Locale("ar")){

      EasyLocalization.of(context)?.setLocale(Locale('en', ''));
      emit(ChangingApplicationLanguageState());
    }
    else if (appLocale==Locale("en")){

      EasyLocalization.of(context)?.setLocale(Locale('ar', ''));
      emit(ChangingApplicationLanguageState());
    }


    Phoenix.rebirth(context);


  }


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
