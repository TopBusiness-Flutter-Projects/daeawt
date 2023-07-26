import 'package:bloc/bloc.dart';
import 'package:daeawt/core/model/check_code_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/remote/service.dart';
import '../../../../core/utils/appwidget.dart';

part 'otp_state.dart';
String codeVerify = "";
class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this.api) : super(OtpInitial());
  ServiceApi api;
  TextEditingController pinCode = TextEditingController();
  CheckCodeModel checkCodeModel = CheckCodeModel();


  checkCode(BuildContext context) async {

      emit(CheckCodeLoading());
      AppWidget.createProgressDialog(context, "Loading");
      final response = await api.postCheckCode(pinCode.text);

      response.fold(
             (l) => emit(CheckCodeLoading()),
              (r) {
              checkCodeModel = r ;
              if(checkCodeModel.code==200){
                emit(CheckCodeSuccess());
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, Routes.newPasswordRoute);
                codeVerify = checkCodeModel.verifyCode!;

              }
              else{
                Navigator.pop(context);
                emit(CheckCodeFailure());
              }


      }
      );
    }

}
