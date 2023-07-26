import 'package:daeawt/core/widgets/custom_buttom.dart';
import 'package:daeawt/features/forgot_password/presentation/cubit/forgot_password_cubit.dart';
import 'package:daeawt/features/otp/presentation/cubit/otp_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    var languageCode = EasyLocalization.of(context)!.locale.languageCode;

    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
  listener: (context, state) {
   // if(state is CheckCodeSuccess){
   //   Navigator.pushNamed(context, Routes.newPasswordRoute);
   // }
   if (state is CheckCodeFailure){
     ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text("The code is invalid")));
   }
  },
  builder: (context, state) {
    ForgotPasswordCubit cubit = context.read<ForgotPasswordCubit>();
    return BlocConsumer<OtpCubit, OtpState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    OtpCubit cubit = context.read<OtpCubit>();
    return Scaffold(
      body:
      SingleChildScrollView(
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
                        child:   IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          }, icon: Transform.rotate(
                          angle:languageCode=="ar"?(3.14):0 ,
                          child:  const Icon(Icons.arrow_back,color: Colors.white,size: 30,),),
                        )
                    ),
                  ],
                ),
              ),
            ),
            //ادخل الكود التأكيدى
            const Text(
              AppStrings.enterVerificationCode,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ).tr(),
            const SizedBox(
              height: 25,
            ),
            //سيتم ارسال كود تأكيدى على رقم الموبيل الخاص بك
            const Text(
              AppStrings.confirmationCodeSent,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ).tr(),
            const SizedBox(
              height: 50,
            ),
          //todo
            //PinCodeTextField
            SizedBox(
              width: MediaQuery.of(context).size.width*0.6,
              child: PinCodeTextField(
                controller:cubit.pinCode ,
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
            CustomButton(onPressed: () async {

           await  cubit.checkCode(context);
            },text: AppStrings.confirm,)
          ],
        ),
      ),
    );
  },
);
  },
);
  }
}
