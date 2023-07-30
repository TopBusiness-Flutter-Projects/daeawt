import 'package:easy_localization/easy_localization.dart'as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/bottom_curve.dart';
import '../../../../core/widgets/custom_buttom.dart';
import '../../cubit/signup_cubit.dart';


class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    String? languageCode = easy.EasyLocalization.of(context)?.locale.languageCode;

    SignupCubit cubit = context.read<SignupCubit>();
    return Form(
      key: formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ClipPath(
                  clipper: BottomCurveClipper(),
                  child: Stack(
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [
                            AppColors.orange2,
                            AppColors.primary,
                          ])),
                          padding: const EdgeInsets.only(left: 20, bottom: 10),
                          height: 300,
                          width: double.infinity,
                          //color: Colors.orange,
                          child:  Center(child: Text('app_name'.tr(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.white),))),
                      Positioned(
                          left: 20,
                          top: 60,
                          child: Transform.rotate(
                            angle:languageCode=="ar"?0:(3.14) ,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 35,
                                )),)
                      )
                    ],
                  ),
                ),
              ),
              const Text(
                AppStrings.createNewAccount,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ).tr(),
              const SizedBox(
                height: 15,
              ),
              const Text(
                AppStrings.signUpToCreateInvitation,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ).tr(),
              Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    cursorColor: AppColors.primary,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (data) {
                      formKey.currentState!.validate();
                      cubit.registerModel.name = data;
                      cubit.checkValidLoginData();
                    },
                    // controller: cubit.emailControl,
                    validator: (value) {
                      print(value);
                      if (value == null || value.isEmpty) {
                        return 'field_reguired'.tr();
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 5),
                        prefixIcon: const Icon(
                          Icons.person_2_outlined,
                          color: AppColors.primary,
                        ),
                        hintText: 'name'.tr(),
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
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    onChanged: (data) {
                      formKey.currentState!.validate();
                      cubit.registerModel.phone = data;
                      cubit.checkValidLoginData();
                    },
                    // controller: cubit.emailControl,
                    validator: (value) {
                      print(value);
                      if (value == null || value.isEmpty) {
                        return 'field_reguired'.tr();
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 5),
                        prefixIcon: const Icon(
                          Icons.wifi_calling_3_rounded,
                          color: AppColors.primary,
                        ),
                        hintText: 'phone_number'.tr(),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: AppColors.grey1,
                        filled: true),
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 18),
                  child: TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    cursorColor: AppColors.primary,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onChanged: (data) {
                      formKey.currentState!.validate();
                      cubit.registerModel.email = data;
                      cubit.checkValidLoginData();
                    },
                    // controller: cubit.emailControl,
                    validator: (value) {
                      print(value);
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
                      cubit.registerModel.password = data;
                      cubit.checkValidLoginData();
                    },
                    // controller: cubit.emailControl,
                    validator: (value) {
                      print(value);
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
              const SizedBox(
                height: 25,
              ),
              CustomButton(
                text: AppStrings.createAccount,
                onPressed: () {
                  if(cubit.isLoginValid){
                  cubit.register(context);
                }
                  else{
                    formKey.currentState!.validate();
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
                      AppStrings.alreadyHaveAnAccount,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ).tr(),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.loginRoute);
                        },
                        child: const Text(
                          AppStrings.logIn,
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
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
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
                height: 35,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
