import 'package:flutter/material.dart';
import 'package:xperiencebase/widgets_functions/functions/validator.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'package:xperiencebase/widgets_functions/widgets/textformfield.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';
import 'package:xperiencebase/widgets_functions/widgets/form_header.dart';
import 'package:xperiencebase/app_screens/main_route.dart';
import 'package:xperiencebase/widgets_functions/functions/snackbar_menus.dart';
import 'package:xperiencebase/widgets_functions/functions/deposit_brain.dart';
import 'package:xperiencebase/widgets_functions/functions/api.dart';

class DepositWidget extends StatefulWidget {
  const DepositWidget({Key? key}) : super(key: key);

  @override
  State<DepositWidget> createState() => _DepositWidgetState();
}

class _DepositWidgetState extends State<DepositWidget> {
  TextEditingController amountToDeposit = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Deposit'),
      body: SingleChildScrollView(
        child: CustomPadding(
          top: 13.0,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const FormHeader(
                    heading: "How much do you want to deposit?",
                    body:
                        'Please enter the amount you wish to deposit. Our payment processors or mobile money partners might charge you a deposit fee.'),
                UnderlineTextFormField(
                  labelText: 'Amount XAF',
                  validator: requiredValidator,
                  controller: amountToDeposit,
                  obscureText: false,
                  textInputType: TextInputType.number,
                ),
                const SizedBox(
                  height: 45.0,
                ),
                RoundedTextButton(
                  text: 'Proceed to payment',
                  buttonColor: kPrimaryColor,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      DepositVariables.amountToDeposit = amountToDeposit.text;
                      DepositVariables.depositReference =
                          createDepositReference();

                      final result =
                          await flutterwavePaymentInitialization(context);
                      if (result == '1') {
                        final savePaymentDetailsResult =
                            await Api.saveUserDeposit();
                        if (savePaymentDetailsResult == '1') {
                          showToast(
                              title: 'Success',
                              body: 'Payment was successful',
                              snackBarType: ContentType.success,
                              context: context);
                          if (!mounted) return;
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const MainRoute()),
                              (Route<dynamic> route) => false);
                        } else if (savePaymentDetailsResult == '0') {
                          showToast(
                              title: 'Could not save',
                              body: 'Payment not save, message support',
                              snackBarType: ContentType.failure,
                              context: context);
                        }
                      } else {
                        showToast(
                            title: 'Failure',
                            body: 'Payment was cancelled or unsuccessful.',
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
      ),
    );
  }
}
