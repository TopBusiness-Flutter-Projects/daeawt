import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_buttom.dart';
import '../../../../core/widgets/small_bottom_curve.dart';
import '../widgets/number_widget.dart';

class AddInvitationStepThreeScreen extends StatelessWidget {
  const AddInvitationStepThreeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: SmallBottomCurveClipper(),
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                          AppColors.orange2,
                          AppColors.primary,
                        ])),
                    padding: const EdgeInsets.symmetric(
                        vertical: 60, horizontal: 40),
                    height: 160,
                    width: double.infinity,
                    child: Center(
                      child: const Text(
                        AppStrings.createNewInvitation,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Colors.white),
                      ).tr(),
                    ),
                    //color: Colors.orange,
                  ),
                  Positioned(
                      left: 20,
                      top: 60,
                      child: Directionality.of(context) == TextDirection.LTR
                          ? IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 35,
                        ),
                      )
                          : IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 35,
                          )))
                ],
              ),
            ),
            //first row of numbers in circles
            Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                const NumberWidget(
                  backgroundColor: AppColors.black1,
                  text: "1",
                  textColor: Colors.white,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.13,
                  child: const Divider(
                    color: Colors.grey,
                  ),
                ),
                const NumberWidget(
                  backgroundColor: AppColors.black1,
                  text: "2",
                  textColor: Colors.white,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.13,
                  child: const Divider(
                    color: Colors.grey,
                  ),
                ),
                const NumberWidget(
                  backgroundColor: AppColors.black1,
                  text: "3",
                  textColor: Colors.white,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.13,
                  child: const Divider(
                    color: Colors.grey,
                  ),
                ),
                NumberWidget(
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  text: "4",
                  textColor: AppColors.grey4,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.13,
                  child: const Divider(
                    color: Colors.grey,
                  ),
                ),
                NumberWidget(
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  text: "5",
                  textColor: AppColors.grey4,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            //المدعوين
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.primary,
                      ),
                      const Text(
                        AppStrings.invited,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ).tr(),
                      const Positioned(
                        bottom: 3,
                        // alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 40,
                          child: Divider(
                            color: AppColors.cyan,
                            thickness: 2,
                            height: 2,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),

            //اضافة مدعوين
            Row(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                  child: const Text(
                    AppStrings.addGuests,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black1),
                  ).tr(),
                ),
              ],
            ),

            //مرافقين
            Row(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                  child: const Text(
                    AppStrings.companion,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black1),
                  ).tr(),
                ),
              ],
            ),
            const SizedBox(height: 15,),
            //TODO -->adding companions
           Container(
             height: 112,
             width: MediaQuery.of(context).size.width*0.9,
             decoration: BoxDecoration(
               color: AppColors.orange2,
               borderRadius: BorderRadius.circular(10)
             ),
             child: Row(
               children: [

               ],
             ),
           ),
            const SizedBox(
              height: 40,
            ),
            //last 2 buttons
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      backgroundColor: AppColors.primary,
                      onPressed: () {
                       // Navigator.pushNamed(context, Routes.addInvitationStep3Route);
                      },
                      text: AppStrings.tracking,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.homeRoute);
                      },
                      text: AppStrings.save.tr(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

          ],
        ),
      ),
    );
  }
}
