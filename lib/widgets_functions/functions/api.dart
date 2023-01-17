import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';

///Message variable is used to store response from the sever
/// visit [read-me file to see various response types
class Api {
  static userRegistration() async {
    try {
      final response = await http.post(Uri.parse(ApiUrl.registerUser), body: {
        "user_name": UserVariables.name?.toUpperCase(),
        "user_birthdate": UserVariables.birthdate,
        "user_gender": UserVariables.gender,
        "user_phone": UserVariables.phone,
        "user_email": UserVariables.email,
        'user_password': UserVariables.password,
        "user_account_number": UserVariables.accountNumber,
      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        String message = jsonResponse['message'];
        debugPrint(message);
        return message;
      } else {
        return null;
      }
    } catch (exception) {
      debugPrint(exception.toString());
      return exception.toString();
    }
  }

  static userLogin() async {
    try {
      final response = await http.post(Uri.parse(ApiUrl.loginUser), body: {
        "user_phone": UserVariables.phone,
        "user_password": UserVariables.password,
      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        String message = jsonResponse['message'];

        ///Save user info on successful login
        UserVariables.userId = jsonResponse['user_id'];
        UserVariables.name = jsonResponse['user_name'];
        UserVariables.accountNumber = jsonResponse['user_account_number'];
        UserVariables.phone = jsonResponse['user_phone'];
        UserVariables.email = jsonResponse['user_email'];
        UserVariables.gender = jsonResponse['user_gender'];
        UserVariables.birthdate = jsonResponse['user_birthdate'];
        UserVariables.creationDate = jsonResponse['creation_date'];

        ///save user details in shared preference if user exist
        if(jsonResponse['user_name']!= null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('userId', jsonResponse['user_id']);
          await prefs.setString('name', jsonResponse['user_name']);
          await prefs.setString(
              'accountNumber', jsonResponse['user_account_number']);
          await prefs.setString('phone', jsonResponse['user_phone']);
          await prefs.setString('email', jsonResponse['user_email']);
          await prefs.setString('gender', jsonResponse['user_gender']);
          await prefs.setString('birthdate', jsonResponse['user_birthdate']);
          await prefs.setString('creationDate', jsonResponse['creation_date']);
        }
        return message;
      } else {

        return null;
      }
    } catch (exception) {

      return exception.toString();

    }
  }

  static userTotalDeposit() async {
    try {
      final response = await http.post(Uri.parse(ApiUrl.totalDeposit),
          body: {"user_id": UserVariables.userId});
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        String? totalDeposit = jsonResponse[0]['SUM(deposit_amount)'];

        return totalDeposit;
      }
    } catch (exception) {
      return exception.toString();
    }
  }

  static userTotalWithdrawal() async {
    try {
      final response = await http.post(Uri.parse(ApiUrl.totalWithdrawal),
          body: {"user_id": UserVariables.userId});
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        String? totalWithdrawal = jsonResponse[0]['SUM(withdrawal_amount)'];

        return totalWithdrawal;
      }
    } catch (exception) {
      return exception.toString();
    }
  }

