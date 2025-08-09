import 'package:flutter/material.dart';

class MyTextInput extends StatelessWidget {

  final TextEditingController controller;
  final bool obscureText;
  final String hintString;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const MyTextInput({
    required this.controller,
    required this.obscureText,
    required this.hintString,
    required this.prefixIcon,
    this.suffixIcon,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintString, 
          filled: true,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!)),
          fillColor: Colors.transparent,
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 12),
        ),
        obscureText: obscureText,
        autocorrect: false,
        enableSuggestions: false,
      ),
    );
  }

  String getValue() {
    return controller.text.trim();
  }
}
