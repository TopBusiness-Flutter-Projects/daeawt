import 'package:daeawt/core/utils/assets_manager.dart';
import 'package:daeawt/core/widgets/custom_buttom.dart';
import 'package:easy_localization/easy_localization.dart'as easy;
import 'package:flutter/material.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/small_bottom_curve.dart';
import '../widgets/contact_us_widget.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var languageCode = easy.EasyLocalization.of(context)!.locale.languageCode;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: SmallBottomCurveClipper(),
              child: Container(
                alignment: Alignment.bottomCenter,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  AppColors.orange2,
                  AppColors.primary,
                ])),
                padding:
                    const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
                height: 160,
                width: double.infinity,
                child:  Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon:  Transform.rotate(
                        angle: languageCode=="ar"? (3.14):0,
                        child:const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                   SizedBox(width: MediaQuery.of(context).size.width*0.2,),

                    const Text(
                      AppStrings.contactUs,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ).tr(),

                  ],
                ),
              ),
            ),
            Image.asset(ImageAssests.contactUsImage),
            ContactUs(
                prefixIcon: Image.asset(ImageAssests.userNameIcon),
                hint: AppStrings.userName.tr()),
            ContactUs(
                prefixIcon: Image.asset(ImageAssests.phoneNumberIcon),
                hint: AppStrings.phoneNumber.tr(),
            textInputType: TextInputType.number),
            ContactUs(
                prefixIcon: Image.asset(ImageAssests.theTopicIcon),
                hint: AppStrings.theTopic.tr()),
            ContactUs(
                prefixIcon: Padding(
                  padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.12),
                  child: Image.asset(ImageAssests.theMessageIcon),
                ),
                hint: AppStrings.theMessage.tr(),
                    minLines: 5,
                    maxLines: 8,),
            const SizedBox(height: 30,),
            CustomButton(onPressed: () {
              Navigator.pushNamed(context, Routes.profileRoute);
            },text: AppStrings.send.tr(),),
            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
