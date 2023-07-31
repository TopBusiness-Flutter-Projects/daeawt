import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/app_colors.dart';
import '../utils/assets_manager.dart';

class NoData extends StatelessWidget{
  final String data;
  const NoData({Key? key,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageAssests.noDataIcon,
              fit: BoxFit.cover,
              width: 30.w,
              height: 15.h,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                data,
                style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            )
          ],
        ));
  }
}
