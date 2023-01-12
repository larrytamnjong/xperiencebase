import 'package:flutter/material.dart';
import 'package:xperiencebase/app_screens/application_screens/select_district.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/form_header.dart';

import 'package:xperiencebase/widgets_functions/widgets/button.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';

import 'package:xperiencebase/widgets_functions/functions/validator.dart';

import 'package:xperiencebase/widgets_functions/functions/training_application_api.dart';
import 'package:xperiencebase/widgets_functions/functions/training_application_brain.dart';
import 'package:xperiencebase/widgets_functions/widgets/loading.dart';

class City extends StatefulWidget {
  const City({Key? key}) : super(key: key);

  @override
  State<City> createState() => _CityState();
}

bool _isShowErrorText = false;
bool _isLoadingCity = false;

class _CityState extends State<City> {
  void setCities() async {
    setState(() {
      _isLoadingCity = true;
    });
    await TrainingApplicationApi.getCities();
    setState(() {
      TrainingApplicationVariables.trainingCityNames;
      _isLoadingCity = false;
    });
  }

  @override
  void initState() {
    setCities();
    super.initState();
  }

  @override
  void dispose() {
    clearTrainingApplicationCityLists();
    _isShowErrorText = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoadingCity
        ? const LoadingScreen(
            waitingText: 'Getting available cities',
          )
        : Scaffold(
            appBar: const CustomAppBar(
              title: 'City',
            ),
            body: SingleChildScrollView(
              child: CustomPadding(
                top: 35.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const FormHeader(
                        heading: 'Choose a city for your training',
                        body:
                            'Please select a city you would like to carryout your training in. Note you cannot change city once your request is sent.'),
                    ShowErrorText(showErrorText: _isShowErrorText),
                    CustomDropDownButton(
                      value: TrainingApplicationVariables.selectedCityName,
                      hint: 'No cities for current selection',
                      list: TrainingApplicationVariables.trainingCityNames,
                      onChanged: (value) {
                        setState(() {
                          TrainingApplicationVariables.selectedCityName =
                              value!;
                        });
                      },
                    ),
                    const SizedBox(height: 80.0),
                    NullValidatorRoundButton(
                      buttonCaption: 'Next Step',
                      requiredValue:
                          TrainingApplicationVariables.selectedCityName,
                      nextPage: const District(),
                      setState: (bool value) {
                        setState(
                          () {
                            _isShowErrorText = value;
                            //Get index of selected city
                            TrainingApplicationVariables.selectedCityId =
                                getItemId(
                                    list:
                                        TrainingApplicationVariables
                                            .trainingCityNames,
                                    itemName:
                                        TrainingApplicationVariables
                                            .selectedCityName,
                                    idList: TrainingApplicationVariables
                                        .trainingCityIds);
                            debugPrint(
                                TrainingApplicationVariables.selectedCityName);
                            debugPrint(
                                TrainingApplicationVariables.selectedCityId);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
