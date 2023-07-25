import 'package:daeawt/features/add_invitation/presentation/cubit/add_invitation_cubit.dart';

import '../../../../core/utils/toast_message_method.dart';
import '../../../home/cubit/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_buttom.dart';
import '../../../../core/widgets/small_bottom_curve.dart';
import '../../../home/presentation/widgets/number_widget.dart';

class AddInvitationStepThreeScreen extends StatelessWidget {
  const AddInvitationStepThreeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddInvitationCubit, AddInvitationState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        AddInvitationCubit cubit = context.read<AddInvitationCubit>();
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 8),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 8),
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

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                    itemCount: cubit.model.selectedContactModelList.length,
                    itemBuilder: (context, index) {
                      return cubit.model.selectedContactModelList[index].phones!
                              .isNotEmpty
                          ? Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                SizedBox(
                                  height: 150,
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8),
                                  height: 112,
                                  width:
                                      MediaQuery.of(context).size.width * 0.86,
                                  decoration: BoxDecoration(
                                      color: AppColors.orange3,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  "المكرم : ",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text(
                                                  "${cubit.model.selectedContactModelList[index].name?.split(" ")[0]}",
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "${cubit.model.selectedContactModelList[index].phones?[0].value}",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: AppColors.grey5,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 117,
                                          height: 33,
                                          decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  cubit.incrementNumberOfInvitedPeople(index);
                                                },
                                                icon: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                                padding: EdgeInsets.zero,
                                              ),
                                              Text(
                                                cubit.model.selectedContactModelList.elementAt(index).numberOfInvitedPeople
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    cubit.decrementNumberOfInvitedPeople(index);
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                  ),
                                                  padding: EdgeInsets.zero),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    top: 15,
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: AppColors.primary,
                                      child: Center(
                                          child: IconButton(
                                        onPressed: () {
                                          //TODO-->
                                          cubit.removeSelectedContact(index);
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                        padding: EdgeInsets.zero,
                                      )),
                                    )),
                              ],
                            )
                          : SizedBox();
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                //last 2 buttons
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15),
                  //last 2 buttons
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          backgroundColor: AppColors.primary,
                          onPressed: () {
                            if(cubit.model.selectedContactModelList.length>0){
                              cubit.model.step=4;

                              Navigator.pushNamed(context, Routes.addInvitationStep4Route);

                            }
                            else{
                              toastMessage("select_contact".tr(), context);
                            }
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
                            if(cubit.model.selectedContactModelList.length>0){
                              cubit.model.as_draft=1;

                              cubit.addinviatation(context);


                            }
                            else{
                              toastMessage("select_contact".tr(), context);
                            }                          },
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
      },
    );
  }
}
