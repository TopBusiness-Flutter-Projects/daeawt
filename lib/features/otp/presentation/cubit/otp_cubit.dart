import 'package:bloc/bloc.dart';
import 'package:daeawt/core/model/check_code_model.dart';
import 'package:daeawt/features/forgot_password/presentation/cubit/forgot_password_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/remote/service.dart';
part 'otp_state.dart';

String codeVerify = "";

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this.api) : super(OtpInitial());
   String? verification_id ="";
  ServiceApi api;
  TextEditingController pinCode = TextEditingController();
  CheckCodeModel checkCodeModel = CheckCodeModel();


  checkCode(BuildContext context) async {
    verification_id = context .read<ForgotPasswordCubit>().verificationId;
    verifySmsCode(pinCode.text,verification_id,context);
      // emit(CheckCodeLoading());
      // AppWidget.createProgressDialog(context, "Loading");
      // final response = await api.postCheckCode(pinCode.text);
      //
      // response.fold(
      //        (l) => emit(CheckCodeLoading()),
      //         (r) {
      //         checkCodeModel = r ;
      //         if(checkCodeModel.code==200){
      //           emit(CheckCodeSuccess());
      //           Navigator.pop(context);
      //           Navigator.pushReplacementNamed(context, Routes.newPasswordRoute);
      //           codeVerify = checkCodeModel.verifyCode!;
      //
      //         }
      //         else{
      //           Navigator.pop(context);
      //           emit(CheckCodeFailure());
      //         }
      //
      //
      // }
      // );
    }
    verifySmsCode(String userSmsCode,id,BuildContext context){
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId:id ,
        smsCode: userSmsCode);
    FirebaseAuth.instance.signInWithCredential(phoneAuthCredential).then((value) {
      print('VerificationSuccess');
      Navigator.pushNamed(context, Routes.newPasswordRoute);

      emit(CheckCodeSuccessfully());
    } ).onError((error, stackTrace) {
      print('phone auth =>${error.toString()}');
    });
    }

}
