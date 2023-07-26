import 'package:bloc/bloc.dart';
import 'package:daeawt/config/routes/app_routes.dart';
import 'package:daeawt/core/model/reset_password_model.dart';
import 'package:daeawt/core/remote/service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/appwidget.dart';
import '../../../../core/utils/toast_message_method.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this.api) : super(ForgotPasswordInitial());
  ServiceApi api;


  TextEditingController emailController = TextEditingController();
  ResetPasswordModel resetPasswordModel = ResetPasswordModel();



  resetPassword1(BuildContext context) async {
    emit(ResetPasswordLoading());
    AppWidget.createProgressDialog(context, "Loading");
    print(emailController.text);
    final response = await api.forgotPassword(emailController.text);

    response.fold((l) => emit(ResetPasswordFailure()),
            (r) {
      resetPasswordModel = r;

      if (resetPasswordModel.code==200) {
        Navigator.pop(context);
        emit(ResetPasswordSuccess());
      }

    else  if (resetPasswordModel.message == "The given data was invalid.") {
        Navigator.pop(context);
        // toastMessage("Invalid Email".tr(), context);
        emit(InvalidEmailState());
      } else {
        Navigator.pop(context);
        emit(ResetPasswordFailure());
      }
    });
  }


}
