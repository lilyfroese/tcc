import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color textColor;
  final List<Color>? gradientColors;

  const RoundedButton({
    super.key, 
    required this.text, 
    required this.press, 
    this.textColor = Colors.white54,
    this.gradientColors,

  });
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.7, 
      height: 50,
      child: ElevatedButton(
        onPressed: () => press(),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero, // pra evitar espaçamento interno que quebra o gradiente
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors ?? [Colors.yellow[800]!, Colors.yellow[300]!],
            ),
            borderRadius: BorderRadius.circular(30),
          ),

          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
