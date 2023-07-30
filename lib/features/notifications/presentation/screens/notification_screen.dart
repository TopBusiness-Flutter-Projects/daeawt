import 'package:daeawt/core/utils/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../../../../core/widgets/small_bottom_curve.dart';
import '../../../home/presentation/widgets/notification_list_item.dart';
import '../../cubit/notifications_cubit.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotificationsCubit cubit = context.read<NotificationsCubit>();
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, Routes.homeRoute);
        return true;
      },
      child: Scaffold(
        body: Column(
          children: [
            ClipPath(
              clipper: SmallBottomCurveClipper(),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                      AppColors.orange2,
                      AppColors.primary,
                    ])),
                    padding: const EdgeInsets.symmetric(
                        vertical: 60, horizontal: 40),
                    height: 160,
                    width: double.infinity,
                    child: const Text(
                      AppStrings.notifications,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ).tr(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<NotificationsCubit, NotificationsState>(
                builder: (context, state) {
                  if (state is NotificationLoading) {
                    return const Center(child: ShowLoadingIndicator());
                  } else if (state is NotificationError) {
                    return Center(child: Image.asset(ImageAssests.noDataIcon,
                      width: 60,
                      height: 60,)
                        // NoDataWidget(
                        //   onclick: () {
                        //     cubit.geInvitationsHome();
                        //   },
                        //   title: 'no_data'.tr(),
                        // ),
                        );
                  } else {
                    if (cubit.invitationsList.isNotEmpty) {
                      return ListView.separated(
                        itemCount: cubit.invitationsList.length,
                        itemBuilder: (context, index) {
                          return  NotificationsListItem(notificationModel: cubit.invitationsList[index]);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      );
                    } else {
                      return Center(child: Image.asset(ImageAssests.noDataIcon,
                        width: 60,
                        height: 60,)
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
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
