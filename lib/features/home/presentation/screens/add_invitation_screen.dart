import 'package:daeawt/core/utils/app_strings.dart';
import 'package:daeawt/core/utils/assets_manager.dart';
import 'package:daeawt/core/widgets/custom_buttom.dart';
import 'package:daeawt/core/widgets/custom_text_form_field.dart';
import 'package:daeawt/core/widgets/small_bottom_curve.dart';
import '../../cubit/home_cubit.dart';import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../widgets/number_widget.dart';

class AddInvitationScreen extends StatefulWidget {
  AddInvitationScreen({Key? key}) : super(key: key);

  @override
  State<AddInvitationScreen> createState() => _AddInvitationScreenState();
}

class _AddInvitationScreenState extends State<AddInvitationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is SelectInvitationImageState) {
          Navigator.pop(context);
        }
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
                    NumberWidget(
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      text: "2",
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
                      text: "3",
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
                //تفاصيل المناسبة
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
                            AppStrings.occasionDetails,
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
                const SizedBox(
                  height: 8,
                ),
                //ادخل معلومات مناسبتك
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 8),
                      child: const Text(
                        AppStrings.enterEventDetails,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black1),
                      ).tr(),
                    ),
                  ],
                ),
                //تاريخ المناسبة
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                      ),
                      child: const Text(
                        AppStrings.dateOfOccasion,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black1),
                      ).tr(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                //CustomTextFormField ادخل تاريخ المناسبة
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28.0, vertical: 10),
                  child: CustomTextFormField(
                    hintText: AppStrings.enterEventName,
                  ),
                ),
                //اسم المناسبة
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                      ),
                      child: const Text(
                        AppStrings.occasionName,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black1),
                      ).tr(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                //CustomTextFormField ادخل عنوان المناسبة
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: CustomTextFormField(
                    hintText: AppStrings.enterEvenTitle,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                //صورة الدعوة
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                      ),
                      child: const Text(
                        AppStrings.invitationImage,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black1),
                      ).tr(),
                    ),
                  ],
                ),
                //رفع صور الدعوة
                InkWell(
                  onTap: () async {
                    await cubit.uploadInvitationImage(context);
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.orange3),
                    child: Row(
                      children: [
                        Image.asset(AssetsManager.uploadImageIcon),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          AppStrings.uploadInvitationPhoto,
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        ).tr()
                      ],
                    ),
                  ),
                ),
                //first check box list tile
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 20,
                        child: CheckboxListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: cubit.withBarcode,
                          title:
                              const Text(AppStrings.invitationWithEntryBarcode)
                                  .tr(),
                          onChanged: (bool? value) {
                            cubit.changeWithBarcodeCheckListTile(value);
                          },
                        ),
                      ),
                      const Expanded(
                        flex: 11,
                        child: SizedBox(),
                      )
                    ],
                  ),
                ),
                //second check box list tile
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 20,
                        child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          value: cubit.withSendingDate,
                          title: const Text(AppStrings.sendingDate).tr(),
                          onChanged: (bool? value) {
                            cubit.changeWithSendingDateCheckListTile(value);
                          },
                        ),
                      ),
                      const Expanded(
                        flex: 22,
                        child: SizedBox(),
                      )
                    ],
                  ),
                ),
                //موقع المناسبة
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 10),
                  child: Row(
                    children: [
                      const Text(
                        AppStrings.occasionSite,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black1),
                      ).tr(),
                    ],
                  ),
                ),
                //map image
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: InkWell(
                      onTap: () {
                        //TODO-->
                        Navigator.pushNamed(context, Routes.googleMapRoute);
                      },
                      child: Image.asset(AssetsManager.mapImage)),
                ),
                //location name
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                      ),
                      //شبين الكوم , المنوفية
                      Expanded(
                        child: Text(cubit.address,
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                ),
                //last 2 buttons
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          backgroundColor: AppColors.primary,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.addInvitationStep2Route);
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
                            Navigator.pop(context);
                          },
                          text: AppStrings.saveAsDraft.tr(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
