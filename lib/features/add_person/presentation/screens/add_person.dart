import 'package:daeawt/config/routes/app_routes.dart';
import 'package:daeawt/features/add_invitation/presentation/cubit/add_invitation_cubit.dart';
import 'package:easy_localization/easy_localization.dart'as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_buttom.dart';
import '../../../../core/widgets/my_svg_widget.dart';
import '../../../../core/widgets/small_bottom_curve.dart';

class AddPerson extends StatelessWidget {
  const AddPerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var languageCode = easy.EasyLocalization.of(context)!.locale.languageCode;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            ClipPath(
              clipper: SmallBottomCurveClipper(),
              child: Container(
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
                child: Row(
                  textDirection: TextDirection.ltr,
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //arrow back
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon:

                      Transform.rotate(
                        angle:languageCode=="ar"?(3.14):0 ,
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Spacer(),
                    const Text(
                      AppStrings.createNewInvitation,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ).tr(),
                    Spacer(),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.addNewContactsRoute);
                        },
                        icon: Icon(
                            Icons.add,color: Colors.white,size: 30,
                        )),

                  ],
                ),
              ),
            ),

            //اضافة مدعوين
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
                        AppStrings.addGuests,
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
            const SizedBox(height: 10,),
            //search
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 60,
              child:
              TextFormField(
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'username_valid'.tr();
                  }
                  return null;
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                    prefixIcon:const Icon(Icons.search),
                    hintText: AppStrings.searchYourInvitations.tr(),
                    border:  OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: AppColors.grey1,
                    filled: true

                ),
              ),
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
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width * 0.9,
              // child: ListView.separated(
              //   shrinkWrap: true,
              //   separatorBuilder: (context, index) => const SizedBox(
              //     height: 20,
              //   ),
              //   itemCount: context.read<AddInvitationCubit>().selectedContactModelList.length,
              //   itemBuilder: (context, index) {
              //     return context.read<AddInvitationCubit>().selectedContactModelList[index].phones!
              //         .isNotEmpty
              //         ? Stack(
              //       alignment: Alignment.bottomCenter,
              //       children: [
              //         SizedBox(
              //           height: 150,
              //           width:
              //           MediaQuery.of(context).size.width * 0.95,
              //         ),
              //         Container(
              //           alignment: Alignment.center,
              //           padding: const EdgeInsets.all(8),
              //           height: 112,
              //           width:
              //           MediaQuery.of(context).size.width * 0.86,
              //           decoration: BoxDecoration(
              //               color: AppColors.orange3,
              //               borderRadius: BorderRadius.circular(10)),
              //           child: Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Row(
              //               mainAxisAlignment:
              //               MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Column(
              //                   mainAxisAlignment:
              //                   MainAxisAlignment.center,
              //                   crossAxisAlignment:
              //                   CrossAxisAlignment.start,
              //                   children: [
              //                     Row(
              //                       children: [
              //                         const Text(
              //                           "المكرم : ",
              //                           style: TextStyle(
              //                               fontSize: 16,
              //                               fontWeight:
              //                               FontWeight.w700),
              //                         ),
              //                         Text(
              //                           "${context.read<AddInvitationCubit>().selectedContactModelList[index].name?.split(" ")[0]}",
              //                           style: const TextStyle(
              //                               fontSize: 17,
              //                               fontWeight:
              //                               FontWeight.w400),
              //                         ),
              //                       ],
              //                     ),
              //                     Text(
              //                       "${context.read<AddInvitationCubit>().selectedContactModelList[index].phones?[0].value}",
              //                       style: const TextStyle(
              //                           fontSize: 14,
              //                           color: AppColors.grey5,
              //                           fontWeight: FontWeight.w700),
              //                     ),
              //                   ],
              //                 ),
              //                 Container(
              //                   width: 117,
              //                   height: 33,
              //                   decoration: BoxDecoration(
              //                       color: AppColors.primary,
              //                       borderRadius:
              //                       BorderRadius.circular(10)),
              //                   child: Row(
              //                     mainAxisAlignment:
              //                     MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       IconButton(
              //                         onPressed: () {
              //                          // cubit.incrementNumberOfInvitedPeople();
              //                         },
              //                         icon: const Icon(
              //                           Icons.add,
              //                           color: Colors.white,
              //                         ),
              //                         padding: EdgeInsets.zero,
              //                       ),
              //                       Text(
              //                         context.read<AddInvitationCubit>().numberOfInvitedPeople
              //                             .toString(),
              //                         style: const TextStyle(
              //                             color: Colors.white,
              //                             fontSize: 20,
              //                             fontWeight:
              //                             FontWeight.w700),
              //                       ),
              //                       IconButton(
              //                           onPressed: () {
              //                            // cubit.decrementNumberOfInvitedPeople();
              //                           },
              //                           icon: const Icon(
              //                             Icons.remove,
              //                             color: Colors.white,
              //                           ),
              //                           padding: EdgeInsets.zero),
              //                     ],
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //         ),
              //         Positioned(
              //             right: 0,
              //             top: 15,
              //             child: CircleAvatar(
              //               radius: 18,
              //               backgroundColor: AppColors.primary,
              //               child: Center(
              //                   child: IconButton(
              //                     onPressed: () {
              //                       //TODO-->
              //                      // cubit.removeSelectedContact(index);
              //                     },
              //                     icon: const Icon(
              //                       Icons.close,
              //                       color: Colors.white,
              //                     ),
              //                     padding: EdgeInsets.zero,
              //                   )),
              //             )),
              //       ],
              //     )
              //         : SizedBox();
              //   },
              // ),
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
                      //  Navigator.pushNamed(context, Routes.addInvitationStep4Route);
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
                      //  Navigator.pushNamed(context, Routes.homeRoute);
                      },
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
  }
}
