import 'package:flutter/material.dart';
import 'package:xperiencebase/authentication/registration/r_password.dart';

import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';

import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'package:xperiencebase/widgets_functions/widgets/form_header.dart';
import 'package:xperiencebase/widgets_functions/widgets/textformfield.dart';
import 'package:xperiencebase/widgets_functions/functions/validator.dart';

import 'package:xperiencebase/widgets_functions/functions/pagenavigation.dart';

import 'package:xperiencebase/widgets_functions/functions/variables.dart';

class Email extends StatefulWidget {
  const Email({Key? key}) : super(key: key);

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  TextEditingController email = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Email',
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
                  heading: "What's your email address",
                  body:
                      'We will use your email address to send all billing information and receipts',
                ),
                UnderlineTextFormField(
                  labelText: 'Email',
                  validator: emailValidator,
                  controller: email,
                  obscureText: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 45.0,
                ),
                RoundedTextButton(
                  text: 'Next',
                  buttonColor: kPrimaryColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      UserVariables.email = email.text;
                      changePage(context: context, page: const Password());
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
