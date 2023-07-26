import 'package:daeawt/core/utils/appwidget.dart';
import 'package:daeawt/features/forgot_password/presentation/cubit/forgot_password_cubit.dart';
import 'package:daeawt/features/forgot_password/presentation/cubit/forgot_password_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/bottom_curve.dart';
import '../../../../core/widgets/custom_buttom.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var languageCode = EasyLocalization.of(context)!.locale.languageCode;

    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is InvalidEmailState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("The selected email is invalid")));
        } if (state is ResetPasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("ResetPasswordFailure")));
        }
        if(state is ResetPasswordSuccess){
          Navigator.pushNamed(context, Routes.otpRoute);
        }
      },
      builder: (context, state) {
        ForgotPasswordCubit cubit = context.read<ForgotPasswordCubit>();
        return Scaffold(
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
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            height: 300,
                            width: double.infinity,
                            //color: Colors.orange,
                            child: Image.asset(
                              ImageAssests.dawatBarKudIcon,
                            )),
                        Positioned(
                            left: 0,
                            top: 40,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Transform.rotate(
                                angle: languageCode == "ar" ? (3.14) : 0,
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                //forgot password
                const Text(
                  AppStrings.forgetPassword,
                  style:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ).tr(),
                const SizedBox(
                  height: 15,
                ),
                //enter mobile number
                const Text(
                  "please_enter_email",
                  // AppStrings.enterMobileNumber,
                  style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ).tr(),
                const SizedBox(
                  height: 45,
                ),
                // text form field
                Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CustomTextFormField(
                      textController: cubit.emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: AppStrings.email,
                      prefixIcon: const Icon(
                        Icons.wifi_calling_3_rounded,
                        color: AppColors.primary,
                      ),
                    )),
                const SizedBox(
                  height: 25,
                ),
                //استرجاع
                CustomButton(
                  text: AppStrings.recovery,
                  onPressed: () async {
                    await cubit.resetPassword1(context);
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
