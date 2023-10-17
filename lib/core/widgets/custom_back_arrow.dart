import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:sizer/sizer.dart';
class CustomBackArrow extends StatelessWidget {
  const CustomBackArrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? languageCode =
        easy.EasyLocalization.of(context)?.locale.languageCode;
    return  Positioned(
        left: 20,
        top: 60,
        child: Transform.rotate(
          angle: languageCode == "ar" ? 0 : (3.14),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon:  Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size:.04*MediaQuery.of(context).size.height,
              )),
        ));
  }
}
