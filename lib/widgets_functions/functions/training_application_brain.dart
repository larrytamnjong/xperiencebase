import 'package:xperiencebase/widgets_functions/functions/variables.dart';

///Function to clear Application lists
//Option List
void clearTrainingApplicationOptionLists() {
  TrainingApplicationVariables.trainingOptionNames.clear();
  TrainingApplicationVariables.trainingOptionIds.clear();
  TrainingApplicationVariables.selectedOptionName = null;
}

//Sector List
void clearTrainingApplicationSectorLists() {
  TrainingApplicationVariables.trainingSectorNames.clear();
  TrainingApplicationVariables.trainingSectorIds.clear();
  TrainingApplicationVariables.selectedSectorName = null;
}

//City List
void clearTrainingApplicationCityLists() {
  TrainingApplicationVariables.trainingCityNames.clear();
  TrainingApplicationVariables.trainingCityIds.clear();
  TrainingApplicationVariables.selectedCityName = null;
}

//District List
void clearTrainingApplicationDistrictLists() {
  TrainingApplicationVariables.trainingDistrictNames.clear();
  TrainingApplicationVariables.trainingDistrictIds.clear();
  TrainingApplicationVariables.selectedDistrictName = null;
}

//Company List
void clearTrainingApplicationCompanyLists() {
  TrainingApplicationVariables.trainingCompanyNames.clear();
  TrainingApplicationVariables.trainingCompanyIds.clear();
  TrainingApplicationVariables.selectedCompanyName = null;
}

//Application History List
void clearUserApplicationHistoryLists() {
  ApplicationHistoryVariables.trainingApplicationStatus.clear();
  ApplicationHistoryVariables.trainingApplicationDates.clear();
  ApplicationHistoryVariables.trainingSectorNames.clear();
  ApplicationHistoryVariables.trainingCompanyNames.clear();
}

void clearForYouList() {
  EasyApplyVariables.easyApplyDateOfPosts.clear();
  EasyApplyVariables.easyApplySectorNames.clear();
  EasyApplyVariables.easyApplyOptionNames.clear();
  EasyApplyVariables.easyApplyIDs.clear();
  EasyApplyVariables.easyApplyDistrictNames.clear();
  EasyApplyVariables.easyApplyCityNames.clear();
  EasyApplyVariables.easyApplyCompanyNames.clear();
  EasyApplyVariables.easyApplyCompanyIDs.clear();
}

///Function to get Id of selected item given item list and item ids
String getItemId(
    {required List list, required String? itemName, required List idList}) {
  try {
    int index = list.indexOf(itemName);

    String selectedId = idList[index];

    return selectedId;
  } catch (exception) {
    return exception.toString();
  }
}
