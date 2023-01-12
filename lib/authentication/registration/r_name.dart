import 'dart:math';
import 'package:flutter/material.dart';
import 'package:xperiencebase/authentication/registration/r_birthdate.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'package:xperiencebase/widgets_functions/functions/pagenavigation.dart';
import 'package:xperiencebase/widgets_functions/widgets/form_header.dart';
import 'package:xperiencebase/widgets_functions/widgets/textformfield.dart';
import 'package:xperiencebase/widgets_functions/functions/validator.dart';

class Name extends StatefulWidget {
  const Name({Key? key}) : super(key: key);

  @override
  State<Name> createState() => _NameState();
}

class _NameState extends State<Name> {
  TextEditingController name = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Name',
      ),
      body: SingleChildScrollView(
        child: CustomPadding(
          top: 35.0,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const FormHeader(
                  heading: "What's your name?",
                  body:
                      'Enter your full names as found on your birth certificate, passport, or any other official document.',
                ),
                UnderlineTextFormField(
                    labelText: 'Name',
                    validator: requiredValidator,
                    controller: name,
                    obscureText: false,
                    textInputType: TextInputType.text),
                const SizedBox(
                  height: 45.0,
                ),
                RoundedTextButton(
                  text: 'Next',
                  buttonColor: kPrimaryColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      UserVariables.name = name.text.toUpperCase();
                      UserVariables.accountNumber =
                          "${Random().nextInt(521455) + 855226}${DateTime.now().year}";

                      changePage(context: context, page: const BirthDate());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
