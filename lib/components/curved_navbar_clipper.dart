import 'package:flutter/material.dart';

class CurvedNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    final double width = size.width;
    final double height = size.height;

    final double curveDepth = 48; //curva
    final double curveStart = width * 0.36;
    final double curveEnd = width * 0.64;
    final double curveCenter = width * 0.5;

    path.lineTo(curveStart, 0);
    path.quadraticBezierTo(
      curveCenter,
      curveDepth,
      curveEnd,
      0,
    );
    path.lineTo(width, 0);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
