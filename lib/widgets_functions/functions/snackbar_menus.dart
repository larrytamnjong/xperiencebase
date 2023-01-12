import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';

///SnackBar Function
void showToast({
  required String title,
  required String body,
  required ContentType snackBarType,
  required BuildContext context,
}) {
  var snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: body,
      contentType: snackBarType,
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

/// Easy Apply Confirmation Widget
class EasyApplyConfirmation extends StatelessWidget {
  final Function negative;
  final Function positive;

  const EasyApplyConfirmation({
    Key? key,
    required this.negative,
    required this.positive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 12.0, left: 13.0, right: 13.0, bottom: 5.0),
        child: Container(
          color: Colors.transparent,
          height: 300.0,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                    left: 143.0, right: 143.0, top: 2.0, bottom: 5.0),
                child: Divider(
                  thickness: 2.0,
                ),
              ),
              SizedBox(
                height: 100.0,
                width: 100.0,
                child: SvgPicture.asset('images/resume.svg'),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Do you really want to send this request?',
                style: TextStyle(
                    fontSize: 16.0,
                    color: kBlackColor,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Press confirm to send, please do not leave this page unless you get a response of either success or failure.',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 25.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RoundedTextButton(
                        text: 'Close',
                        buttonColor: kSecondaryColor,
                        onPressed: () {
                          negative();
                        }),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: RoundedTextButton(
                        text: 'Confirm',
                        buttonColor: kPrimaryColor,
                        onPressed: () {
                          positive();
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///SnackBar Function
void displaySnackBar(
    {required BuildContext context,
    required Widget content,
    required Color backgroundColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: content,
      backgroundColor: backgroundColor,
    ),
  );
}
