import 'package:daeawt/core/utils/assets_manager.dart';
import 'package:daeawt/core/widgets/custom_buttom.dart';
import 'package:daeawt/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/small_bottom_curve.dart';
import '../widgets/number_widget.dart';

class AddInvitationStepFourScreen extends StatelessWidget {
  const AddInvitationStepFourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        HomeCubit cubit = context.read<HomeCubit>();
        return Scaffold(
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
                    const NumberWidget(
                        backgroundColor: AppColors.black1,
                        text: "4",
                        textColor: Colors.white),
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
                //استعراض
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
                            AppStrings.review,
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

                //سيكون شكل دعواتك هكذا
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 8),
                      child: const Text(
                        AppStrings.invitationLookLike,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black1),
                      ).tr(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                //language
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                      color: AppColors.grey6,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: AppColors.grey5)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      items: cubit.languageOptions
                          .map((item) => DropdownMenuItem<String>(
                                value: item.toString(),
                                child: Text(
                                  item.toString(),
                                ),
                              ))
                          .toList(),
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black1,
                          decoration: TextDecoration.none),
                      value: cubit.selectedLanguage,
                      onChanged: (value) {
                        cubit.changeLanguageOption(value!);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                //استعراض رسالة الدعوة
                Center(
                    child: const Text(
                  AppStrings.reviewInvitation,
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ).tr()),
                const SizedBox(
                  height: 10,
                ),
                // the invitation card
                Container(
                  //the big grey container
                  height: MediaQuery.of(context).size.height * 0.55,
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.grey6),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        //the image with the 2 texts
                        Container(
                            height: MediaQuery.of(context).size.height * 0.38,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                cubit.invitationImage == null
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.asset(
                                              AssetsManager
                                                  .invitationPlaceholder,
                                            )),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                            File(cubit.invitationImage!.path),
                                            height: MediaQuery.of(context).size.height*0.28,
                                          ),
                                        ),
                                      ),
                                 Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        cubit.selectedContactModelList.isNotEmpty?
                                        "المكرم : ${cubit.selectedContactModelList[0].name??" "}":" ",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.black1,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "نتشرف بدعوتكم لحضور عيد ميلاد",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: AppColors.black1,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        //the 2 buttons
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0,vertical: 12),
                          child: Row(
                            children: [
                              Expanded(
                                  child: CustomButton(
                                      onPressed: () {},
                                      height: 45,
                                      text: AppStrings.confirm,
                                      backgroundColor: AppColors.green2)),
                              const SizedBox(width: 8,),
                              Expanded(
                                child: CustomButton(
                                  onPressed: () {},
                                  height: 45,
                                  text: AppStrings.apology,
                                  backgroundColor: AppColors.red1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //invitation location
                        Container(
                          height: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: const Text(AppStrings.invitationLocation,style: TextStyle(
                            color: AppColors.black1,
                            fontSize: 18,
                            fontWeight: FontWeight.w700
                          ),).tr(),
                        )

                      ],
                    ),
                  ),
                ),
                //the last 2 buttons
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 17.0, vertical: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          backgroundColor: AppColors.primary,
                          onPressed: () {

                            Navigator.pushNamed(context, Routes.addInvitationStep5Route);
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
                          text: AppStrings.saveAsDraft.tr(),
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
      },
    );
  }
}
