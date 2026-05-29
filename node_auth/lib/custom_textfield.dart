import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final bool obscure;
  final String hint;
  final TextEditingController controller;
  const CustomTextfield({required this.hint, required this.obscure, required this.controller,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(style: BorderStyle.solid),
          ),
          hint: Text(hint),
        ),
      ),
    );
  }
}
