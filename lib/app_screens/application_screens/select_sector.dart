import 'package:flutter/material.dart';
import 'package:xperiencebase/app_screens/application_screens/select_city.dart';
import 'package:xperiencebase/widgets_functions/functions/training_application_api.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/form_header.dart';
import 'package:xperiencebase/widgets_functions/widgets/loading.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';

import 'package:xperiencebase/widgets_functions/widgets/button.dart';
import 'package:xperiencebase/widgets_functions/functions/validator.dart';

import 'package:xperiencebase/widgets_functions/functions/training_application_brain.dart';

class Sector extends StatefulWidget {
  const Sector({Key? key}) : super(key: key);

  @override
  State<Sector> createState() => _SectorState();
}

bool _isShowErrorText = false;
bool _isLoadingSector = false;

class _SectorState extends State<Sector> {
  void setSectors() async {
    setState(() {
      _isLoadingSector = true;
    });
    await TrainingApplicationApi.getSectors();
    setState(() {
      TrainingApplicationVariables.trainingSectorNames;
      _isLoadingSector = false;
    });
  }

  @override
  void initState() {
    setSectors();
    super.initState();
  }

  @override
  void dispose() {
    clearTrainingApplicationSectorLists();
    _isShowErrorText = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoadingSector
        ? const LoadingScreen(
            waitingText: 'Getting available study fields',
          )
        : Scaffold(
            appBar: const CustomAppBar(
              title: 'Department',
            ),
            body: SingleChildScrollView(
              child: CustomPadding(
                top: 35.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const FormHeader(
                      heading: 'What is your field of study?',
                      body:
                          'Please select a field of study or industry you would like to work at. We recommend you select a field closest to your education background',
                    ),
                    ShowErrorText(
                      showErrorText: _isShowErrorText,
                    ),
                    CustomDropDownButton(
                      value: TrainingApplicationVariables.selectedSectorName,
                      hint: 'No fields of study for current selection',
                      list: TrainingApplicationVariables.trainingSectorNames,
                      onChanged: (value) {
                        setState(() {
                          TrainingApplicationVariables.selectedSectorName =
                              value!;
                        });
                      },
                    ),
                    const SizedBox(height: 80.0),
                    NullValidatorRoundButton(
                      buttonCaption: 'Next Step',
                      requiredValue:
                          TrainingApplicationVariables.selectedSectorName,
                      nextPage: const City(),
                      setState: (bool value) {
                        setState(
                          () {
                            _isShowErrorText = value;
                            //Get index of selected sector
                            TrainingApplicationVariables.selectedSectorId =
                                getItemId(
                                    list: TrainingApplicationVariables
                                        .trainingSectorNames,
                                    itemName: TrainingApplicationVariables
                                        .selectedSectorName,
                                    idList: TrainingApplicationVariables
                                        .trainingSectorIds);
                            debugPrint(TrainingApplicationVariables
                                .selectedSectorName);
                            debugPrint(
                                TrainingApplicationVariables.selectedSectorId);
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
