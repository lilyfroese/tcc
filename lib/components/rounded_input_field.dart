import 'package:flutter/material.dart';
import 'package:tcc/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const RoundedInputField({
    super.key,
    required this.hintText,
    this.icon = Icons.email,
    this.onChanged,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.1,
        ),
        cursorColor: Colors.white70,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white54,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.1,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(bottom: 7),
          icon: Icon(
            icon,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
