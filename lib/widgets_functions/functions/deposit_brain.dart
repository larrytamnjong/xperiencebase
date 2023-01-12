import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';

String createDepositReference() {
  int randomDepositReference = Random().nextInt(255214556) + 78855226;
  String ranDepRef = randomDepositReference.toString();
  return ranDepRef;
}

flutterwavePaymentInitialization(BuildContext context) async {
  final Customer customer = Customer(
    name: UserVariables.name!,
    phoneNumber: UserVariables.phone!,
    email: UserVariables.email!,
  );

  final Flutterwave flutterwave = Flutterwave(
    context: context,
    publicKey: DepositVariables.flutterwavePublicKey,
    currency: "XAF",
    redirectUrl: "https://www.google.com/",
    txRef: DepositVariables.depositReference!,
    amount: DepositVariables.amountToDeposit,
    customer: customer,
    paymentOptions: "MobileMoneyFrancophoneAfricaPayments",
    customization: Customization(title: "Xperience Base LTD"),
    isTestMode: false,
  );
  final ChargeResponse response = await flutterwave.charge();
  if (response != null) {
    debugPrint(response.toJson().toString());
    if (response.success!) {
      debugPrint('payment was successful');
      // DepositVariables.depositReference = response.txRef;
      return '1';
    } else {
      debugPrint('transaction failed');
      // Transaction not successful
      return '0';
    }
  } else {
    debugPrint('transaction cancelled');
    return '0';
    // User cancelled
  }
}
