import 'package:daeawt/features/home/cubit/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/home_app_bar.dart';
import '../../../../core/widgets/no_data.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../widgets/home_list_item.dart';

class HomeTab extends StatelessWidget {
  HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? languageCode =
        easy.EasyLocalization.of(context)?.locale.languageCode;

    HomeCubit cubit = context.read<HomeCubit>();

    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    return Column(
        children: [
          const HomeAppBar(),
          //search
         Expanded(
         child:   SingleChildScrollView(
         physics: AlwaysScrollableScrollPhysics(),

         child: Column(
         children: [
           SizedBox(
               width: MediaQuery.of(context).size.width * 0.8,
               height: 60,
               child: CustomTextFormField(
                 textController: cubit.searchController,
                 hintText: AppStrings.searchYourInvitations.tr(),
                 prefixIcon: const Icon(Icons.search),
                 onChanged: (p0) {
                   cubit.geInvitationsHome();
                 },
               )),
           //balance
           Container(
             margin: EdgeInsets.only(bottom: 10),
             width: 80.w,
             height: 10.h,
             decoration: BoxDecoration(
                 gradient: const LinearGradient(
                     begin: Alignment.centerRight,
                     end: Alignment.centerLeft,
                     colors: [
                       AppColors.primary,
                       AppColors.orange4
                     ]
                 ),
                 // color: AppColors.primary,
                 borderRadius: BorderRadius.circular(20)
             ),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("available_balance",style: TextStyle(
                       fontSize: 16.sp,
                       color: Colors.white,
                       fontWeight: FontWeight.w700
                   ),).tr(),
                   Row(
                     children: [
                       Text("${cubit.userModel?.data?.user?.balance}",
                           style: TextStyle(
                               fontSize: 16.sp,
                               color: Colors.white,
                               fontWeight: FontWeight.w400
                           )),
                       SizedBox(width: 5,),
                       Text("invitation",
                           style: TextStyle(
                               fontSize: 16.sp,
                               color: Colors.white,
                               fontWeight: FontWeight.w400
                           )).tr(),
                     ],
                   ),

                 ],
               ),
             ),
           ),
           //all invitations
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 18.0),
             child: Row(
               children: [
                 Stack(
                   alignment: languageCode == "ar"
                       ? Alignment.centerRight
                       : Alignment.centerLeft,
                   children: [
                     const CircleAvatar(
                       radius: 20,
                       backgroundColor: AppColors.primary,
                     ),
                     Text(
                       AppStrings.allInvitations,
                       style:
                       TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
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
           BlocBuilder<HomeCubit, HomeState>(
             builder: (context, state) {
               if (state is InvitationsHomeLoading) {
                 return const Center(child: ShowLoadingIndicator());
               } else if (state is InvitationsHomeError) {
                 return NoData(data:  'no_invitations'.tr(),);
               } else {
                 if (cubit.invitationsList.isNotEmpty) {
                   return ListView.builder(
                     physics: const NeverScrollableScrollPhysics(),
                     shrinkWrap: true,
                     itemCount: cubit.invitationsList.length,
                     itemBuilder: (context, index) {
                       return HomeListItem(
                         homeListItemModel:
                         cubit.invitationsList.elementAt(index),
                       );
                     },
                   );
                 } else {
                   return  NoData(data:  'no_invitations'.tr(),);
                 }
               }
             },
           ),
         ],
       ),
     ))
        ],
      );
  },
),
    );
  }
}
