import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
 final String? text;
  void Function()? onPressed;
 final Color? backgroundColor;
   CustomButton({Key? key,this.text,required this.onPressed,this.backgroundColor = Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          minimumSize: Size(MediaQuery.of(context).size.width*0.75, 56)),
      onPressed: onPressed,
      child:  Text("$text",style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),).tr(),
    );
  }
}
