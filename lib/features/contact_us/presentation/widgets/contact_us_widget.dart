import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';

class ContactUs extends StatelessWidget {
 final Widget? prefixIcon;
 final String? hint;
final TextInputType textInputType ;
final int? minLines ;
final int? maxLines ;
  const ContactUs({Key? key,this.prefixIcon,this.hint,this.textInputType = TextInputType.text,
  this.minLines=1,this.maxLines = 2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 18),
      child: TextFormField(
        minLines: minLines,
        maxLines:maxLines,
        keyboardType:textInputType ,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            prefixIcon: prefixIcon,
            hintText:hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              // borderSide: BorderSide(color: Colors.green,width: 20)
            )
        ),
      ),
    );
  }
}
