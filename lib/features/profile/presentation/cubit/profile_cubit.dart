import 'package:bloc/bloc.dart';
import 'package:daeawt/core/remote/service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.api) : super(ProfileInitial());


ServiceApi api;
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
}
