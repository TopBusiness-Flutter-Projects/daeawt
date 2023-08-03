import 'package:bloc/bloc.dart';
import 'package:daeawt/config/routes/app_routes.dart';
import 'package:daeawt/core/model/reset_password_model.dart';
import 'package:daeawt/core/remote/service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/appwidget.dart';
import '../../../../core/utils/toast_message_method.dart';
import '../../../otp/presentation/cubit/otp_cubit.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this.api) : super(ForgotPasswordInitial());
  ServiceApi api;

  String? smsCode ;
  String? verificationId;
  int? resendToken;
 final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController phoneController = TextEditingController();
  ResetPasswordModel resetPasswordModel = ResetPasswordModel();


  resetPassword1(BuildContext context) async {
    emit(ResetPasswordLoading());
    AppWidget.createProgressDialog(context, "Loading");
    print(phoneController.text);
    final response = await api.forgotPassword(phoneController.text.replaceRange(0, 2, ""));


      response.fold((l) => emit(ResetPasswordFailure()),
              (r) async {
            resetPasswordModel = r;

            if (resetPasswordModel.code == 200) {
              Navigator.pop(context);
              codeVerify= phoneController.text.replaceRange(0, 2, "");
              authByPhone();

             emit(ResetPasswordSuccess());
            }

            else
            if (resetPasswordModel.message == "The given data was invalid.") {
               Navigator.pop(context);
           //    authByPhone();//todo-->

            } else {
              Navigator.pop(context);
          //    authByPhone();//todo-->

              emit(ResetPasswordFailure());
            }
          });
    }

    authByPhone(){

      auth.setSettings(forceRecaptchaFlow: true);
      auth.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        forceResendingToken: resendToken,
        verificationCompleted: (PhoneAuthCredential credential) {
          verificationId = credential.verificationId;
          smsCode = credential.smsCode;
          print("verificationId=>$verificationId");
          emit(OnSmsCodeSent());
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(verificationFailed());
          print("Errrrorrrrr : ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId = verificationId;
          this.resendToken = resendToken;
          print("verificationId=>${verificationId}");
          emit(OnSmsCodeSent());
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId = verificationId;
        },
      );
    }
  }

