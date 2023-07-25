import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/appwidget.dart';
import '../../../core/utils/toast_message_method.dart';
import '../model/register_model.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  RegisterModel registerModel = RegisterModel();
bool isLoginValid=false;
  final ServiceApi api;
  SignupCubit(this.api) : super(SignupInitial());

  void checkValidLoginData() {
    if (registerModel.isDataValid()) {
      isLoginValid = true;
      emit(OnRegisterVaild());
    } else {
      isLoginValid = false;

      emit(OnRegisterVaildFaild());
    }
  }
  void register(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    final response = await api.registerUser(registerModel);
    response.fold(
          (failure) => {

            Navigator.pop(context), emit(RegisterFailure())},
          (loginModel) {
            print("------------------ ${loginModel.code}");
        if (loginModel.code == 409 || loginModel.code == 410 ) {
          Navigator.pop(context);
          toastMessage("exists_email".tr(), context);
          // errorGetBar(translateText(AppStrings.noEmailError, context));
          emit(RegisterFailure());
        } else if (loginModel.code == 200) {
          Navigator.pop(context);
          Preferences.instance.setUser(loginModel).then((value) {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.homeRoute, (route) => false);
            // emit(OnLoginSuccess(response));
          });
        }
      },
    );
  }

}
