import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    super.key, 
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10, 
        horizontal: 20
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20, 
        vertical: 5
      ),
      width: size.width * 0.7, 
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
        colors: [Colors.blue[300]!, Colors.blue[100]!],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}

