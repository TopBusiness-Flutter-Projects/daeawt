import 'dart:io';
import 'package:daeawt/core/utils/app_strings.dart';
import 'package:daeawt/core/widgets/custom_buttom.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/bottom_curve.dart';
import '../../cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    //formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    LoginCubit cubit = context.read<LoginCubit>();
    return Form(
      key: formKey,
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ClipPath(
                      clipper: BottomCurveClipper(),
                      child: Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [
                            AppColors.orange2,
                            AppColors.primary,
                          ])),
                          padding: const EdgeInsets.only(left: 20, bottom: 10),
                          height: 300,
                          //color: Colors.orange,
                          child: Center(child: Text('app_name'.tr(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.white),))),
                    ),
                  ),
                  const Text(
                    AppStrings.login,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ).tr(),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    AppStrings.loginToCreateInvitation,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ).tr(),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextFormField(
                        maxLines: 1,
                        autofocus: false,
                        cursorColor: AppColors.primary,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onChanged: (data) {
                          formKey.currentState!.validate();
                          cubit.loginModel.email = data;
                          cubit.checkValidLoginData();
                        },
                        // controller: cubit.emailControl,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'field_reguired'.tr();
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 5),
                            prefixIcon: const Icon(
                              Icons.mail_outlined,
                              color: AppColors.primary,
                            ),
                            hintText: 'email'.tr(),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fillColor: AppColors.grey1,
                            filled: true),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: TextFormField(
                        maxLines: 1,
                        autofocus: false,
                        cursorColor: AppColors.primary,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        onChanged: (data) {
                          formKey.currentState!.validate();
                          cubit.loginModel.password = data;
                          cubit.checkValidLoginData();
                        },
                        // controller: cubit.emailControl,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'field_reguired'.tr();
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 5),
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: AppColors.primary,
                            ),
                            hintText: 'password'.tr(),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fillColor: AppColors.grey1,
                            filled: true),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.forgotPasswordRoute);
                          },
                          child: Text(
                            AppStrings.forgetPassword.tr(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomButton(
                    text: AppStrings.login.tr(),
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        cubit.login(context);
                      }

                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          AppStrings.haveNoAccount,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ).tr(),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.signUpRoute);
                            },
                            child: const Text(
                              AppStrings.createAccount,
                              style: TextStyle(
                                  color: AppColors.blue1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ).tr())
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: AppColors.grey2, //color of divider
                            // height: 5, //height spacing of divider
                            thickness: 1, //thickness of divier line
                            indent: 5, //spacing at the start of divider
                            endIndent: 2, //spacing at the end of divider
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: const Text(
                            AppStrings.orLogInWith,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                          ).tr(),
                        ),
                        const Expanded(
                          child: Divider(
                            color: AppColors.grey2, //color of divider
                            // height: 5, //height spacing of divider
                            thickness: 1, //thickness of divier line
                            indent: 2, //spacing at the start of divider
                            endIndent: 2, //spacing at the end of divider
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  InkWell(
                    onTap: () async {
                      await cubit.saveUserDataByGoogleSignIn(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          AppStrings.signUpWithGoogle,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ).tr(),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          ImageAssests.googleIcon,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
            Visibility(
              visible: Platform.isIOS,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/4.5),
                child: SignInWithAppleButton(

                  onPressed: () async {
                    final credential = await SignInWithApple.getAppleIDCredential(
                      scopes: [
                        AppleIDAuthorizationScopes.email,
                        AppleIDAuthorizationScopes.fullName,
                      ],
                    );

                   cubit.saveUserDataByAppleSignIn(context,credential);

                    // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
                    // after they have been validated with Apple (see `Integration` section for more information on how to do this)
                  },
                ),
              ),
            ),
                  const SizedBox(
                    height: 35,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
