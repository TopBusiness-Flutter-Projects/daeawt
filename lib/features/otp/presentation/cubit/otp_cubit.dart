import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../core/remote/service.dart';
import '../../../../core/utils/appwidget.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this.api) : super(OtpInitial());
  ServiceApi api;
  TextEditingController pinCode = TextEditingController();

  checkCode(BuildContext context) async {

     // emit(ResetPasswordLoading());
      AppWidget.createProgressDialog(context, "Loading");
      final response = await api.postCheckCode(pinCode.text);

      response.fold(
            //  (l) => emit(ResetPasswordFailure()),
              (r) {
       // resetPasswordModel = r;

        // if (resetPasswordModel.code == 200) {
        //   Navigator.pushNamed(context, Routes.otpRoute);
        //   emit(ResetPasswordSuccess());
        // }

        // if (resetPasswordModel.code == 422) {
        //   emit(InvalidEmailState());
        // }
        // else {
        //  // emit(ResetPasswordFailure());
        // }
      }
      );
    }

}
