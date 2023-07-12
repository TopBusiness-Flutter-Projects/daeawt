import 'package:flutter/material.dart';

class SmallBottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var h = size.height;
    var w = size.width;
    path.lineTo(0, h); //points 1,2

    path.quadraticBezierTo(w*0.009 , h*0.74 , w * 0.2, h*0.74);

    path.lineTo(w * 0.9, h*0.74);

    path.quadraticBezierTo(w*0.99, h*0.74,w ,h*0.3 );

    path.lineTo(w, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}