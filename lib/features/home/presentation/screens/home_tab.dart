import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/home_app_bar.dart';
import '../../models/home_list_item_model.dart';
import '../widgets/home_list_item.dart';

class HomeTab extends StatelessWidget {
   HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        children: [
          const HomeAppBar(),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 60,
              child: CustomTextFormField(
                hintText: AppStrings.searchYourInvitations,
                prefixIcon: const Icon(Icons.search),
              )),
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
                      AppStrings.allInvitations,
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
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 15,),
              padding: const EdgeInsets.all(9),
              itemCount: 5,
              itemBuilder: (context, index) {
                return   HomeListItem(homeListItemModel:homeItems[index] ,);
              },
            ),
          ),
        ],
      ),
    );
  }
}
