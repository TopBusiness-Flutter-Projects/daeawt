import 'package:daeawt/core/utils/app_strings.dart';
import 'package:daeawt/core/utils/assets_manager.dart';
import 'package:daeawt/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/my_svg_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        ProfileCubit cubit = context.read<ProfileCubit>();

        return WillPopScope(
          onWillPop: () async{
            Navigator.pushNamed(context, Routes.homeRoute);
            return true;
          },
          child: Scaffold(
            backgroundColor: AppColors.primary,
            body: Column(
             // alignment: Alignment.bottomCenter,
              children: [
                const SizedBox(height: 50,),

                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [

                        const Text(
                          AppStrings.myAccount,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ).tr(),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.5),
                        const MySvgWidget(
                            path: ImageAssests.deleteIcon, size: 22),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.editProfileRoute);
                          },
                          icon: const MySvgWidget(
                              path: ImageAssests.editIcon, size: 22),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                      ],
                    ),
                  ),
                ),
            Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.75,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40)),
                  ),
              child:SingleChildScrollView(
                     child: Column(
                       children: [
                         SizedBox(
                           height: 150,
                           width: MediaQuery.of(context).size.width,
                           child: Stack(children: [
                             Positioned(
                               top: MediaQuery.of(context).size.height * 0.09,
                               right: MediaQuery.of(context).size.width * 0.1,
                               child: const CircleAvatar(
                                 radius: 4,
                                 backgroundColor: AppColors.primary,
                               ),
                             ),
                             Positioned(
                               top: MediaQuery.of(context).size.height * .1,
                               left: MediaQuery.of(context).size.width * 0.1,
                               child: const CircleAvatar(
                                 radius: 4,
                                 backgroundColor: AppColors.primary,
                               ),
                             ),

                             // second row of circles
                             Positioned(
                               top: MediaQuery.of(context).size.height * 0.1,
                               right: MediaQuery.of(context).size.width * 0.05,
                               child: const CircleAvatar(
                                 radius: 3,
                                 backgroundColor: AppColors.primary,
                               ),
                             ),
                             Positioned(
                               top: MediaQuery.of(context).size.height * 0.1,
                               left: MediaQuery.of(context).size.width * 0.05,
                               child: const CircleAvatar(
                                 radius: 3,
                                 backgroundColor: AppColors.primary,
                               ),
                             ),

                             // second row of circles
                             Positioned(
                               top: MediaQuery.of(context).size.height * 0.1,
                               left: MediaQuery.of(context).size.width * 0.21,
                               child: const CircleAvatar(
                                 radius: 3,
                                 backgroundColor: AppColors.primary,
                               ),
                             ),
                             Positioned(
                               top: MediaQuery.of(context).size.height * 0.1,
                               right: MediaQuery.of(context).size.width * 0.21,
                               child: const CircleAvatar(
                                 radius: 3,
                                 backgroundColor: AppColors.primary,
                               ),
                             ),

                             //third row of circles
                             Positioned(
                               top: MediaQuery.of(context).size.height * 0.15,
                               right: MediaQuery.of(context).size.width * 0.13,
                               child: const CircleAvatar(
                                 radius: 4,
                                 backgroundColor: AppColors.primary,
                               ),
                             ),
                             Positioned(
                               top: MediaQuery.of(context).size.height * 0.15,
                               left: MediaQuery.of(context).size.width * 0.13,
                               child: const CircleAvatar(
                                 radius: 4,
                                 backgroundColor: AppColors.primary,
                               ),
                             ),
                           Positioned(top: 0,
                             left: 0,
                             right: 0,child:  Container(
height: 90,
                             padding: EdgeInsets.all(6),
                             decoration: BoxDecoration(
                                 color: Colors.white,
                                 shape: BoxShape.circle,
                                 border: Border.all(color: AppColors.grey3, width: 3)),
                             child: Image.asset(ImageAssests.profileImage),
                           ),
                           )

                           ],),
                         ),

                         const Text(
                           'محمد محمد',//todo-->
                           style: TextStyle(
                               fontWeight: FontWeight.w700, fontSize: 18),
                         ),
                         const Text(
                           '01030504268',//todo-->
                           style: TextStyle(
                               fontWeight: FontWeight.w400, fontSize: 18),
                         ),
                         Container(
                           margin: const EdgeInsets.symmetric(
                               horizontal: 20, vertical: 10),
                           padding: const EdgeInsets.symmetric(
                               horizontal: 10, vertical: 6),
                           width: MediaQuery.of(context).size.width * 0.85,
                           decoration: BoxDecoration(
                               shape: BoxShape.rectangle,
                               borderRadius: BorderRadius.circular(10),
                               border:
                                   Border.all(width: 2, color: AppColors.grey3)),
                           child: InkWell(
                             onTap: () {
                               cubit.changeApplicationLanguage(context);
                               // EasyLocalization.of(context)?.setLocale(Locale('en', ''));
                             },
                             child: Row(
                               children: [
                                 Image.asset(ImageAssests.languageIcon),
                                 const SizedBox(
                                   width: 15,
                                 ),
                                 const Text(
                                   AppStrings.language,
                                   style: TextStyle(
                                       fontSize: 18, fontWeight: FontWeight.w700),
                                 ).tr(),
                                 SizedBox(
                                   width: MediaQuery.of(context).size.width * 0.4,
                                 ),
                                 Localizations.localeOf(context) == Locale("en")
                                     ? Text(cubit.arabicSymbol)
                                     : Text(cubit.englishSymbol)
                               ],
                             ),
                           ),
                         ),
                         InkWell(
                           onTap: () {
                             Navigator.pushNamed(context, Routes.contactUsRoute);
                           },
                           child: Container(
                             margin: const EdgeInsets.symmetric(
                                 horizontal: 20, vertical: 10),
                             padding: const EdgeInsets.symmetric(
                                 horizontal: 10, vertical: 6),
                             width: MediaQuery.of(context).size.width * 0.85,
                             decoration: BoxDecoration(
                                 shape: BoxShape.rectangle,
                                 borderRadius: BorderRadius.circular(10),
                                 border:
                                     Border.all(width: 2, color: AppColors.grey3)),
                             child: Row(
                               children: [
                                 Image.asset(ImageAssests.contactUsIcon),
                                 const SizedBox(
                                   width: 15,
                                 ),
                                 const Text(
                                   AppStrings.contactUs,
                                   style: TextStyle(
                                       fontSize: 18, fontWeight: FontWeight.w700),
                                 ).tr(),
                               ],
                             ),
                           ),
                         ),
                         Container(
                           margin: const EdgeInsets.symmetric(
                               horizontal: 20, vertical: 10),
                           padding: const EdgeInsets.symmetric(
                               horizontal: 10, vertical: 6),
                           width: MediaQuery.of(context).size.width * 0.85,
                           decoration: BoxDecoration(
                               shape: BoxShape.rectangle,
                               borderRadius: BorderRadius.circular(10),
                               border:
                                   Border.all(width: 2, color: AppColors.grey3)),
                           child: Row(
                             children: [
                               Image.asset(ImageAssests.shareAppIcon),
                               const SizedBox(
                                 width: 15,
                               ),
                               const Text(
                                 AppStrings.shareApp,
                                 style: TextStyle(
                                     fontSize: 18, fontWeight: FontWeight.w700),
                               ).tr(),
                             ],
                           ),
                         ),
                         Container(
                           margin: const EdgeInsets.symmetric(
                               horizontal: 20, vertical: 10),
                           padding: const EdgeInsets.symmetric(
                               horizontal: 10, vertical: 6),
                           width: MediaQuery.of(context).size.width * 0.85,
                           decoration: BoxDecoration(
                               shape: BoxShape.rectangle,
                               borderRadius: BorderRadius.circular(10),
                               border:
                                   Border.all(width: 2, color: AppColors.grey3)),
                           child: Row(
                             children: [
                               Image.asset(ImageAssests.rateAppIcon),
                               const SizedBox(
                                 width: 15,
                               ),
                               const Text(
                                 AppStrings.rateApp,
                                 style: TextStyle(
                                     fontSize: 18, fontWeight: FontWeight.w700),
                               ).tr(),
                             ],
                           ),
                         ),
                         InkWell(
                           onTap: () {
                             Navigator.pushReplacementNamed(
                                 context, Routes.loginRoute);
                           },
                           child: Container(
                             margin: const EdgeInsets.symmetric(
                                 horizontal: 20, vertical: 10),
                             padding: const EdgeInsets.symmetric(
                                 horizontal: 10, vertical: 6),
                             width: MediaQuery.of(context).size.width * 0.85,
                             decoration: BoxDecoration(
                                 shape: BoxShape.rectangle,
                                 borderRadius: BorderRadius.circular(10),
                                 border:
                                     Border.all(width: 2, color: AppColors.grey3)),
                             child: Row(
                               children: [
                                 Image.asset(ImageAssests.logOutIcon),
                                 const SizedBox(
                                   width: 15,
                                 ),
                                 const Text(
                                   AppStrings.logout,
                                   style: TextStyle(
                                       fontSize: 18, fontWeight: FontWeight.w700),
                                 ).tr(),
                               ],
                             ),
                           ),
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Image.asset(ImageAssests.facebookIcon),
                             const SizedBox(
                               width: 10,
                             ),
                             Image.asset(ImageAssests.instagramIcon),
                             const SizedBox(
                               width: 10,
                             ),
                             Image.asset(ImageAssests.twitterIcon),
                             const SizedBox(
                               width: 10,
                             ),
                             Image.asset(ImageAssests.linkedInIcon),
                           ],
                         )
                       ],
                     ),
                   ),
                 ) ,



               //
               //  //first 2 circles

               //
               //  //profile image
               //  Positioned(
               //      top: MediaQuery.of(context).size.height * 0.22,
               //      child:,
               //
               //  //all fields
               // // Positioned(
               //    // top: MediaQuery.of(context).size.height * 0.17,
               //    // right: 0,
               //    // left: 0,
               //    // bottom: 0,
               //  //  child:
               //    SingleChildScrollView(
               //      child: Column(
               //        children: [
               //          const Text(
               //            'محمد محمد',
               //            style: TextStyle(
               //                fontWeight: FontWeight.w700, fontSize: 18),
               //          ),
               //          const Text(
               //            '01030504268',
               //            style: TextStyle(
               //                fontWeight: FontWeight.w400, fontSize: 18),
               //          ),
               //          Container(
               //            margin: const EdgeInsets.symmetric(
               //                horizontal: 20, vertical: 10),
               //            padding: const EdgeInsets.symmetric(
               //                horizontal: 10, vertical: 6),
               //            width: MediaQuery.of(context).size.width * 0.85,
               //            decoration: BoxDecoration(
               //                shape: BoxShape.rectangle,
               //                borderRadius: BorderRadius.circular(10),
               //                border:
               //                    Border.all(width: 2, color: AppColors.grey3)),
               //            child: InkWell(
               //              onTap: () {
               //                cubit.changeApplicationLanguage(context);
               //                // EasyLocalization.of(context)?.setLocale(Locale('en', ''));
               //              },
               //              child: Row(
               //                children: [
               //                  Image.asset(ImageAssests.languageIcon),
               //                  const SizedBox(
               //                    width: 15,
               //                  ),
               //                  const Text(
               //                    AppStrings.language,
               //                    style: TextStyle(
               //                        fontSize: 18, fontWeight: FontWeight.w700),
               //                  ).tr(),
               //                  SizedBox(
               //                    width: MediaQuery.of(context).size.width * 0.4,
               //                  ),
               //                  Localizations.localeOf(context) == Locale("en")
               //                      ? Text(cubit.arabicSymbol)
               //                      : Text(cubit.englishSymbol)
               //                ],
               //              ),
               //            ),
               //          ),
               //          InkWell(
               //            onTap: () {
               //              Navigator.pushNamed(context, Routes.contactUsRoute);
               //            },
               //            child: Container(
               //              margin: const EdgeInsets.symmetric(
               //                  horizontal: 20, vertical: 10),
               //              padding: const EdgeInsets.symmetric(
               //                  horizontal: 10, vertical: 6),
               //              width: MediaQuery.of(context).size.width * 0.85,
               //              decoration: BoxDecoration(
               //                  shape: BoxShape.rectangle,
               //                  borderRadius: BorderRadius.circular(10),
               //                  border:
               //                      Border.all(width: 2, color: AppColors.grey3)),
               //              child: Row(
               //                children: [
               //                  Image.asset(ImageAssests.contactUsIcon),
               //                  const SizedBox(
               //                    width: 15,
               //                  ),
               //                  const Text(
               //                    AppStrings.contactUs,
               //                    style: TextStyle(
               //                        fontSize: 18, fontWeight: FontWeight.w700),
               //                  ).tr(),
               //                ],
               //              ),
               //            ),
               //          ),
               //          Container(
               //            margin: const EdgeInsets.symmetric(
               //                horizontal: 20, vertical: 10),
               //            padding: const EdgeInsets.symmetric(
               //                horizontal: 10, vertical: 6),
               //            width: MediaQuery.of(context).size.width * 0.85,
               //            decoration: BoxDecoration(
               //                shape: BoxShape.rectangle,
               //                borderRadius: BorderRadius.circular(10),
               //                border:
               //                    Border.all(width: 2, color: AppColors.grey3)),
               //            child: Row(
               //              children: [
               //                Image.asset(ImageAssests.shareAppIcon),
               //                const SizedBox(
               //                  width: 15,
               //                ),
               //                const Text(
               //                  AppStrings.shareApp,
               //                  style: TextStyle(
               //                      fontSize: 18, fontWeight: FontWeight.w700),
               //                ).tr(),
               //              ],
               //            ),
               //          ),
               //          Container(
               //            margin: const EdgeInsets.symmetric(
               //                horizontal: 20, vertical: 10),
               //            padding: const EdgeInsets.symmetric(
               //                horizontal: 10, vertical: 6),
               //            width: MediaQuery.of(context).size.width * 0.85,
               //            decoration: BoxDecoration(
               //                shape: BoxShape.rectangle,
               //                borderRadius: BorderRadius.circular(10),
               //                border:
               //                    Border.all(width: 2, color: AppColors.grey3)),
               //            child: Row(
               //              children: [
               //                Image.asset(ImageAssests.rateAppIcon),
               //                const SizedBox(
               //                  width: 15,
               //                ),
               //                const Text(
               //                  AppStrings.rateApp,
               //                  style: TextStyle(
               //                      fontSize: 18, fontWeight: FontWeight.w700),
               //                ).tr(),
               //              ],
               //            ),
               //          ),
               //          InkWell(
               //            onTap: () {
               //              Navigator.pushReplacementNamed(
               //                  context, Routes.loginRoute);
               //            },
               //            child: Container(
               //              margin: const EdgeInsets.symmetric(
               //                  horizontal: 20, vertical: 10),
               //              padding: const EdgeInsets.symmetric(
               //                  horizontal: 10, vertical: 6),
               //              width: MediaQuery.of(context).size.width * 0.85,
               //              decoration: BoxDecoration(
               //                  shape: BoxShape.rectangle,
               //                  borderRadius: BorderRadius.circular(10),
               //                  border:
               //                      Border.all(width: 2, color: AppColors.grey3)),
               //              child: Row(
               //                children: [
               //                  Image.asset(ImageAssests.logOutIcon),
               //                  const SizedBox(
               //                    width: 15,
               //                  ),
               //                  const Text(
               //                    AppStrings.logout,
               //                    style: TextStyle(
               //                        fontSize: 18, fontWeight: FontWeight.w700),
               //                  ).tr(),
               //                ],
               //              ),
               //            ),
               //          ),
               //          Row(
               //            mainAxisAlignment: MainAxisAlignment.center,
               //            children: [
               //              Image.asset(ImageAssests.facebookIcon),
               //              const SizedBox(
               //                width: 10,
               //              ),
               //              Image.asset(ImageAssests.instagramIcon),
               //              const SizedBox(
               //                width: 10,
               //              ),
               //              Image.asset(ImageAssests.twitterIcon),
               //              const SizedBox(
               //                width: 10,
               //              ),
               //              Image.asset(ImageAssests.linkedInIcon),
               //            ],
               //          )
               //        ],
               //      ),
               //    ),
              //  ),

                //social media row
                // Positioned(
                //     top: MediaQuery.of(context).size.height * 0.89,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Image.asset(ImageAssests.facebookIcon),
                //         const SizedBox(
                //           width: 10,
                //         ),
                //         Image.asset(ImageAssests.instagramIcon),
                //         const SizedBox(
                //           width: 10,
                //         ),
                //         Image.asset(ImageAssests.twitterIcon),
                //         const SizedBox(
                //           width: 10,
                //         ),
                //         Image.asset(ImageAssests.linkedInIcon),
                //       ],
                //     )),
              ],
            ),
          ),
        );
      },
    );
  }
}