  static userDepositHistory() async {
    try {
      final response = await http.post(Uri.parse(ApiUrl.depositHistory),
          body: {"user_id": UserVariables.userId});
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        for (int i = 0; i < jsonResponse.length; i++) {
          DepositVariables.depositAmount.add(jsonResponse[i]['deposit_amount']);
          DepositVariables.depositReferences.add(jsonResponse[i]['deposit_reference']);
          DepositVariables.depositTime.add(jsonResponse[i]['deposit_time']);
        }
      }
    } catch (exception) {
      return exception.toString();
    }
  }

  static userWithdrawalHistory() async {
    try {
      final response = await http.post(Uri.parse(ApiUrl.withdrawalHistory),
          body: {"user_id": UserVariables.userId});
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        for (int i = 0; i < jsonResponse.length; i++) {
          WithdrawalVariables.withdrawalAmount.add(jsonResponse[i]['withdrawal_amount']);
          WithdrawalVariables.withdrawalReferences.add(jsonResponse[i]['withdrawal_reference']);
          WithdrawalVariables.withdrawalTime.add(jsonResponse[i]['withdrawal_time']);
        }
      }
    } catch (exception) {
      return exception.toString();
    }
  }

  static userApplicationHistory() async {
    try {
      final response = await http.post(Uri.parse(ApiUrl.applicationHistory),
          body: {"user_id": UserVariables.userId});
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        for (int i = 0; i < jsonResponse.length; i++) {
          ApplicationHistoryVariables.trainingSectorNames.add(jsonResponse[i]['training_sector_name']);
          ApplicationHistoryVariables.trainingCompanyNames.add(jsonResponse[i]['training_company_name']);
          ApplicationHistoryVariables.trainingApplicationDates.add(jsonResponse[i]['training_application_date']);
          ApplicationHistoryVariables.trainingApplicationStatus.add(jsonResponse[i]['training_application_status']);
        }
      }
    } catch (exception) {
      return exception.toString();
    }
  }

  static getEasyApplyPosts() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.easyApplyPost));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        for (int i = 0; i < jsonResponse.length; i++) {
          EasyApplyVariables.easyApplyCityNames.add(jsonResponse[i]['training_city_name']);
          EasyApplyVariables.easyApplyCompanyIDs.add(jsonResponse[i]['training_company_id']);
          EasyApplyVariables.easyApplyCompanyNames.add(jsonResponse[i]['training_company_name']);
          EasyApplyVariables.easyApplyDistrictNames.add(jsonResponse[i]['training_district_name']);
          EasyApplyVariables.easyApplyIDs.add(jsonResponse[i]['easy_apply_id']);
          EasyApplyVariables.easyApplyOptionNames.add(jsonResponse[i]['training_option_name']);
          EasyApplyVariables.easyApplySectorNames.add(jsonResponse[i]['training_sector_name']);
          EasyApplyVariables.easyApplyDateOfPosts.add(jsonResponse[i]['date_of_post']);
        }
      }
    } catch (exception) {
      return exception.toString();
    }
  }

  static saveUserDeposit() async {
    try {
      final response = await http.post(Uri.parse(ApiUrl.saveDepositUrl), body: {
        "user_id": UserVariables.userId,
        "deposit_amount": DepositVariables.amountToDeposit,
        "deposit_reference": DepositVariables.depositReference,
      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        String message = jsonResponse['message'];
        debugPrint(message);
        return message;
      } else {
        return '0';
      }
    } catch (exception) {
      debugPrint(exception.toString());
      return '0';
    }
  }

  static getFlutterwavePublicKey() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.flutterwavePublicKey));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        DepositVariables.flutterwavePublicKey =
            jsonResponse[0]['flutterwave_publicKey'];
      }
    } catch (exception) {
      return exception.toString();
    }
  }

  static getAppVersion() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.appVersion));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        String? currentVersion;
        currentVersion = jsonResponse[0]['current_version'];
        return currentVersion;
      }
    } catch (exception) {
      return exception.toString();
    }
  }

  static saveWithdrawal() async {
    try {
      final response = await http.post(Uri.parse(ApiUrl.saveWithdrawal), body: {
        "user_id": UserVariables.userId,
        "withdrawal_amount": PaymentRegisterVariables.selectedTotalPaymentAmount,
        "product_id": PaymentRegisterVariables.selectedCompanyProductID,
        "withdrawal_reference": PaymentRegisterVariables.paymentReference,
        "withdrawal_charge": PaymentRegisterVariables.selectedPaymentCharge
      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        String message = jsonResponse['message'];
        debugPrint(message);
        return message;
      } else {
        return '0';
      }
    } catch (exception) {
      debugPrint(exception.toString());
      return exception.toString();
    }
  }

  static savePaymentRegister() async {
    try {
      final response =
          await http.post(Uri.parse(ApiUrl.savePaymentRegister), body: {
        "user_id": UserVariables.userId,
        "user_account_number": UserVariables.accountNumber,
        "user_name": UserVariables.name,
        "user_gender": UserVariables.gender,
        "user_email": UserVariables.email,
        "payment_reference": PaymentRegisterVariables.paymentReference,
        "payment_amount": PaymentRegisterVariables.selectedPaymentAmount,
        "payment_period": '2023',
        "company_name": PaymentRegisterVariables.selectedCompanyName


      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        String message = jsonResponse['message'];
        debugPrint(message);
        return message;
      } else {
        return '0';
      }
    } catch (exception) {
      debugPrint(exception.toString());
      return exception.toString();
    }
  }
  static getPaymentRegisterHistory() async {
    try {
      final response = await http.post(Uri.parse(ApiUrl.paymentRegisterHistory),body: {
        "user_id": UserVariables.userId,
      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        for (int i = 0; i < jsonResponse.length; i++) {
          PaymentRegisterHistoryVariables.companyNames.add(jsonResponse[i]['company_name']);
          PaymentRegisterHistoryVariables.paymentAmounts.add(jsonResponse[i]['payment_amount']);
          PaymentRegisterHistoryVariables.paymentReferences.add(jsonResponse[i]['payment_reference']);
          PaymentRegisterHistoryVariables.paymentPeriods.add(jsonResponse[i]['payment_period']);
          PaymentRegisterHistoryVariables.paymentTimes.add(jsonResponse[i]['payment_time']);
          PaymentRegisterHistoryVariables.paymentIDs.add(jsonResponse[i]['payment_id']);

        }
      }
    } catch (exception) {
      return exception.toString();
    }
  }
}

class ApiUrl {
  static String paymentRegisterHistory =
      'https://masculine-passenger.000webhostapp.com/xperiencebase/user_get_payment_register_history.php';
  static String savePaymentRegister =
      'https://masculine-passenger.000webhostapp.com/xperiencebase/save_payment_register.php';
  static String saveWithdrawal =
      'https://masculine-passenger.000webhostapp.com/xperiencebase/user_save_withdrawal.php';
  static String appVersion =
      'https://masculine-passenger.000webhostapp.com/xperiencebase/get_current_app_version.php';
  static String flutterwavePublicKey =
      'https://masculine-passenger.000webhostapp.com/xperiencebase/get_deposit_flutter_publicKey.php';
  static String saveDepositUrl =
      'https://masculine-passenger.000webhostapp.com/xperiencebase/user_save_deposit.php';
  static String easyApplyPost =
      'https://masculine-passenger.000webhostapp.com/xperiencebase/get_easy_apply_post.php';
  static String applicationHistory =
      'https://masculine-passenger.000webhostapp.com/xperiencebase/user_get_training_application_history.php';
  static String withdrawalHistory =
      'https://masculine-passenger.000webhostapp.com/xperiencebase/user_get_withdrawal_history.php';
  static String depositHistory =
      'https://masculine-passenger.000webhostapp.com/xperiencebase/user_get_deposit_history.php';
  static String totalWithdrawal =
      'https://masculine-passenger.000webhostapp.com/xperiencebase/user_total_withdrawal.php';
  static String totalDeposit =
      'https://masculine-passenger.000webhostapp.com/xperiencebase/user_total_deposit.php';
  static String loginUser =
      'https://masculine-passenger.000webhostapp.com/xperiencebase/user_login.php';
  static String registerUser =
      'https://masculine-passenger.000webhostapp.com/xperiencebase/user_registration.php';
}
