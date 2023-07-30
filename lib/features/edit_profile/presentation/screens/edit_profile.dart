import 'dart:io';

import 'package:daeawt/core/utils/assets_manager.dart';
import 'package:daeawt/core/widgets/custom_buttom.dart';
import 'package:daeawt/core/widgets/small_bottom_curve.dart';
import 'package:daeawt/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart'as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/network_image.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();

    String? languageCode = easy.EasyLocalization.of(context)?.locale.languageCode;
    EditProfileCubit cubit=context.read<EditProfileCubit>();
    return Scaffold(
      body: Form(
        key: formKey,
        child: BlocBuilder<EditProfileCubit, EditProfileState>(
  builder: (context, state) {
    return Column(
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
                          fontSize: 14,
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
            InkWell(

                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5),
                        child: Text('Choose'.tr()),
                      ),
                      contentPadding: EdgeInsets.zero,
                      content: SizedBox(
                        width:
                        MediaQuery.of(context).size.width -
                            60,
                        child: Row(
                          children: [
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                cubit.pickImage(
                                  type: 'camera',
                                );
                                Navigator.of(context).pop();
                              },
                              child: SizedBox(
                                height: 80,
                                width: 80,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.camera_alt,
                                        size: 45,
                                        color: AppColors.grey1),
                                    Text('camera'.tr())
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                cubit.pickImage(
                                  type: 'photo',
                                );
                                Navigator.of(context).pop();
                              },
                              child: SizedBox(
                                height: 80,
                                width: 80,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.photo,
                                        size: 45,
                                        color: AppColors.grey1),
                                    Text('Gallery'.tr())
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('cancel'.tr()))
                      ],
                    ),
                  );
                },

              child: Stack(
                alignment: Alignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5),
                                child: Text('Choose'.tr()),
                              ),
                              contentPadding: EdgeInsets.zero,
                              content: SizedBox(
                                width:
                                MediaQuery.of(context).size.width -
                                    60,
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        cubit.pickImage(
                                          type: 'camera',
                                        );
                                        Navigator.of(context).pop();
                                      },
                                      child: SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.camera_alt,
                                                size: 45,
                                                color: AppColors.grey1),
                                            Text('camera'.tr())
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        cubit.pickImage(
                                          type: 'photo',
                                        );
                                        Navigator.of(context).pop();
                                      },
                                      child: SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.photo,
                                                size: 45,
                                                color: AppColors.grey1),
                                            Text('Gallery'.tr())
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('cancel'.tr()))
                              ],
                            ),
                          );
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Icon(
                            Icons.linked_camera_rounded,
                            color: AppColors.primary,
                            size: 25,
                          ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 40,
                      child: cubit.imagePath.isEmpty
                          ? ManageNetworkImage(
                        imageUrl: cubit
                            .editProfileModel.image,
                        width: 140,
                        height: 140,
                        borderRadius: 140,
                      )
                          : Image.file(
                        File(
                          cubit.imagePath,
                        ),
                        width: 140.0,
                        height: 140.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.edit_calendar,
                    color: Colors.white.withOpacity(0.5),
                    size: 20,
                  )
                ],
              ),
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
                controller:cubit.controllerName ,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'field_valid'.tr();
                  }
                  return null;
                },
                onChanged: (data) {
                  formKey.currentState!.validate();
                  cubit.editProfileModel.name = data;
                  cubit.checkValidEditProfileData();
                },
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    //contentPadding: EdgeInsets.symmetric(vertical: 8),
                    prefixIcon: Icon(Icons.person,color: AppColors.primary,),
                   // hintText: 'محمد محمد',//todo==>
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
                keyboardType: TextInputType.phone,
                controller:cubit.controllerPhone ,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'field_valid'.tr();
                  }
                  return null;
                },
                onChanged: (data) {
                  formKey.currentState!.validate();
                  cubit.editProfileModel.phone = data;
                  cubit.checkValidEditProfileData();
                },
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    //contentPadding: EdgeInsets.symmetric(vertical: 8),
                    prefixIcon: Icon(Icons.phone_enabled_rounded,color: AppColors.primary,),
                  //todo-->
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomButton(onPressed: () {
              cubit.edit(context);
            //  Navigator.pushNamed(context, Routes.profileRoute);
            }, text: AppStrings.confirm.tr())
          ],
        );
  },
),
      ),
    );
  }
}
