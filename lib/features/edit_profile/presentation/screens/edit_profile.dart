import 'package:daeawt/core/utils/assets_manager.dart';
import 'package:daeawt/core/widgets/custom_buttom.dart';
import 'package:daeawt/core/widgets/small_bottom_curve.dart';
import 'package:easy_localization/easy_localization.dart'as easy;
import 'package:flutter/material.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? languageCode = easy.EasyLocalization.of(context)?.locale.languageCode;

    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: SmallBottomCurveClipper(),
            child: Stack(
              children: [
                Container(
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
                  child: const Text(
                    AppStrings.modifyAccount,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ).tr(),
                ),
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
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                child: Image.asset(ImageAssests.profileImage),
              ),
              Icon(
                Icons.edit_calendar,
                color: Colors.white.withOpacity(0.5),
                size: 20,
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 28.0,
            ),
            // padding: const EdgeInsets.symmetric(horizontal: 28.0,),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 2),
                  BoxShadow(
                      color: Colors.white, spreadRadius: 1, blurRadius: 2),
                ],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 0.5, color: Colors.grey)),
            child: TextFormField(
              keyboardType: TextInputType.text,
              //controller:cubit.nameController ,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'username_valid'.tr();
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  //contentPadding: EdgeInsets.symmetric(vertical: 8),
                  prefixIcon: Icon(Icons.person,color: AppColors.primary,),
                  hintText: 'محمد محمد',//todo==>
                  fillColor: Colors.white,
                  filled: true),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 28.0,
            ),
            // padding: const EdgeInsets.symmetric(horizontal: 28.0,),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 2),
                  BoxShadow(
                      color: Colors.white, spreadRadius: 1, blurRadius: 2),
                ],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 0.5, color: Colors.grey)),
            child: TextFormField(
              keyboardType: TextInputType.text,
              //controller:cubit.nameController ,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'username_valid'.tr();
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  //contentPadding: EdgeInsets.symmetric(vertical: 8),
                  prefixIcon: Icon(Icons.phone_enabled_rounded,color: AppColors.primary,),
                  hintText: '01020306548',//todo-->
                  fillColor: Colors.white,
                  filled: true),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          CustomButton(onPressed: () {
            Navigator.pushNamed(context, Routes.profileRoute);
          }, text: AppStrings.confirm.tr())
        ],
      ),
    );
  }
}
