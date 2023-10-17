import 'dart:io';

import 'package:daeawt/core/utils/app_strings.dart';
import 'package:daeawt/core/utils/assets_manager.dart';
import 'package:daeawt/core/widgets/custom_buttom.dart';
import 'package:daeawt/core/widgets/custom_text_form_field.dart';
import 'package:daeawt/core/widgets/small_bottom_curve.dart';
import 'package:daeawt/features/add_invitation/presentation/cubit/add_invitation_cubit.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/widgets/custom_back_arrow.dart';
import '../../../../core/widgets/divider_widget.dart';
import '../../../../core/widgets/network_image.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../home/presentation/widgets/number_widget.dart';

class AddInvitationScreen extends StatefulWidget {
  AddInvitationScreen({Key? key}) : super(key: key);

  @override
  State<AddInvitationScreen> createState() => _AddInvitationScreenState();
}

class _AddInvitationScreenState extends State<AddInvitationScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String? languageCode =
        easy.EasyLocalization.of(context)?.locale.languageCode;

    return BlocConsumer<AddInvitationCubit, AddInvitationState>(
      listener: (context, state) {
        if (state is SelectInvitationImageState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        AddInvitationCubit cubit = context.read<AddInvitationCubit>();
        return Scaffold(
          body: Form(
            key: formKey,
            child: Column(
              children: [
                ClipPath(
                  clipper: SmallBottomCurveClipper(),
                  child: Stack(
                    children: [
                      Container(
                        height: .2*MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                              AppColors.orange2,
                              AppColors.primary,
                            ])),
                        padding:  EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                       // height: 20,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            cubit.homeListItemModel == null
                                ? AppStrings.createNewInvitation
                                : "update_invitation".tr(),
                            style:  TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Colors.white),
                          ).tr(),
                        ),
                        //color: Colors.orange,
                      ),
                      Positioned(
                          left: 20,
                          top: 60,
                          child: Transform.rotate(
                            angle: languageCode == "ar" ? 0 : (3.14),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon:  Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size:24,
                                )),
                          ))
                      // const CustomBackArrow(),
                    ],
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(

                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [

                        //first row of numbers in circles
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // const SizedBox(
                            //   width: 15,
                            // ),
                            const NumberWidget(
                              backgroundColor: AppColors.black1,
                              text: "1",
                              textColor: Colors.white,
                            ),
                            const DividerCustomWidget(),
                            NumberWidget(
                              backgroundColor: Colors.grey.withOpacity(0.3),
                              text: "2",
                              textColor: AppColors.grey4,
                            ),
                            const DividerCustomWidget(),
                            NumberWidget(
                              backgroundColor: Colors.grey.withOpacity(0.3),
                              text: "3",
                              textColor: AppColors.grey4,
                            ),
                            const DividerCustomWidget(),
                            NumberWidget(
                              backgroundColor: Colors.grey.withOpacity(0.3),
                              text: "4",
                              textColor: AppColors.grey4,
                            ),
                            const DividerCustomWidget(),
                            NumberWidget(
                              backgroundColor: Colors.grey.withOpacity(0.3),
                              text: "5",
                              textColor: AppColors.grey4,
                            ),
                          ],
                        ),
                         SizedBox(
                          height: 3,
                        ),
                        //تفاصيل المناسبة
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
                                    AppStrings.occasionDetails,
                                    style: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.w700),
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
                        const SizedBox(
                          height: 8,
                        ),
                        //ادخل معلومات مناسبتك
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0, vertical: 8),
                              child:  Text(
                                AppStrings.enterEventDetails,
                                style: TextStyle(
                                    fontSize: 11,
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
                              child:  Text(
                                AppStrings.dateOfOccasion,
                                style: TextStyle(
                                    fontSize: 11,
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

                        InkWell(
                          onTap: () {
                            showBirthDateCalender();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28.0, vertical: 10),
                            child: CustomTextFormField(
                              isenable: false,
                              textController: cubit.dateController,
                              hintText: AppStrings.enterEventName,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Visibility(
                                visible: cubit.model.date.isEmpty,
                                child: Text(
                                  'enter_date',
                                  style:
                                      TextStyle(color: AppColors.error, fontSize: 8),
                                ).tr()),
                          ),
                        ),
                        //اسم المناسبة
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18.0,
                              ),
                              child:  Text(
                                AppStrings.occasionName,
                                style: TextStyle(
                                    fontSize: 11,
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
                            textController: cubit.nameController,
                            onChanged: (p0) {
                           //   cubit.nameController.text=p0;
                              cubit.model.title = p0;

                              formKey.currentState!.validate();
                              cubit.checkDataVaild1();
                            },
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
                              child:  Text(
                                AppStrings.invitationImage,
                                style: TextStyle(
                                    fontSize: 11,
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
                            margin: const EdgeInsets.symmetric(
                                horizontal: 28, vertical: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.orange3),
                            child: Row(
                              children: [
                                Image.asset(ImageAssests.uploadImageIcon),
                                const SizedBox(
                                  width: 10,
                                ),
                                 Text(
                                  AppStrings.uploadInvitationPhoto,
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11),
                                ).tr()
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Visibility(
                                visible: cubit.model.image.isEmpty,
                                child: Text(
                                  'enter_image',
                                  style:
                                      TextStyle(color: AppColors.error, fontSize: 8),
                                ).tr()),
                          ),
                        ),
                        cubit.model.image.isNotEmpty
                            ? cubit.model.image.contains("http")
                                ? SizedBox(
                                    width: MediaQuery.of(context).size.width - 50,
                                    height: 17,
                                    child: ManageNetworkImage(
                                        height: 17,
                                        width: MediaQuery.of(context).size.width - 50,
                                        imageUrl: cubit.model.image),
                                  )
                                : SizedBox(
                                    width: MediaQuery.of(context).size.width - 50,
                                 //   height: .2*MediaQuery.of(context).size.height,
                                    child: AspectRatio(
                                      aspectRatio: 3/2,
                                      child: Image.file(
                                         // height: .2*MediaQuery.of(context).size.height,
                                          width: MediaQuery.of(context).size.width - 50,
                                          fit: BoxFit.cover,
                                         // alignment: Alignment.bottomCenter,
                                          File(cubit.model.image)),
                                    ),
                                  )
                            : const SizedBox(),
                        //first check box list tile
                        SizedBox(
                          height:  .05*MediaQuery.of(context).size.height,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 20,
                                child: CheckboxListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  controlAffinity: ListTileControlAffinity.leading,
                                  value: cubit.withBarcode,
                                  title: const Text(
                                          AppStrings.invitationWithEntryBarcode)
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
                          height:  .05*MediaQuery.of(context).size.height,
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
                               Text(
                                AppStrings.occasionSite,
                                style: TextStyle(
                                    fontSize: 12,
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
                                //TODO-->we can ask the user for location here
                                Navigator.pushNamed(context, Routes.googleMapRoute);
                              },
                              child: Image.asset(ImageAssests.mapImage)),
                        ),
                        //location name
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                    style:  TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.w400)),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Visibility(
                                visible: cubit.model.address.isEmpty,
                                child: Text(
                                  'enter_address',
                                  style:
                                      TextStyle(color: AppColors.error, fontSize: 10),
                                ).tr()),
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
                                    if (formKey.currentState!.validate() &&
                                        cubit.isDataVaild1) {
                                      cubit.model.step = 2;
                                      Navigator.pushNamed(
                                          context, Routes.addInvitationStep2Route);
                                    }
                                  },
                                  text: AppStrings.tracking,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Visibility(
                                visible:
                                    cubit.homeListItemModel == null ? true : false,
                                child: Expanded(
                                  child: CustomButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate() &&
                                          cubit.isDataVaild1) {
                                        cubit.model.as_draft = 1;

                                        cubit.addinviatation(context);
                                      }
                                    },
                                    text: AppStrings.saveAsDraft.tr(),
                                  ),
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showBirthDateCalender() async {
    DateTime? date = await showDatePicker(
        context: context,
        locale: easy.EasyLocalization.of(context)!.locale,
        initialDate: BlocProvider.of<AddInvitationCubit>(context).initialDate,
        firstDate: BlocProvider.of<AddInvitationCubit>(context).startData,
        lastDate: BlocProvider.of<AddInvitationCubit>(context).endData,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              textTheme: TextTheme(
                titleLarge: TextStyle(fontSize: 14)
              ),
                colorScheme: const ColorScheme.light(
                    primary: AppColors.primary,
                    onPrimary: AppColors.white,
                    onSurface: AppColors.black)),
            child: child!,
          );
        });

    if (date != null) {
      BlocProvider.of<AddInvitationCubit>(context).updateBirthDate(
          date: easy.DateFormat('yyyy-MM-dd', 'en').format(date));
    }
  }
}
