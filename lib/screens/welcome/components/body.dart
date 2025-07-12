import 'package:flutter/material.dart';
import 'package:tcc/components/rounded_button.dart';
import 'package:tcc/screens/login/login_screen.dart';
import 'package:tcc/screens/signup/signup_screen.dart';

import 'package:tcc/screens/welcome/components/background.dart' show Background;

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
          colors: [Colors.yellow[700]!, Colors.yellow[500]!],
          )
        
          .createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height)
          ),
        
          child: Text(
            "BEM-VINDO(A) A SAPEM",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
                color: Colors.white,
            ),
          ),
        
        ),
        
            SizedBox(
              height: 45
            ),
            
            Image.asset(
              "assets/icons/png/ceu-familia.png",
              height: size.height * 0.30,
            ),
        
            RoundedButton(
              text: "LOGIN", 
              press: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
              },
            ),
        
            RoundedButton(
              text: "SIGN UP",
              press: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => SignUpScreen(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}


