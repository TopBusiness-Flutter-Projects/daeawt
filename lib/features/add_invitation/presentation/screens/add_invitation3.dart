import 'package:daeawt/core/widgets/custom_back_arrow.dart';
import 'package:daeawt/features/add_invitation/presentation/cubit/add_invitation_cubit.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/toast_message_method.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_buttom.dart';
import '../../../../core/widgets/divider_widget.dart';
import '../../../../core/widgets/small_bottom_curve.dart';
import '../../../home/presentation/widgets/number_widget.dart';

class AddInvitationStepThreeScreen extends StatelessWidget {
  const AddInvitationStepThreeScreen({Key? key}) : super(key: key);

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
                          vertical: .05*MediaQuery.of(context).size.height, horizontal: .1*MediaQuery.of(context).size.width),
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
                        height: .04*MediaQuery.of(context).size.height,
                      ),
                      //المدعوين
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
                                  AppStrings.invited,
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.w700),
                                ).tr(),
                                 Positioned(
                                  bottom: 3,
                                  // alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    width: .1*MediaQuery.of(context).size.width,
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

                      //اضافة مدعوين
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 8),
                            child:  Text(
                              AppStrings.addGuests,
                              style: TextStyle(
                                  fontSize: 11,
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
                            child:  Text(
                              AppStrings.companion,
                              style: TextStyle(
                                  fontSize: 12,
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
                          separatorBuilder: (context, index) =>  SizedBox(
                            height: .02*MediaQuery.of(context).size.height,
                          ),
                          itemCount: cubit.model.selectedContactModelList.length,
                          itemBuilder: (context, index) {
                            return cubit.model.selectedContactModelList[index].phones!
                                    .isNotEmpty
                                ? Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height*0.13,
                                        width:
                                            MediaQuery.of(context).size.width * 0.95,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(8),
                                        height: MediaQuery.of(context).size.height*0.12,
                                        width:
                                            MediaQuery.of(context).size.width * 0.9,
                                        decoration: BoxDecoration(
                                            color: AppColors.orange3,
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                       Text(
                                                        "المكرم : ",
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(context).size.width/24,
                                                            fontWeight:
                                                                FontWeight.w700),
                                                      ),
                                                      Text(
                                                        "${cubit.model.selectedContactModelList[index].name?.split(" ")[0]}",
                                                        style:  TextStyle(
                                                            fontSize: MediaQuery.of(context).size.width/24,
                                                            fontWeight:
                                                                FontWeight.w400),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    "${cubit.model.selectedContactModelList[index].phones?[0].value}",
                                                    style:  TextStyle(
                                                        fontSize: MediaQuery.of(context).size.width/24,
                                                        color: AppColors.grey5,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                ],
                                              ),
                                              //+ 0 -
                                              Container(
                                               // width: MediaQuery.of(context).size.width *0.29,
                                                height: .03*MediaQuery.of(context).size.height,
                                                decoration: BoxDecoration(
                                                    color: AppColors.primary,
                                                    borderRadius:
                                                        BorderRadius.circular(10)),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        if(cubit.userModel!.data!.user!.balance!>0){
                                                          cubit.userModel!.data!.user!.balance=cubit.userModel!.data!.user!.balance!-1;

                                                          cubit
                                                            .incrementNumberOfInvitedPeople(
                                                                index);
                                                        }else {
                                                        toastMessage(
                                                        "no_balance".tr(), context);
                                                        }

                                                      },
                                                      icon:  Icon(
                                                        Icons.add,
                                                        size: .02*MediaQuery.of(context).size.height,
                                                        color: Colors.white,
                                                      ),
                                                      padding: EdgeInsets.zero,
                                                    ),
                                                    Text(
                                                      cubit.model
                                                          .selectedContactModelList
                                                          .elementAt(index)
                                                          .numberOfInvitedPeople
                                                          .toString(),
                                                      style:  TextStyle(
                                                          color: Colors.white,
                                                          fontSize: MediaQuery.of(context).size.width/24,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          cubit.userModel!.data!.user!.balance=cubit.userModel!.data!.user!.balance!+1;

                                                          cubit
                                                              .decrementNumberOfInvitedPeople(
                                                                  index);
                                                        },
                                                        icon:  Icon(
                                                          Icons.remove,
                                                          size: .02*MediaQuery.of(context).size.height,
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
                                          top: 0,
                                          child: CircleAvatar(
                                            radius: .03*MediaQuery.of(context).size.width,
                                            backgroundColor: AppColors.primary,
                                            child: Center(
                                                child: IconButton(
                                              onPressed: () {
                                                cubit.removeSelectedContact(index);
                                              },
                                                  icon:  Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                    size: .015*MediaQuery.of(context).size.height,
                                              ),
                                              padding: EdgeInsets.zero,
                                            )),
                                          )),
                                    ],
                                  )
                                : const SizedBox();
                          },
                        ),
                      ),
                       SizedBox(
                        height: .1*MediaQuery.of(context).size.height,
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
                                  if (cubit.model.selectedContactModelList.length > 0) {
                                    cubit.model.step = 4;

                                    Navigator.pushNamed(
                                        context, Routes.addInvitationStep4Route);
                                  } else {
                                    toastMessage("select_contact".tr(), context);
                                  }
                                },
                                text: AppStrings.tracking,
                              ),
                            ),
                             SizedBox(
                              width: .02*MediaQuery.of(context).size.width,
                            ),
                            Visibility(
                              visible: cubit.homeListItemModel == null ? true : false,
                              child: Expanded(
                                child: CustomButton(
                                  onPressed: () {
                                    if (cubit.model.selectedContactModelList.length > 0) {
                                      cubit.model.as_draft = 1;

                                      cubit.addinviatation(context);
                                    } else {
                                      toastMessage("select_contact".tr(), context);
                                    }
                                  },
                                  text: AppStrings.save.tr(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                       SizedBox(
                        height: .1*MediaQuery.of(context).size.height,
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
