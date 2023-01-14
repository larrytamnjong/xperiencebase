class UserVariables {
  static String? name;
  static String? birthdate;
  static String? gender;
  static String? phone;
  static String? email;
  static String? password;
  static String? accountNumber;
  static String? userId;
  static String? creationDate;
  static String? accountBalance = '0';
}

class DepositVariables {
  static String? totalDeposit = '0';
  static List depositAmount = [];
  static List depositReferences = [];
  static List depositTime = [];
  static String amountToDeposit = '0';
  static String? depositReference;
  static String flutterwavePublicKey = '';
}

class WithdrawalVariables {
  static String? totalWithdrawal = '0';
  static List withdrawalAmount = [];
  static List withdrawalReferences = [];
  static List withdrawalTime = [];
}

class TrainingApplicationVariables {
  ///Variables holding training options
  static String? selectedOptionName;
  static String? selectedOptionId;
  static List<String> trainingOptionNames = [];
  static List<String> trainingOptionIds = [];

  ///Variables holding training sectors
  static String? selectedSectorName;
  static String? selectedSectorId;
  static List<String> trainingSectorNames = [];
  static List<String> trainingSectorIds = [];

  ///Variables holding training cities
  static String? selectedCityName;
  static String? selectedCityId;
  static List<String> trainingCityNames = [];
  static List<String> trainingCityIds = [];

  ///Variables holding training districts
  static String? selectedDistrictName;
  static String? selectedDistrictId;
  static List<String> trainingDistrictNames = [];
  static List<String> trainingDistrictIds = [];

  ///Variables holding training companies
  static String? selectedCompanyName;
  static String? selectedCompanyId;
  static List<String> trainingCompanyNames = [];
  static List<String> trainingCompanyIds = [];

  ///Fill in variables
  static String? school;
  static String? startDate;
  static String? endDate;
  static String applicationStatus = 'Pending';
}

class ApplicationHistoryVariables {
  static List<String> trainingCompanyNames = [];
  static List<String> trainingSectorNames = [];
  static List<String> trainingApplicationDates = [];
  static List<String> trainingApplicationStatus = [];
}

class EasyApplyVariables {
  static List<String> easyApplyIDs = [];
  static List<String> easyApplyCompanyIDs = [];
  static List<String> easyApplyCompanyNames = [];
  static List<String> easyApplyOptionNames = [];
  static List<String> easyApplySectorNames = [];
  static List<String> easyApplyCityNames = [];
  static List<String> easyApplyDistrictNames = [];
  static List<String> easyApplyDateOfPosts = [];
}

class PaymentVariables {
  static String? selectedPaymentCompanyName;
  static String? selectedPaymentCompanyID;
  static String? selectedPaymentCompanyAmount;
  static String? selectedPaymentCompanyCharge;
  static String? selectedProductID;
  static String? selectedPaymentCompanyTotalAmount;
  static String? paymentReference;
  static List<String> paymentCompanyNames = [
    'Higher Teachers Training College (ENS Bambili)',
    'HICM'
  ];
  static List<String> paymentCompanyIDs = ['2', '3'];
  static List<String> productIDs = ['2', '3'];
  static List<String> paymentCompanyAmounts = ['2000', '3000'];
}
