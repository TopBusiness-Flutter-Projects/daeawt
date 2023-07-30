import 'package:daeawt/features/home/cubit/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart'as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/home_app_bar.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../widgets/home_list_item.dart';

class HomeTab extends StatelessWidget {
  HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? languageCode = easy.EasyLocalization.of(context)?.locale.languageCode;
    HomeCubit cubit = context.read<HomeCubit>();

    return Scaffold(
      body: Column(
        children: [
          const HomeAppBar(),
          //search
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
          //all invitations
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
                    const Text(
                      AppStrings.allInvitations,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is InvitationsHomeLoading) {
                  return const Center(child: ShowLoadingIndicator());
                }
                else if (state is InvitationsHomeError) {
                  return Center(
                    child: Image.asset(ImageAssests.noDataIcon,
                    width: 60,
                      height: 60,
                    )
                    // NoDataWidget(
                    //   onclick: () {
                    //     cubit.geInvitationsHome();
                    //   },
                    //   title: 'no_data'.tr(),
                    // ),
                  );
                }
                else {
                  if (cubit.invitationsList.isNotEmpty) {
                    return ListView.builder(
                      itemCount: cubit.invitationsList.length,
                      itemBuilder: (context, index) {
                        return HomeListItem(
                          homeListItemModel:
                              cubit.invitationsList.elementAt(index),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child:Image.asset(ImageAssests.noDataIcon,
                        width: 60,
                        height: 60,
                      )
                      // NoDataWidget(
                      //   onclick: () {
                      //     cubit.geInvitationsHome();
                      //   },
                      //   title: 'no_data'.tr(),
                      // ),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
