import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/bottom_curve.dart';
import '../../../../core/widgets/custom_buttom.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        decoration:  const BoxDecoration(
                            gradient: LinearGradient(colors: [
                              AppColors.orange2,
                              AppColors.primary,
                            ])),
                        padding: const EdgeInsets.only(left: 20, bottom: 10),
                        height: 300,
                        width: double.infinity,
                        //color: Colors.orange,
                        child: Image.asset(
                          AssetsManager.dawatBarKudIcon,
                        )),
                   Positioned(
                     left: 0,
                       top: 40,
                       child: TextDirection.LTR==Directionality.of(context)?
                       IconButton(onPressed: (){
                         Navigator.pop(context);
                       }, icon: const Icon(Icons.arrow_back,color: Colors.white,size: 30,)):
                           IconButton(onPressed: (){
                             Navigator.pop(context);
                           }, icon: const Icon(Icons.arrow_forward,color: Colors.white,size: 30),
                       ),
                   ),
                  ],
                ),
              ),
            ),
            const Text(
              AppStrings.createNewAccount,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
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
                child: CustomTextFormField(
                  hintText: AppStrings.name,
                  prefixIcon: const Icon(
                    Icons.person_2_outlined,
                    color: AppColors.primary,
                  ),
                )),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: CustomTextFormField(
                  hintText: AppStrings.phoneNumber,
                  prefixIcon: const Icon(
                    Icons.wifi_calling_3_rounded,
                    color: AppColors.primary,
                  ),
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 18),
                child: CustomTextFormField(
                  hintText: AppStrings.email,
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: AppColors.primary,
                  ),
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: CustomTextFormField(
                  hintText:AppStrings.password,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.primary,
                  ),
                )),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 25,
            ),
             CustomButton(
              text: AppStrings.createAccount,
               onPressed: (){},
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ).tr(),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.loginRoute);
                      },
                      child: const Text(
                        AppStrings.logIn,
                        style: TextStyle(
                            color: AppColors.blue1,
                            fontSize: 18,
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
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  AppStrings.signUpWithGoogle,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ).tr(),
                const SizedBox(
                  width: 5,
                ),
                Image.asset(
                  AssetsManager.googleIcon,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
