import 'package:flutter/material.dart';
import 'package:tcc/screens/signup/signup_screen.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press; 
  const AlreadyHaveAnAccountCheck({
    super.key,
    this.login = true,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Não tem uma conta?",
          style: TextStyle(
            color: Colors.blue[400]!,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.1,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                  builder: (context) => SignUpScreen(),
                ));
          },
          child: Text(
            " Criar uma",
            style: TextStyle(
              color: Colors.blue[700]!,
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
