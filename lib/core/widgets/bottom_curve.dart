import 'package:flutter/material.dart';

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var h = size.height;
    var w = size.width;
    path.lineTo(0, h); //points 1,2

    path.quadraticBezierTo(w * 0.2, h * 0.7, w * 0.4, h*0.8); //points 3,4
    //  4    //   5
    //path.quadraticBezierTo(w * 0.55, h, w * 0.6, h * 0.99); //points 5,6

    path.quadraticBezierTo(w * 0.75, h , w, h*0.75); //points 7,8

    path.lineTo(w, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}