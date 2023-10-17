import 'package:daeawt/core/utils/assets_manager.dart';
import 'package:daeawt/core/widgets/custom_buttom.dart';
import 'package:daeawt/features/add_invitation/presentation/cubit/add_invitation_cubit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'dart:io';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_back_arrow.dart';
import '../../../../core/widgets/divider_widget.dart';
import '../../../../core/widgets/small_bottom_curve.dart';
import '../../../home/presentation/widgets/number_widget.dart';

class AddInvitationStepFourScreen extends StatelessWidget {
  const AddInvitationStepFourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? languageCode =
        easy.EasyLocalization.of(context)?.locale.languageCode;

    return BlocConsumer<AddInvitationCubit, AddInvitationState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        AddInvitationCubit cubit = context.read<AddInvitationCubit>();
        return Scaffold(
          body: Column(
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
                      padding:  EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      height: .2*MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          cubit.homeListItemModel == null
                              ? AppStrings.createNewInvitation
                              : "update_invitation".tr(),
                          style:  TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                              color: Colors.white),
                        ).tr(),
                      ),
                      //color: Colors.orange,
                    ),
                    const CustomBackArrow(),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //first row of numbers in circles
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          const NumberWidget(
                            backgroundColor: AppColors.black1,
                            text: "1",
                            textColor: Colors.white,
                          ),
                          const DividerCustomWidget(),
                          const NumberWidget(
                            backgroundColor: AppColors.black1,
                            text: "2",
                            textColor: Colors.white,
                          ),
                          const DividerCustomWidget(),
                          const NumberWidget(
                            backgroundColor: AppColors.black1,
                            text: "3",
                            textColor: Colors.white,
                          ),
                          const DividerCustomWidget(),
                          const NumberWidget(
                              backgroundColor: AppColors.black1,
                              text: "4",
                              textColor: Colors.white),
                          const DividerCustomWidget(),
                          NumberWidget(
                            backgroundColor: Colors.grey.withOpacity(0.3),
                            text: "5",
                            textColor: AppColors.grey4,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      //استعراض
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          children: [
                            Stack(
                              alignment:languageCode=="ar"? Alignment.centerRight:Alignment.centerLeft,
                              children: [
                                const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: AppColors.primary,
                                ),
                                 Text(
                                  AppStrings.review,
                                  style: TextStyle(
                                      fontSize:  14,
                                      fontWeight: FontWeight.w700),
                                ).tr(),
                                 Positioned(
                                  bottom: 3,
                                  // alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    width: 10,
                                    child: const Divider(
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
                            child:  Text(
                              AppStrings.invitationLookLike,
                              style: TextStyle(
                                  fontSize: 11,
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
                        height: .07*MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                            color: AppColors.grey6,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
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
                            style:  TextStyle(
                                fontSize: 11,
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
                       SizedBox(
                        height: 3,
                      ),
                      //استعراض رسالة الدعوة
                      Center(
                          child:  Text(
                        AppStrings.reviewInvitation,
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ).tr()),
                      const SizedBox(
                        height: 10,
                      ),
                      // the invitation card
                      Container(
                        //the big grey container
                        height: MediaQuery.of(context).size.height * 0.66,
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.44,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      cubit.invitationImage == null
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.asset(
                                                    ImageAssests
                                                        .invitationPlaceholder,
                                                  )),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.file(
                                                  File(cubit
                                                      .invitationImage!.path),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.28,
                                                ),
                                              ),
                                            ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              cubit
                                                      .model
                                                      .selectedContactModelList
                                                      .isNotEmpty
                                                  ? "المكرم : ${cubit.model.selectedContactModelList[0].name ?? " "}"
                                                  : " ",
                                              textAlign: TextAlign.start,
                                              style:  TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.black1,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                cubit.selectedLanguage ==
                                                        "العربية"
                                                    ? "نتشرف بدعوتكم لحضور ${cubit.model.title}"
                                                    : "We are honored to invite you to attend ${cubit.model.title}",
                                                textAlign: TextAlign.start,
                                                maxLines: 2,
                                                 overflow: TextOverflow.ellipsis,
                                                style:  TextStyle(
                                                    color: AppColors.black1,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              //the 2 buttons
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 3.0, vertical: 12),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: CustomButton(
                                            onPressed: () {},
                                            height: .06*MediaQuery.of(context).size.height,
                                            text: cubit.selectedLanguage ==
                                                    "العربية"
                                                ? "تأكيد"
                                                : "Confirm",
                                            backgroundColor: AppColors.green2)),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: CustomButton(
                                        onPressed: () {},
                                        height: .06*MediaQuery.of(context).size.height,
                                        text:
                                            cubit.selectedLanguage == "العربية"
                                                ? "اعتذر"
                                                : "Apology",
                                        backgroundColor: AppColors.red1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //invitation location
                              Container(
                                height: .06*MediaQuery.of(context).size.height,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Text(
                                  cubit.selectedLanguage == "العربية"
                                      ? "موقع المناسبة"
                                      : "Location",
                                  style:  TextStyle(
                                      color: AppColors.black1,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ).tr(),
                              )
                            ],
                          ),
                        ),
                      ),
                      //the last 2 buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 17.0, vertical: 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                backgroundColor: AppColors.primary,
                                onPressed: () {
                                  cubit.model.step = 5;
                                  cubit.getTotalInvitedPeople();
                                  Navigator.pushNamed(
                                      context, Routes.addInvitationStep5Route);
                                },
                                text: AppStrings.tracking,
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Visibility(
                              visible: cubit.homeListItemModel == null
                                  ? true
                                  : false,
                              child: Expanded(
                                child: CustomButton(
                                  onPressed: () {
                                    cubit.model.as_draft = 1;
                                    cubit.addinviatation(context);

                                    //    Navigator.pushNamed(context, Routes.homeRoute);
                                  },
                                  text: AppStrings.saveAsDraft.tr(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
