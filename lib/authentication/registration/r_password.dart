import 'package:flutter/material.dart';
import 'package:xperiencebase/authentication/welcome.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/functions/snackbar_menus.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'package:xperiencebase/widgets_functions/widgets/form_header.dart';
import 'package:xperiencebase/widgets_functions/widgets/textformfield.dart';
import 'package:xperiencebase/widgets_functions/functions/validator.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/functions/api.dart';
import 'package:xperiencebase/widgets_functions/widgets/loading.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingScreen(
            waitingText: "We're registering you",
          )
        : Scaffold(
            //prevents scaffold from pushing widget above when keyboard pops up
            resizeToAvoidBottomInset: false,
            appBar: const CustomAppBar(title: 'Password'),
            body: SingleChildScrollView(
              reverse: true,
              child: CustomPadding(
                top: 35.0,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const FormHeader(
                        heading: 'Create a strong password',
                        body:
                            'Create any password of your choice of between 6 to 9 digits.',
                      ),
                      UnderlineTextFormField(
                        labelText: 'Password',
                        validator: passwordValidator,
                        controller: password,
                        obscureText: true,
                        textInputType: TextInputType.text,
                      ),
                      UnderlineTextFormField(
                        labelText: 'Repeat password',
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          } else if (password.text != confirmPassword.text) {
                            return "Password's don't match";
                          } else if (password.text == confirmPassword.text) {
                            return null;
                          }
                          return null;
                        },
                        controller: confirmPassword,
                        obscureText: true,
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 45.0,
                      ),
                      RoundedTextButton(
                        text: 'Next',
                        buttonColor: kPrimaryColor,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            UserVariables.password = password.text;
                            setState(() {
                              startLoading();
                            });
                            var result = await Api.userRegistration();
                            if (result == '1') {
                              showToast(
                                  title: 'Successful',
                                  body:
                                      "Your registration was successful, you can sign in now.",
                                  snackBarType: ContentType.success,
                                  context: context);
                              setState(() {
                                stopLoading();
                              });
                              if (!mounted) return;
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const Welcome()),
                                  (Route<dynamic> route) => false);
                            } else if (result == '0') {
                              showToast(
                                  title: "Couldn't register ",
                                  body:
                                      "Account already exist please use another phone or try password recovery",
                                  snackBarType: ContentType.warning,
                                  context: context);
                              setState(() {
                                stopLoading();
                              });
                            } else {
                              showToast(
                                  title: 'Unsuccessful',
                                  body: "Please check your connection $result",
                                  snackBarType: ContentType.failure,
                                  context: context);
                              setState(() {
                                stopLoading();
                              });
                            }
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
