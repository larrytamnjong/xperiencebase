import 'package:flutter/material.dart';
import 'package:xperiencebase/app_screens/application_screens/payment_register_screens/payment_history.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/functions/pagenavigation.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';
import 'package:xperiencebase/widgets_functions/widgets/form_header.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:xperiencebase/widgets_functions/widgets/loading.dart';
import 'package:xperiencebase/widgets_functions/functions/account_brain.dart';
import 'package:xperiencebase/widgets_functions/functions/api.dart';
import 'package:xperiencebase/widgets_functions/functions/payment_brain.dart';
import 'package:xperiencebase/widgets_functions/functions/snackbar_menus.dart';
import 'package:xperiencebase/widgets_functions/functions/training_application_brain.dart';
import 'package:xperiencebase/widgets_functions/functions/validator.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';

class PaymentHome extends StatefulWidget {
  const PaymentHome({Key? key}) : super(key: key);

  @override
  State<PaymentHome> createState() => _PaymentHomeState();
}

bool _isShowErrorText = false;
String? totalAmountToPay = '0';
bool _isSaving = false;

class _PaymentHomeState extends State<PaymentHome> {
  getAccountBalance() async {
    DepositVariables.totalDeposit = await Api.userTotalDeposit();
    WithdrawalVariables.totalWithdrawal = await Api.userTotalWithdrawal();
    UserVariables.accountBalance = calculateBalance(
        DepositVariables.totalDeposit, WithdrawalVariables.totalWithdrawal);
    if (mounted) {
      setState(() {
        UserVariables.accountBalance;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isSaving
        ? const LoadingScreen(waitingText: 'Validating payment')
        : Scaffold(
            appBar: const CustomAppBar(title: 'Payments'),
            body: SingleChildScrollView(
              child: CustomPadding(
                top: 35.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const FormHeader(
                        heading: 'Select an institution',
                        body:
                            ' Choose a company below in order to make a payment, ensure you have sufficient funds before you initiate a payment.'),
                    ShowErrorText(
                      showErrorText: _isShowErrorText,
                    ),
                    CustomDropDownButton(
                        value: PaymentVariables.selectedPaymentCompanyName,
                        hint: "Choose a company",
                        list: PaymentVariables.paymentCompanyNames,
                        onChanged: (value) {
                          setState(() {
                            _isShowErrorText = false;
                            PaymentVariables.selectedPaymentCompanyName =
                                value!;
                            //Get selected company payment ID
                            PaymentVariables.selectedPaymentCompanyID =
                                getItemId(
                                    list: PaymentVariables.paymentCompanyNames,
                                    itemName: PaymentVariables
                                        .selectedPaymentCompanyName,
                                    idList: PaymentVariables.paymentCompanyIDs);
                            //Get index of selected company
                            int index = PaymentVariables.paymentCompanyNames
                                .indexOf(PaymentVariables
                                    .selectedPaymentCompanyName!);
                            //set amount to pay
                            PaymentVariables.selectedPaymentCompanyAmount =
                                PaymentVariables.paymentCompanyAmounts[index];
                            //set product id
                            PaymentVariables.selectedProductID =
                                PaymentVariables.productIDs[index];
                            //get total amount to pay and total charge
                            calculatePaymentCharge(
                                PaymentVariables.selectedPaymentCompanyAmount!);
                            totalAmountToPay = calculateTotalAmountToPay(
                                PaymentVariables.selectedPaymentCompanyAmount!);

                            //Create payment reference
                            createPaymentReference();
                          });
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 30.0,
                        child: Text(
                          'Total amount plus charge: $totalAmountToPay XAF',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 150.0),
                    RoundedTextButton(
                        text: 'Make payment',
                        buttonColor: kPrimaryColor,
                        onPressed: () async {
                          if (PaymentVariables.selectedPaymentCompanyName ==
                              null) {
                            setState(() {
                              _isShowErrorText = true;
                            });
                          } else {
                            setState(() {
                              _isSaving = true;
                            });
                            await getAccountBalance();
                            if (int.parse(PaymentVariables
                                    .selectedPaymentCompanyTotalAmount!) >
                                int.parse(UserVariables.accountBalance!)) {
                              showToast(
                                  title: "Failed",
                                  body:
                                      "You need to have at least $totalAmountToPay XAF before you can pay",
                                  snackBarType: ContentType.failure,
                                  context: context);
                              setState(() {
                                _isSaving = false;
                              });
                            } else {
                              setState(() {
                                _isSaving = true;
                              });
                              var result1 = await Api.savePaymentRegister();
                              var result2 = await Api.saveWithdrawal();
                              if (result1 == '1' && result2 == '1') {
                                showToast(
                                    title: "Success",
                                    body:
                                        "Payment has been registered successfully",
                                    snackBarType: ContentType.success,
                                    context: context);
                                setState(() {
                                  _isSaving = false;
                                });
                                changePage(
                                    context: context,
                                    page: const PaymentHistory());
                              } else {
                                setState(() {
                                  _isSaving = false;
                                });
                                showToast(
                                    title: "Ops",
                                    body: "Something went wrong",
                                    snackBarType: ContentType.warning,
                                    context: context);
                              }
                            }
                          }
                        }),
                    const SizedBox(height: 25.0),
                    RoundedTextButton(
                        text: 'View history',
                        buttonColor: kSecondaryColor,
                        onPressed: () {
                          changePage(
                              context: context, page: const PaymentHistory());
                        }),
                  ],
                ),
              ),
            ),
          );
  }
}
