import 'package:flutter/material.dart';
import 'package:xperiencebase/authentication/registration/r_email.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'package:xperiencebase/widgets_functions/widgets/form_header.dart';
import 'package:xperiencebase/widgets_functions/widgets/textformfield.dart';
import 'package:xperiencebase/widgets_functions/functions/validator.dart';

import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';

import 'package:xperiencebase/widgets_functions/functions/pagenavigation.dart';

class Phone extends StatefulWidget {
  const Phone({Key? key}) : super(key: key);

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  TextEditingController phone = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Mobile phone',
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
                    heading: "What's your phone number?",
                    body:
                        'Please enter your phone number. We highly recommend you enter your WhatsApp number for easy communication.'),
                UnderlineTextFormField(
                  labelText: 'Phone',
                  validator: phoneValidator,
                  controller: phone,
                  obscureText: false,
                  textInputType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 45.0,
                ),
                RoundedTextButton(
                  text: 'Next',
                  buttonColor: kPrimaryColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      UserVariables.phone = phone.text;
                      changePage(context: context, page: const Email());
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
