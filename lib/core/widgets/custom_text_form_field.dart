import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  Widget? prefixIcon;
  String? hintText;
  void Function(String)? onChanged;

  TextEditingController? textController;
  bool? isenable;
   CustomTextFormField({this.prefixIcon,this.hintText,Key? key,this.onChanged,this.textController,this.isenable=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   TextFormField(
      keyboardType: TextInputType.text,
      controller:textController ,
      enabled: isenable,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'field_valid'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 8,horizontal: 5),
          prefixIcon: prefixIcon,
          hintText: '$hintText'.tr(),
          border:  OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: AppColors.grey1,
          filled: true

      ),
      onChanged: onChanged,
    );
  }
}
