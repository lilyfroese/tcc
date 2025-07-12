import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    required this.child,
    super.key, 
  });


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
              "assets/images/main_top.png", 
              width: size.width * 1.3,
              )
            ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: size.width * 1.0,
            )
          ),
          child,
        ],
      ),
    );
  }
}