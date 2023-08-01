import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/appwidget.dart';
import '../../../core/utils/toast_message_method.dart';
import '../../home/cubit/home_cubit.dart';
import '../../profile/presentation/cubit/profile_cubit.dart';
import '../model/register_model.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.api) : super(SignupInitial());

  RegisterModel registerModel = RegisterModel();
  bool isLoginValid = false;
  final ServiceApi api;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

//When the user taps the Google sign-in button, call the signInWithGoogle method:
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the Google authentication flow.
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request.
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential.
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential.
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  saveUserDataByGoogleSignIn(BuildContext context) async {
    AppWidget.createProgressDialog(context, "Loading");
    UserCredential userCredential = await signInWithGoogle();
   final response = await api.registerWithGoogle(userCredential);

       response.fold(
             (failure) => {Navigator.pop(context), emit(RegisterWithGoogleLoading())},
             (loginModel) {
           print("------------------ ${loginModel.code}");
           if (loginModel.code == 409 || loginModel.code == 410) {
             Navigator.pop(context);
             toastMessage("exists_email".tr(), context);
             // errorGetBar(translateText(AppStrings.noEmailError, context));
             emit(RegisterFailure());
           } else if (loginModel.code == 200) {
             Navigator.pop(context);
             Preferences.instance.setUser(loginModel).then((value) {
               context.read<HomeCubit>().getUserData();
               context.read<ProfileCubit>().getUserData();
               Navigator.pushNamedAndRemoveUntil(
                   context, Routes.homeRoute, (route) => false);
               // emit(OnLoginSuccess(response));
             });
           }
         },
       );

  }





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
      (failure) => {Navigator.pop(context), emit(RegisterFailure())},
      (loginModel) {
        print("------------------ ${loginModel.code}");
        if (loginModel.code == 409 || loginModel.code == 410) {
          Navigator.pop(context);
          toastMessage("exists_user".tr(), context);
          // errorGetBar(translateText(AppStrings.noEmailError, context));
          emit(RegisterFailure());
        } else if (loginModel.code == 200) {
          Navigator.pop(context);
          Preferences.instance.setUser(loginModel).then((value) {
            context.read<HomeCubit>().getUserData();
            context.read<ProfileCubit>().getUserData();
            Navigator.pushNamedAndRemoveUntil(

                context, Routes.homeRoute, (route) => false);
            // emit(OnLoginSuccess(response));
          });
        }
      },
    );
  }
}
