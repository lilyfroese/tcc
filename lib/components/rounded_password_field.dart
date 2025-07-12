import 'package:flutter/material.dart';
import 'package:tcc/components/text_field_container.dart';


class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String hintText;
  final IconData icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const RoundedPasswordField({
    super.key,
    this.hintText = "SENHA",
    this.icon = Icons.lock,
    this.onChanged,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        obscureText: true,
        validator: validator,
        onChanged: onChanged,
        cursorColor: Colors.white70,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.1,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white54,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.1,
          ),
          border: InputBorder.none,
          icon: Icon(
            icon,
            color: Colors.white70,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: Colors.white70,
          ),
          contentPadding: EdgeInsets.only(top: 4),
        ),
      ),
    );
  }
}
