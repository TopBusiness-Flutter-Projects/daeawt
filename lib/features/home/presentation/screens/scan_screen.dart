import 'package:daeawt/core/utils/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/small_bottom_curve.dart';
import '../widgets/scan_list_item.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
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
            Expanded(child: ListView.builder(
              itemBuilder: (context, index) {
                return const ScanListItem();
              },
            ))
          ],
        ),
      ),
    );
  }
}
