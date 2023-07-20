import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/appwidget.dart';
import '../../../core/utils/toast_message_method.dart';
import '../model/login_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginModel loginModel = LoginModel();
  bool isLoginValid=false;
  final ServiceApi api;

  LoginCubit(this.api) : super(LoginInitial());
  void login(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    final response = await api.postLogin(loginModel);
    response.fold(
          (failure) => {Navigator.pop(context), emit(LoginFailure())},
          (loginModel) {
        if (loginModel.code == 406||loginModel.code == 410) {
          Navigator.pop(context);
          toastMessage("invaild_email".tr(), context);
          // errorGetBar(translateText(AppStrings.noEmailError, context));
          emit(LoginLoaded());
        } else if (loginModel.code == 200) {
          Navigator.pop(context);
          Preferences.instance.setUser(loginModel).then((value) {
            Navigator.pushNamedAndRemoveUntil(context, Routes.homeRoute, (route) => false);
            // emit(OnLoginSuccess(response));
          });
        }
      },
    );
  }

  void checkValidLoginData() {
    if (loginModel.isDataValid()) {
      isLoginValid = true;
      emit(OnLoginVaild());
    } else {
      isLoginValid = false;

      emit(OnLoginVaildFaild());
    }
  }

}
