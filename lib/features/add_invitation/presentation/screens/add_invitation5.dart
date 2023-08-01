import 'package:daeawt/features/add_invitation/presentation/cubit/add_invitation_cubit.dart';
import 'package:easy_localization/easy_localization.dart'as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_back_arrow.dart';
import '../../../../core/widgets/divider_widget.dart';
import '../../../../core/widgets/small_bottom_curve.dart';
import '../../../home/presentation/widgets/number_widget.dart';

class AddInvitationStepFiveScreen extends StatelessWidget {
  const AddInvitationStepFiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? languageCode = easy.EasyLocalization.of(context)?.locale.languageCode;

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
                          vertical: 5.h, horizontal: 10.w),
                      height: 20.h,
                      width: double.infinity,
                      child: Center(
                        child:  Text(
                          cubit.homeListItemModel==null?
                          AppStrings.createNewInvitation:"update_invitation".tr(),
                          style:  TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 11.sp,
                              color: Colors.white),
                        ).tr(),
                      ),
                      //color: Colors.orange,
                    ),
                    const CustomBackArrow(),
                  ],
                ),
              ),
              //first row of numbers in circles
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NumberWidget(
                    backgroundColor: AppColors.black1,
                    text: "1",
                    textColor: Colors.white,
                  ),
                  DividerCustomWidget(),
                  NumberWidget(
                    backgroundColor: AppColors.black1,
                    text: "2",
                    textColor: Colors.white,
                  ),
                  DividerCustomWidget(),
                  NumberWidget(
                    backgroundColor: AppColors.black1,
                    text: "3",
                    textColor: Colors.white,
                  ),
                  DividerCustomWidget(),
                  NumberWidget(
                      backgroundColor: AppColors.black1,
                      text: "4",
                      textColor: Colors.white),
                  DividerCustomWidget(),
                  NumberWidget(
                    backgroundColor: AppColors.black1,
                    text: "5",
                    textColor: Colors.white,
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              //ارسال
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Stack(
                      alignment:languageCode=="ar"? Alignment.centerRight:Alignment.centerLeft,
                      children: [
                        const CircleAvatar(
                          radius: 17,
                          backgroundColor: AppColors.primary,
                        ),
                         Text(
                          AppStrings.send,
                          style: TextStyle(
                              fontSize:  14.sp, fontWeight: FontWeight.w700),
                        ).tr(),
                         Positioned(
                          bottom: 3,
                          // alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: 10.w,
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
              //ارسال الدعوات
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 8),
                    child:  Text(
                      AppStrings.sendInvitations,
                      style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black1),
                    ).tr(),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              //black button ارسال
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: SizedBox(
                  height: 4.h,
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.black1,
                        ),
                        child: const Text(AppStrings.send, style: TextStyle(
                            color: Colors.white),).tr(),
                        onPressed: () {

                          showDialog(context: context, builder: (context) {
                            return
                              Dialog(
                                shadowColor: Colors.transparent,
                                backgroundColor:Colors.transparent ,
                              surfaceTintColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                // elevation: 0.0,

                              ),
                              child: Stack(
                                alignment: Alignment.bottomCenter,

                                children: [
                                  SizedBox(
                                    height:MediaQuery.of(context).size.height*0.35 ,
                                    width:MediaQuery.of(context).size.width*0.72 ,


                                  ),
                                  Container(
                                    color:Colors.white,
                                    height:MediaQuery.of(context).size.height*0.3 ,
                                    child: Padding(
                                      padding:  EdgeInsets.all(7.w),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                           Text("wanna_send_invitations",style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.primary
                                          ),).tr(),
                                          Text(
                                            "${cubit.TotalInvitedPeople}",
                                              style:  TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          SizedBox(
                                            height: 5.h,
                                            width: MediaQuery.of(context).size.width*0.7,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.black1,
                                              ),
                                              child: const Text(AppStrings.send, style: TextStyle(
                                                  color: Colors.white),).tr(),
                                              onPressed: () {
                                               cubit.homeListItemModel==null? cubit.addinviatation(context): cubit.updateinviatation(context);
                                              //

                                              },

                                              // backgroundColor:AppColors.black1,
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0.6.h,
                                    left: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.primary,
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            );
                          },);
                        },

                        // backgroundColor:AppColors.black1,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: ListView.separated(
                  itemBuilder: (context, index) {

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 38.0),
                      child:
                      cubit.model.selectedContactModelList[index].phones!.isNotEmpty?
                      Row(children: [
                        Text("${index+1} - المكرم :",style:  TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 11.sp
                        ),),

                        Expanded(
                          child: Text(" ${cubit.model.selectedContactModelList[index].name}",
                            style:  TextStyle(
                          fontWeight: FontWeight.w400,
                              fontSize: 11.sp
                          ),
                          overflow: TextOverflow.clip,
                          softWrap: true,
                          maxLines: 1,

                          ),
                        )
                      ],):
                      const SizedBox(),
                    );
                  }, separatorBuilder: (context, index) {
                return const SizedBox(height: 10,);
              }, itemCount:cubit.model.selectedContactModelList.length),
              ),
              SizedBox(
                height: 2.h,
              )
            ],
          ),
        );
      },
    );
  }
}
