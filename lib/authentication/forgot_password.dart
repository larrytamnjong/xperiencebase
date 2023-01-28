import 'package:flutter/material.dart';
import 'package:xperiencebase/widgets_functions/functions/lunch_whatsapp.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';
import 'package:xperiencebase/widgets_functions/widgets/form_header.dart';
import 'package:xperiencebase/widgets_functions/widgets/textformfield.dart';
import 'package:xperiencebase/widgets_functions/functions/validator.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController phone = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Reset password',
        actions: [
          IconButton(
              onPressed: () {
                launchWhatsApp(context: context);
              },
              icon: const Icon(Icons.chat)),
          const SizedBox(width: 12.0)
        ],
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
                        'Please enter the phone number associated with your account inorder to get a one time password.'),
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
                  text: 'Continue',
                  buttonColor: kPrimaryColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      debugPrint('great');
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
