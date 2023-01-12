import 'package:flutter/material.dart';
import 'package:xperiencebase/app_screens/application_screens/select_sector.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/form_header.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'package:xperiencebase/widgets_functions/functions/validator.dart';
import 'package:xperiencebase/widgets_functions/functions/training_application_brain.dart';

import 'package:xperiencebase/widgets_functions/functions/training_application_api.dart';

import 'package:xperiencebase/widgets_functions/widgets/loading.dart';

class Option extends StatefulWidget {
  const Option({Key? key}) : super(key: key);

  @override
  State<Option> createState() => _OptionState();
}

bool _isShowErrorText = false;
bool _isLoadingOption = false;

class _OptionState extends State<Option> {
  void setOption() async {
    setState(() {
      _isLoadingOption = true;
    });
    await TrainingApplicationApi.getOptions();
    setState(() {
      TrainingApplicationVariables.trainingOptionNames;
      _isLoadingOption = false;
    });
  }

  @override
  void initState() {
    setOption();
    super.initState();
  }

  @override
  void dispose() {
    clearTrainingApplicationOptionLists();
    _isShowErrorText = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoadingOption
        ? const LoadingScreen(
            waitingText: 'Getting available programs',
          )
        : Scaffold(
            appBar: const CustomAppBar(
              title: 'Options',
            ),
            body: SingleChildScrollView(
              child: CustomPadding(
                top: 35.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const FormHeader(
                      heading: 'Start by finding a program',
                      body:
                          'Select an option of what king of practical experience program you want to carryout, you can only select one option',
                    ),
                    ShowErrorText(showErrorText: _isShowErrorText),
                    CustomDropDownButton(
                      value: TrainingApplicationVariables.selectedOptionName,
                      hint: 'No programs found',
                      list: TrainingApplicationVariables.trainingOptionNames,
                      onChanged: (value) {
                        setState(() {
                          TrainingApplicationVariables.selectedOptionName =
                              value!;
                        });
                      },
                    ),
                    const SizedBox(height: 80.0),
                    NullValidatorRoundButton(
                      buttonCaption: 'Next Step',
                      requiredValue:
                          TrainingApplicationVariables.selectedOptionName,
                      nextPage: const Sector(),
                      setState: (bool value) {
                        setState(
                          () {
                            _isShowErrorText = value;

                            //Get index of selected option
                            TrainingApplicationVariables.selectedOptionId =
                                getItemId(
                                    list: TrainingApplicationVariables
                                        .trainingOptionNames,
                                    itemName: TrainingApplicationVariables
                                        .selectedOptionName,
                                    idList: TrainingApplicationVariables
                                        .trainingOptionIds);
                            debugPrint(
                                TrainingApplicationVariables.selectedOptionId);
                            debugPrint(TrainingApplicationVariables
                                .selectedOptionName);
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
