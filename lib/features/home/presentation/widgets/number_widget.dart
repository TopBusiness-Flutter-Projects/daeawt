import 'package:flutter/material.dart';

class NumberWidget extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;
 final Color? textColor;
  const NumberWidget({Key? key,this.text,this.backgroundColor,this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
      radius: 15,
      backgroundColor:backgroundColor ,
      child: Text("$text",style: TextStyle(color:textColor ),),
    );
  }
}
