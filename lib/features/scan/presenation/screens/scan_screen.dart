import 'package:daeawt/core/utils/app_strings.dart';
import 'package:daeawt/features/scan/cubit/scan_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../../../../core/widgets/small_bottom_curve.dart';
import '../../widget/scan_list_item.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScanCubit cubit=context.read<ScanCubit>();
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
                      ]),
                    ),
                    padding:
                    const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
                    height: 200,
                    width: double.infinity,
                    child: const Text(
                      AppStrings.photoScan,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.white),
                    ).tr(),
                  ),
                ],
              ),
            ),
            Expanded(child:

            BlocBuilder<ScanCubit, ScanState>(
              builder: (context, state) {
                if (state is InvitationsSacanLoading) {
                  return const Center(child: ShowLoadingIndicator());
                }
                else if (state is InvitationsSacanError) {
                  return Center(
                      child: Image.asset(ImageAssests.noDataIcon)
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
                        return  ScanListItem(
                          homeListItemModel:
                          cubit.invitationsList.elementAt(index),
                        );
                      },
                    );
                  } else {
                    return Center(
                        child:Image.asset(ImageAssests.noDataIcon)
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
            ))
          ],
        ),
      ),
    );
  }
}
