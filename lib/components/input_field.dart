import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  TextEditingController controller;
  String labelText;
  bool obscureText;
  String? Function(String?)? validator;

  InputField({required this.controller, required this.labelText, required this.obscureText, required this.validator, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.white,
      textInputAction: TextInputAction.next,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade300),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
    );
  }
}
