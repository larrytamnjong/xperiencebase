import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xperiencebase/widgets_functions/functions/variables.dart';

class TrainingApplicationApi {
  static getOptions() async {
    try {
      final response =
          await http.get(Uri.parse(TrainingApplicationApiUrl.getOptionsUrl));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        for (int i = 0; i < jsonResponse.length; i++) {
          TrainingApplicationVariables.trainingOptionNames
              .add(jsonResponse[i]['training_option_name']);
          TrainingApplicationVariables.trainingOptionIds
              .add(jsonResponse[i]['training_option_id']);
        }
        //Set initial selection
        TrainingApplicationVariables.selectedOptionName =
            TrainingApplicationVariables.trainingOptionNames[0];
        TrainingApplicationVariables.selectedOptionId =
            TrainingApplicationVariables.trainingOptionIds[0];
      }
    } catch (exception) {
      return exception.toString();
    }
  }

  static getSectors() async {
    try {
      final response = await http
          .post(Uri.parse(TrainingApplicationApiUrl.getSectorsUrl), body: {
        "training_option_id": TrainingApplicationVariables.selectedOptionId
      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        for (int i = 0; i < jsonResponse.length; i++) {
          TrainingApplicationVariables.trainingSectorNames
              .add(jsonResponse[i]['training_sector_name']);
          TrainingApplicationVariables.trainingSectorIds
              .add(jsonResponse[i]['training_sector_id']);
        }
        //Set initial selection
        TrainingApplicationVariables.selectedSectorName =
            TrainingApplicationVariables.trainingSectorNames[0];
        TrainingApplicationVariables.selectedSectorId =
            TrainingApplicationVariables.trainingSectorIds[0];
      }
    } catch (exception) {
      return exception.toString();
    }
  }

  static getCities() async {
    try {
      final response = await http
          .post(Uri.parse(TrainingApplicationApiUrl.getCitiesUrl), body: {
        "training_sector_id": TrainingApplicationVariables.selectedSectorId
      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        for (int i = 0; i < jsonResponse.length; i++) {
          TrainingApplicationVariables.trainingCityNames
              .add(jsonResponse[i]['city_name']);
          TrainingApplicationVariables.trainingCityIds
              .add(jsonResponse[i]['training_city_id']);
        }
        //Set initial selection
        TrainingApplicationVariables.selectedCityName =
            TrainingApplicationVariables.trainingCityNames[0];
        TrainingApplicationVariables.selectedCityId =
            TrainingApplicationVariables.trainingCityIds[0];
      }
    } catch (exception) {
      return exception.toString();
    }
  }

  static getDistricts() async {
    try {
      final response = await http
          .post(Uri.parse(TrainingApplicationApiUrl.getDistrictUrl), body: {
        "training_city_id": TrainingApplicationVariables.selectedCityId
      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        for (int i = 0; i < jsonResponse.length; i++) {
          TrainingApplicationVariables.trainingDistrictNames
              .add(jsonResponse[i]['district_name']);
          TrainingApplicationVariables.trainingDistrictIds
              .add(jsonResponse[i]['training_district_id']);
        }
        //Set initial selection
        TrainingApplicationVariables.selectedDistrictName =
            TrainingApplicationVariables.trainingDistrictNames[0];
        TrainingApplicationVariables.selectedDistrictId =
            TrainingApplicationVariables.trainingDistrictIds[0];
      }
    } catch (exception) {
      return exception.toString();
    }
  }

  static getCompanies() async {
    try {
      final response = await http
          .post(Uri.parse(TrainingApplicationApiUrl.getCompaniesUrl), body: {
        "training_district_id": TrainingApplicationVariables.selectedDistrictId
      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        for (int i = 0; i < jsonResponse.length; i++) {
          TrainingApplicationVariables.trainingCompanyNames
              .add(jsonResponse[i]['training_company_name']);
          TrainingApplicationVariables.trainingCompanyIds
              .add(jsonResponse[i]['training_company_id']);
        }
        //Set initial selection
        TrainingApplicationVariables.selectedCompanyName =
            TrainingApplicationVariables.trainingCompanyNames[0];
        TrainingApplicationVariables.selectedCompanyId =
            TrainingApplicationVariables.trainingCompanyIds[0];
      }
    } catch (exception) {
      return exception.toString();
    }
  }

  static saveApplication() async {
    try {
      final response = await http
          .post(Uri.parse(TrainingApplicationApiUrl.saveApplicationUrl), body: {
        "user_id": UserVariables.userId,
        "user_account_number": UserVariables.accountNumber,
        "user_name": UserVariables.name,
        "user_phone": UserVariables.phone,
        "training_option_name": TrainingApplicationVariables.selectedOptionName,
        "training_sector_name": TrainingApplicationVariables.selectedSectorName,
        "training_city_name": TrainingApplicationVariables.selectedCityName,
        "training_district_name":
            TrainingApplicationVariables.selectedDistrictName,
        "training_company_id": TrainingApplicationVariables.selectedCompanyId,
        "training_company_name":
            TrainingApplicationVariables.selectedCompanyName,
        "user_school": TrainingApplicationVariables.school,
        "training_start_date": TrainingApplicationVariables.startDate,
        "training_end_date": TrainingApplicationVariables.endDate,
        "training_application_status":
            TrainingApplicationVariables.applicationStatus
      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        String message = jsonResponse['message'];
        return message;
      } else {
        return '0';
      }
    } catch (exception) {
      // print(exception.toString());
      return exception.toString();
    }
  }
}

class TrainingApplicationApiUrl {
  static String saveApplicationUrl =
      'https://masculine-passenger.000webhostapp.com/xperiencebase/save_training_application.php';
  static String getCompaniesUrl =
      'https://masculine-passenger.000webhostapp.com/xperiencebase/get_training_company.php';
  static String getDistrictUrl =
      'https://masculine-passenger.000webhostapp.com/xperiencebase/get_training_districts.php';
  static String getCitiesUrl =
      'https://masculine-passenger.000webhostapp.com/xperiencebase/get_training_cities.php';
  static String getSectorsUrl =
      'https://masculine-passenger.000webhostapp.com/xperiencebase/get_training_sectors.php';
  static String getOptionsUrl =
      'https://masculine-passenger.000webhostapp.com/xperiencebase/get_training_options.php';
}
