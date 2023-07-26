import 'package:bloc/bloc.dart';
import 'package:daeawt/core/model/setting.dart';
import 'package:daeawt/core/model/user_model.dart';
import 'package:daeawt/core/remote/service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:meta/meta.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/preferences/preferences.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  UserModel? userModel;

  SettingDataModel ?setting;



  ProfileCubit(this.api) : super(ProfileInitial()){
    getUserData();
    getsetting();
  }


ServiceApi api;
  String englishSymbol = "En";
  String arabicSymbol = "ع";
  bool isEnglish = true;


  getUserData() async {
    userModel = await Preferences.instance.getUserModel();
    //  print("dldldl${userModel!.access_token}");
    emit(OnUserDataVaild());
  }
  getsetting() async {
    //  print("ddldlldld0");
    // print(selectedIndividualType);

    //emit(InvitationsHomeLoading());
    final response = await api.getSetting();
    response.fold(
          (l) => emit(SettingHomeError()),
          (r) {
        setting = r;
        emit(SettingLoaded());
      },
    );
  }







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
  deleteAccount(BuildContext context) async {
    final response = await api.deleteAccount();
    response.fold(

          (l) => emit(DeleteUserFailure()),
          (r) {
        Preferences.instance.clearUserData().then((value) {
          Navigator.pushNamedAndRemoveUntil(context, Routes.loginRoute,(route) {
            return true;
          },);
        });

        emit(DeleteUserSuccessfully());
      },


    );
  }

}
