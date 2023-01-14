import 'dart:math';

import 'package:xperiencebase/widgets_functions/functions/variables.dart';

String calculateTotalAmountToPay(String amount) {
  double calculatedPercentage = int.parse(amount) * 0.1;
  int totalAmount = calculatedPercentage.round() + int.parse(amount);
  PaymentRegisterVariables.selectedTotalPaymentAmount = totalAmount.toString();
  return totalAmount.toString();
}

String calculatePaymentCharge(String amount) {
  double calculatedPercentage = int.parse(amount) * 0.1;
  int roundedCharge = calculatedPercentage.round();
  PaymentRegisterVariables.selectedPaymentCharge = roundedCharge.toString();
  return roundedCharge.toString();
}

String createPaymentReference() {
  int randomWithdrawalReference = Random().nextInt(255214556) + 78855226;
  String ranWithRef = randomWithdrawalReference.toString();
  PaymentRegisterVariables.paymentReference = ranWithRef;
  return ranWithRef;
}
