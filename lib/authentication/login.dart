import 'package:flutter/material.dart';
import 'package:xperiencebase/app_screens/main_route.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'package:xperiencebase/widgets_functions/functions/pagenavigation.dart';
import 'package:xperiencebase/widgets_functions/widgets/textformfield.dart';
import 'package:xperiencebase/widgets_functions/functions/validator.dart';
import 'package:xperiencebase/authentication/forgot_password.dart';
import 'package:xperiencebase/widgets_functions/widgets/loading.dart';
import 'package:xperiencebase/widgets_functions/functions/api.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:xperiencebase/widgets_functions/functions/snackbar_menus.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingScreen(
            waitingText: "We're signing you in",
          )
        : Scaffold(
            //prevents scaffold from pushing widget above when keyboard pops up
            resizeToAvoidBottomInset: false,
            appBar: const CustomAppBar(
              title: 'Sign In',
            ),
            body: SingleChildScrollView(
              reverse: true,
              child: CustomPadding(
                top: 37.0,
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Please enter your phone number and password',
                          style: TextStyle(
                              fontSize: 17.4, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        UnderlineTextFormField(
                          validator: phoneValidator,
                          controller: phone,
                          labelText: 'Phone',
                          obscureText: false,
                          textInputType: TextInputType.phone,
                        ),
                        UnderlineTextFormField(
                          labelText: 'Password',
                          validator: passwordValidator,
                          controller: password,
                          obscureText: true,
                          textInputType: TextInputType.text,
                        ),
                        CustomTextButton(
                            text: 'I forgot my password',
                            onPressed: () {
                              changePage(
                                  context: context,
                                  page: const ForgotPassword());
                            }),
                        const SizedBox(
                          height: 20.0,
                        ),
                        RoundedTextButton(
                          text: 'SIGN IN',
                          buttonColor: kPrimaryColor,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                startLoading();
                              });
                              UserVariables.password = password.text;
                              UserVariables.phone = phone.text;
                              var result = await Api.userLogin();
                                if(result == '1') {
                                  if (!mounted) return;
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const MainRoute()),
                                          (Route<dynamic> route) => false);
                                  setState(() {
                                    stopLoading();
                                  });
                                  displaySnackBar(
                                      context: context,
                                      content:
                                      Text("Welcome ${UserVariables.name}"),
                                      backgroundColor: kPrimaryColor);
                                }
                                else if(result == '2') {
                                  showToast(
                                      title: "Not found ",
                                      body:
                                      "Account does not exist please verify your phone number",
                                      snackBarType: ContentType.warning,
                                      context: context);
                                  setState(() {
                                    stopLoading();
                                  });
                                }
                               else if(result == '4') {
                                  showToast(
                                      title: "Incorrect",
                                      body:
                                      "Your password or phone is not correct",
                                      snackBarType: ContentType.failure,
                                      context: context);
                                  setState(() {
                                    stopLoading();
                                  });
                                }
                               else{
                                  showToast(
                                      title: "Failed",
                                      body:
                                          "Please check your connection or $result",
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
            ),
          );
  }
}
