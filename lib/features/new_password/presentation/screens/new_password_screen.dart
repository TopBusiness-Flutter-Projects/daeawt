import 'package:daeawt/features/new_password/presentation/cubit/new_password_cubit.dart';
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

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var languageCode = EasyLocalization.of(context)!.locale.languageCode;

    return BlocConsumer<NewPasswordCubit, NewPasswordState>(
      listener: (context, state) {
       if(state is NewPasswordFailureState){
         ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(content: Text("The process failed try again")));
       }
      },
      builder: (context, state) {
        NewPasswordCubit cubit = context.read<NewPasswordCubit>();
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
                            padding: const EdgeInsets.only(left: 20, bottom: 10),
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
                const Text(
                  AppStrings.enterNewPassword,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ).tr(),
                const SizedBox(
                  height: 45,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: CustomTextFormField(
                      textController: cubit.passwordController,
                      hintText: AppStrings.newPassword,
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: AppColors.primary,
                      ),
                    )),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: CustomTextFormField(
                      textController: cubit.passwordConfirmationController,
                      hintText: AppStrings.confirmPassword,
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: AppColors.primary,
                      ),
                    )),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                  onPressed: () async {
                  await cubit.resetPassword(context);
                  },
                  text: AppStrings.confirm,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
