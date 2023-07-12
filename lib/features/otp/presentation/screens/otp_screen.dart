import 'package:daeawt/core/widgets/custom_buttom.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/bottom_curve.dart';


class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
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
            AppStrings.enterVerificationCode,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ).tr(),
          const SizedBox(
            height: 25,
          ),
          const Text(
            AppStrings.confirmationCodeSent,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ).tr(),
          const SizedBox(
            height: 50,
          ),
        //todo
          SizedBox(
            width: MediaQuery.of(context).size.width*0.6,
            child: PinCodeTextField(
              length: 6,
              appContext: context,
              keyboardType: TextInputType.number,
              textStyle: const TextStyle(fontSize: 17),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 20,
                fieldWidth: 30,
                activeFillColor: Colors.white,
                inactiveColor: Colors.grey,
              ),
            ),
          ),
          const SizedBox(
            height: 45,
          ),
          CustomButton(onPressed: () {
            Navigator.pushNamed(context, Routes.newPasswordRoute);
          },text: AppStrings.confirm,)
        ],
      ),
    );
  }
}
