import 'package:flutter/material.dart';
import 'package:taskroute/style/theme.dart';

typedef validationFieled = String? Function(String?)?;

class customTextfiled extends StatelessWidget {
  String hintText;
  TextInputType keyboard;
  TextEditingController controller;
  bool ObscureText;
  Widget? suffixIcon;
  validationFieled validator;
  customTextfiled({
    required this.keyboard,
    required this.controller,
    this.ObscureText = false,
    this.suffixIcon,
    this.validator,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          suffixIconColor: Theme.of(context).colorScheme.secondary,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.titleSmall,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
      keyboardType: keyboard,
      cursorColor: Colors.grey,
      controller: controller,
      obscureText: ObscureText,
      obscuringCharacter: "*",
      validator: validator,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}
