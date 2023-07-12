import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
              AppStrings.forgetPassword,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ).tr(),
            const SizedBox(
              height: 15,
            ),
            const Text(
              AppStrings.enterMobileNumber,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ).tr(),
            const SizedBox(
              height: 45,
            ),
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: CustomTextFormField(
                  hintText: AppStrings.phoneNumber,
                  prefixIcon: const Icon(
                    Icons.wifi_calling_3_rounded,
                    color: AppColors.primary,
                  ),
                )),
            const SizedBox(
              height: 25,
            ),
             CustomButton(
              text: AppStrings.recovery,
               onPressed: (){
                Navigator.pushNamed(context, Routes.otpRoute);
               },
            ),
            const SizedBox(
              height: 25,
            ),

          ],
        ),
      ),
    );
  }
}
