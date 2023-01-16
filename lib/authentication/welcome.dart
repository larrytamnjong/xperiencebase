import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xperiencebase/authentication/login.dart';
import 'package:xperiencebase/authentication/registration/r_name.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'package:xperiencebase/widgets_functions/functions/pagenavigation.dart';
import 'package:xperiencebase/widgets_functions/functions/snackbar_menus.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
            const  Image(
               image:  AssetImage('images/logo.jpeg'),
               width: 306.0,
               height: 300.0,
               // width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(
                child: Text(
                  'We believe in building trust',
                  style: TextStyle(
                    fontFamily: 'Lora',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              CustomPadding(
                top: 43.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RoundedTextButton(
                        buttonColor: kPrimaryColor,
                        text: 'SIGN IN',
                        onPressed: () {
                          changePage(context: context, page: const Login());
                        },
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      RoundedTextButton(
                          text: 'REGISTRATION',
                          buttonColor: kSecondaryColor,
                          onPressed: () {
                            changePage(context: context, page: const Name());
                          }),
                      const Disclaimer(
                        text:
                            'By clicking either Sign in or Registration you confirm that you have read, understood, and agree with Our Privacy Policy and Terms and Conditions.',
                        url: 'https://masculine-passenger.000webhostapp.com/privacy%20policy/privacy%20policy.html',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Disclaimer extends StatelessWidget {
  final String text;
  final String url;
  const Disclaimer({
    super.key,
    required this.text,
    required this.url,
  });
  Future<void> launchReadPolicy(String url, BuildContext context) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      showToast(
        title: 'Oops',
        body:
            "We encountered an error please visit $url for Our Terms and Conditions or Privacy Policy",
        snackBarType: ContentType.help,
        context: context,
      );
    } else {
      //Do something here if launch is successful
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(color: kBlackColor, fontSize: 13.0),
          ),
          const SizedBox(
            height: 10.0,
          ),
          InkWell(
            child: const Text(
              'Read Our Privacy Policy and Terms and Conditions',
              style: TextStyle(
                  color: kLinkColor, decoration: TextDecoration.underline),
              textAlign: TextAlign.left,
            ),
            onTap: () {
              launchReadPolicy(url, context);
            },
          ),
        ],
      ),
    );
  }
}
