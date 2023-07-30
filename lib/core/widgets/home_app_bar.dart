import 'package:daeawt/core/widgets/custom_text_form_field.dart';
import 'package:daeawt/core/widgets/small_bottom_curve.dart';
import 'package:daeawt/preferences/preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key,this.isBackArrowVisible = false}) : super(key: key);
  final bool isBackArrowVisible ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ClipPath(
        clipper: SmallBottomCurveClipper(),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                AppColors.orange2,
                AppColors.primary,
              ])),
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              height: 160,
              width: double.infinity,
              //color: Colors.orange,
            ),
              Positioned(
              top: 50,
              right: 15,
              child: Column(
                children: [
                  // const Text("مرحبا , ",
                  //   style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.white),
                  // ),
                  FutureBuilder(
                    future: Preferences.instance.getUserModel(),
                    builder: (context, snapshot) {
                    return  Text("welcome".tr()+snapshot.data!.data!.user!.name.toString(),
                      style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.white),
                    );
                  },),
                   Text("welcome_to".tr(),
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.white),),

                ],
              ),
            ),
            // Visibility(
            //   visible:isBackArrowVisible ,
            //   child: Positioned(
            //     left: 0,
            //     top: 40,
            //     child: IconButton(
            //       onPressed: () {
            //         Navigator.pop(context);
            //       },
            //       icon:
            //           const Icon(Icons.arrow_back, color: Colors.white, size: 30),
            //     ),
            //   ),
            // ),
          ],
        ),

      ),
    );
  }
}
