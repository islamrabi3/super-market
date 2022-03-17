import 'package:flutter/material.dart';

class BuildTextFormField extends StatelessWidget {
  TextEditingController? controller;
  TextInputType? keyboardType;
  bool obscureText = false;
  String? Function(String?)? validator;
  Function(String)? onChanged;
  IconData? prefixIcon;
  String? hintText;
  String? labelText;
  String? counter;
  Widget? suffix;

  BuildTextFormField(
      {required this.controller,
      required this.keyboardType,
      required this.hintText,
      this.obscureText = false,
      this.prefixIcon,
      this.validator,
      this.counter,
      this.suffix,
      this.onChanged,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          suffix: suffix,
          prefixIcon: Icon(prefixIcon),
          hintText: hintText,
          fillColor: Colors.amber[30],
          filled: true,
          border: OutlineInputBorder(
            gapPadding: 5.0,
            borderRadius: BorderRadius.circular(20.0),
            // borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
