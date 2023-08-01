import 'package:contacts_service/contacts_service.dart';
import 'package:daeawt/core/utils/app_strings.dart';
import 'package:daeawt/features/add_invitation/presentation/cubit/add_invitation_cubit.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/toast_message_method.dart';
import '../../../../core/widgets/custom_buttom.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/small_bottom_curve.dart';

class AddNewContacts extends StatelessWidget {
  const AddNewContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? languageCode =
        easy.EasyLocalization.of(context)?.locale.languageCode;

    AddInvitationCubit cubit = context.read<AddInvitationCubit>();
    return Scaffold(
      body: BlocBuilder<AddInvitationCubit, AddInvitationState>(
        builder: (context, state) {
          return Column(
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
                        child: Text(
                          'update_invitation'.tr(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
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
                              icon: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 35,
                              )),
                        ))
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      //المضافين
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
                                  AppStrings.selectContacts,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
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
                      //
                      const SizedBox(
                        height: 8,
                      ),
                      //من فضلك حدد جهات الاتصال المطلوبة
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 8),
                            child: const Text(
                              AppStrings.pleaseSelectContacts,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black1),
                            ).tr(),
                          ),
                        ],
                      ),
                      //ابحث
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 60,
                            child: CustomTextFormField(
                              onChanged: (p0) {},
                              hintText: AppStrings.search,
                              prefixIcon: const Icon(Icons.search),
                            )),
                      ),
                      //contacts
                      Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          margin: const EdgeInsets.symmetric(horizontal: 18),
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(color: Colors.grey, blurRadius: 10),
                                BoxShadow(color: Colors.white, blurRadius: 10),
                                BoxShadow(
                                    color: Colors.black38, blurRadius: 10),
                              ]),
                          child: FutureBuilder<List<Contact>>(
                            future: context
                                .read<AddInvitationCubit>()
                                .getAllContacts(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, i) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "المكرم",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Center(
                                                  child: Text(
                                                context
                                                    .read<AddInvitationCubit>()
                                                    .contactModelList[i]
                                                    .name!,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )),
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: context
                                                    .read<AddInvitationCubit>()
                                                    .contactModelList[i]
                                                    .phones
                                                    ?.length,
                                                itemBuilder: (context, index) {
                                                  return Text(
                                                    context
                                                        .read<
                                                            AddInvitationCubit>()
                                                        .contactModelList[i]
                                                        .phones![index]
                                                        .value!,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: AppColors.grey5,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.edit)),
                                        TextButton(
                                            onPressed: () {
                                              if (cubit.contactModelList[i]
                                                          .isSelected ==
                                                      false &&
                                                  cubit.userModel!.data!.user!
                                                          .balance! >
                                                      0) {
                                                cubit.contactModelList[i]
                                                        .isSelected =
                                                    cubit.changesSelectButton(
                                                        cubit
                                                            .contactModelList[i]
                                                            .isSelected!);
                                                if (cubit.contactModelList[i]
                                                    .isSelected!) {
                                                  if (cubit.contactModelList[i]
                                                      .phones!.isNotEmpty) {
                                                    cubit.model
                                                        .selectedContactModelList
                                                        .add(cubit
                                                            .contactModelList[i]);
                                                    cubit.userModel!.data!.user!
                                                        .balance = cubit
                                                            .userModel!
                                                            .data!
                                                            .user!
                                                            .balance! -
                                                        1;
                                                  }
                                                } else {
                                                  cubit.model
                                                      .selectedContactModelList
                                                      .remove(cubit
                                                          .contactModelList[i]);
                                                  cubit.userModel!.data!.user!
                                                      .balance = cubit
                                                          .userModel!
                                                          .data!
                                                          .user!
                                                          .balance! +
                                                      1;
                                                }
                                              }
                                              else {
                                                toastMessage(
                                                    "no_balance".tr(), context);
                                              }
                                            },
                                            child: !context
                                                    .read<AddInvitationCubit>()
                                                    .contactModelList[i]
                                                    .isSelected!
                                                ? const Text(
                                                    AppStrings.select,
                                                    style: TextStyle(
                                                        color:
                                                            AppColors.primary,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ).tr()
                                                : const Text(
                                                    AppStrings.remove,
                                                    style: TextStyle(
                                                        color: AppColors.red1,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ).tr()),
                                      ],
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return const Text("Error in getting contacts");
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      //last 2 buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 15),
                        child: CustomButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.sendNewContactsRoute);
                          },
                          text: AppStrings.tracking.tr(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
