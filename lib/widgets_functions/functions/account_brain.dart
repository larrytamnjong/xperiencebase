import 'package:xperiencebase/widgets_functions/functions/variables.dart';

/// Calculate account balance

String calculateBalance(String? deposit, String? withdrawal) {
  try {
    int tempResult = (deposit == null ? 0 : int.parse(deposit)) -
        (withdrawal == null ? 0 : int.parse(withdrawal));
    String result = tempResult.toString();
    return result;
  } catch (exception) {
    return "Check your internet connection\n";
    //return exception.toString();
  }
}

///Clear Deposit and Withdrawal List
void clearDepositWithdrawalList() {
  DepositVariables.depositAmount.clear();
  DepositVariables.depositReferences.clear();
  DepositVariables.depositTime.clear();
  WithdrawalVariables.withdrawalAmount.clear();
  WithdrawalVariables.withdrawalReferences.clear();
  WithdrawalVariables.withdrawalTime.clear();
}
