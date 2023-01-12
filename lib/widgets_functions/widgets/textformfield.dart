import 'package:flutter/material.dart';

import 'package:xperiencebase/constants/colors.dart';

///Underlined Input TextFormField
class UnderlineTextFormField extends StatelessWidget {
  final String labelText;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? textInputType;

  const UnderlineTextFormField({
    super.key,
    required this.labelText,
    required this.validator,
    required this.controller,
    required this.obscureText,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 6.5, bottom: 6.5, left: 10.0, right: 10.0),
      child: TextFormField(
        keyboardType: textInputType,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black38, fontSize: 15.0),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kBlackColor, width: 2.0),
          ),
          enabled: true,
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kBlackColor)),
          contentPadding: const EdgeInsets.only(bottom: 0.5),
        ),
      ),
    );
  }
}
