import 'package:flutter/material.dart';

class ForgetYourPassword extends StatelessWidget {
  final Function press;
  const ForgetYourPassword({
    super.key,
    required this.press
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
       GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, " ");
          },
          child: Text(
            "Esqueceu sua senha?",
            style: TextStyle(
              color: Colors.blue[400]!,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.1,
            ),
          ),
        ),
      ],
    );
  }
}