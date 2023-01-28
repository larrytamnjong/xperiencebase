import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/functions/training_application_api.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';
import 'package:xperiencebase/widgets_functions/widgets/loading.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:xperiencebase/widgets_functions/functions/snackbar_menus.dart';
import 'package:xperiencebase/app_screens/main_route.dart';

import 'package:xperiencebase/widgets_functions/functions/account_brain.dart';
import 'package:xperiencebase/widgets_functions/functions/api.dart';

class ConfirmApplication extends StatefulWidget {
  const ConfirmApplication({Key? key}) : super(key: key);

  @override
  State<ConfirmApplication> createState() => _ConfirmApplicationState();
}

class _ConfirmApplicationState extends State<ConfirmApplication> {
  getAccountBalance() async {
    DepositVariables.totalDeposit = await Api.userTotalDeposit();
    WithdrawalVariables.totalWithdrawal = await Api.userTotalWithdrawal();
    UserVariables.accountBalance = calculateBalance(
        DepositVariables.totalDeposit, WithdrawalVariables.totalWithdrawal);
    if (mounted) {
      setState(() {
        UserVariables.accountBalance;
        _isSavingApplication = false;
      });
    }
  }

  bool _isSavingApplication = false;
  @override
  Widget build(BuildContext context) {
    return _isSavingApplication
        ? const LoadingScreen(waitingText: 'Sending application')
        : Scaffold(
            appBar: const CustomAppBar(
              title: 'Confirm entry',
            ),
            body: SingleChildScrollView(
              child: CustomPadding(
                top: 35.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.policy_outlined,
                      size: 98.0,
                      color: kPrimaryColor,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Congratulations 🎉 your application is ready to submit. \n\nBy clicking on the submit button below you confirm and agree that you have read all our terms and conditions and privacy policy. \n\nVisit your profile page or contact support in case you face any difficulties or have questions.',
                      textAlign: TextAlign.left,
                    ),
                    const Divider(
                      thickness: 1.0,
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    RoundedTextButton(
                      text: 'Submit',
                      buttonColor: kSecondaryColor,
                      onPressed: () async {
                        setState((){
                          _isSavingApplication = true;
                        });
                        await getAccountBalance();
                        if ((int.parse(UserVariables.accountBalance!) >=
                                5000) ||
                            (TrainingApplicationVariables.selectedCompanyName ==
                                    'CivilSalt' &&
                                int.parse(UserVariables.accountBalance!) >=
                                    2000)) {
                          setState(() {
                            _isSavingApplication = true;
                          });
                          var result =
                              await TrainingApplicationApi.saveApplication();
                          if (result == '1') {
                            if (mounted) {
                              QuickAlert.show(
                                  barrierDismissible: false,
                                  confirmBtnColor: kSecondaryColor,
                                  context: context,
                                  type: QuickAlertType.success,
                                  text:
                                      'Application sent successfully, ${UserVariables.name}',
                                  onConfirmBtnTap: () {
                                    if (!mounted) return;
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MainRoute()),
                                        (Route<dynamic> route) => false);
                                  });
                            }
                            setState(() {
                              _isSavingApplication = false;
                            });
                          } else if (result == '0' || result == null) {
                            if (mounted) {
                              QuickAlert.show(
                                confirmBtnColor: kSecondaryColor,
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Oops...',
                                text: 'Sorry, something went wrong',
                              );
                            }
                            setState(() {
                              _isSavingApplication = false;
                            });
                          } else {
                            if (mounted) {
                              showToast(
                                  title: "Failed",
                                  body:
                                      "Please check your connection or $result",
                                  snackBarType: ContentType.failure,
                                  context: context);
                            }
                            setState(() {
                              _isSavingApplication = false;
                            });
                          }
                        } else {
                          if (mounted) {
                            showToast(
                                title: "Failed",
                                body:
                                    "You need to have at least 5000 XAF or 2000 XAF for CivilSalt programs before you can apply",
                                snackBarType: ContentType.failure,
                                context: context);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
