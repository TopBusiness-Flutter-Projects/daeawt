import 'package:daeawt/features/add_invitation/presentation/cubit/add_invitation_cubit.dart';
import 'package:easy_localization/easy_localization.dart'as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/small_bottom_curve.dart';

class SendNewContacts extends StatelessWidget {
  const SendNewContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? languageCode = easy.EasyLocalization.of(context)?.locale.languageCode;
    AddInvitationCubit cubit=context.read<AddInvitationCubit>();
    return  Scaffold(

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
                    child: const Text(
                      AppStrings.send,
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

          //ارسال
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
                      AppStrings.send,
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
          //ارسال الدعوات
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 8),
                child: const Text(
                  AppStrings.sendInvitations,
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
          //black button ارسال
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SizedBox(
              height: 40,
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
                                    padding: const EdgeInsets.all(38.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                         Text("wanna_send_invitations".tr(),style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.primary
                                        ),),
                                        Text(
                                          "${
                                              context.read<AddInvitationCubit>().model.selectedContactModelList.length}",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 46,
                                          width: MediaQuery.of(context).size.width*0.7,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.black1,
                                            ),
                                            child: const Text(AppStrings.send, style: TextStyle(
                                                color: Colors.white),).tr(),
                                            onPressed: () {
                                              cubit.model.step=5;
                                              context.read<AddInvitationCubit>().updateinviatation(context);
                                             // Navigator.pushNamed(context, Routes.homeRoute);

                                            },

                                            // backgroundColor:AppColors.black1,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 16,
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
                  context.read<AddInvitationCubit>().model.selectedContactModelList[index].phones!.isNotEmpty?
                  Row(children: [
                    Text("${index+1} - المكرم :",style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20
                    ),),

                    Expanded(
                      child: Text(" ${context.read<AddInvitationCubit>().model.selectedContactModelList[index].name}",style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20
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
          }, itemCount:context.read<AddInvitationCubit>().model.selectedContactModelList.length),
          )
        ],
      );
  },
),
    );
  }
}
