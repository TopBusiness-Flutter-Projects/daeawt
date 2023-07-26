import 'package:bloc/bloc.dart';
import 'package:daeawt/core/remote/service.dart';
import 'package:daeawt/core/utils/appwidget.dart';
import 'package:daeawt/features/otp/presentation/cubit/otp_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:meta/meta.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/model/reset_password_model.dart';

part 'new_password_state.dart';

class NewPasswordCubit extends Cubit<NewPasswordState> {
  NewPasswordCubit(this.api) : super(NewPasswordInitial());
  ServiceApi api;
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();
  ResetPasswordModel resetPasswordModel = ResetPasswordModel();

  resetPassword(BuildContext context) async {
    emit(NewPasswordLoadingState());
    AppWidget.createProgressDialog(context, "Loading");

    final response = await api.postPasswordReset(passwordController.text, passwordConfirmationController.text, codeVerify);
    print("++++++++++++++++++++++++++++++++++++++++");
    print(passwordController.text);
    print(passwordConfirmationController.text);
    print(codeVerify);
    response.fold((l) => emit(NewPasswordFailureState()),
            (r) {
          resetPasswordModel = r;

          if (resetPasswordModel.code==200) {
            print("successsssssssssssssssssssssssssssssssssss");
            Navigator.pop(context);
            emit(NewPasswordSuccessState());
            Navigator.pushNamed(context, Routes.loginRoute);
          }

           else {
             print("failureeeeeeeeeeeeeeeeeeeeeeeeeeee");
            Navigator.pop(context);
            emit(NewPasswordFailureState());
          }
        });
  }
}
