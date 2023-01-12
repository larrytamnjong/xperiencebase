import 'package:flutter/material.dart';
import 'package:xperiencebase/app_screens/application_screens/select_company.dart';
import 'package:xperiencebase/widgets_functions/functions/training_application_brain.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';
import 'package:xperiencebase/widgets_functions/widgets/form_header.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'package:xperiencebase/widgets_functions/functions/validator.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/functions/training_application_api.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/widgets/loading.dart';

class District extends StatefulWidget {
  const District({Key? key}) : super(key: key);

  @override
  State<District> createState() => _DistrictState();
}

bool _isShowErrorText = false;
bool _isLoadingDistrict = false;

class _DistrictState extends State<District> {
  void setDistricts() async {
    setState(() {
      _isLoadingDistrict = true;
    });
    await TrainingApplicationApi.getDistricts();
    setState(() {
      TrainingApplicationVariables.trainingDistrictNames;
      _isLoadingDistrict = false;
    });
  }

  @override
  void initState() {
    setDistricts();
    super.initState();
  }

  @override
  void dispose() {
    clearTrainingApplicationDistrictLists();
    _isShowErrorText = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoadingDistrict
        ? const LoadingScreen(waitingText: 'Getting available districts')
        : Scaffold(
            appBar: const CustomAppBar(
              title: 'District',
            ),
            body: SingleChildScrollView(
              child: CustomPadding(
                top: 35.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const FormHeader(
                      heading: 'Choose your desired district',
                      body:
                          'A district is a locality or neighbourhood in your city of interest, you can always change districts to find other companies. ',
                    ),
                    ShowErrorText(showErrorText: _isShowErrorText),
                    CustomDropDownButton(
                      value: TrainingApplicationVariables.selectedDistrictName,
                      hint: 'No districts for current selection',
                      list: TrainingApplicationVariables.trainingDistrictNames,
                      onChanged: (value) {
                        setState(() {
                          TrainingApplicationVariables.selectedDistrictName =
                              value!;
                        });
                      },
                    ),
                    const SizedBox(height: 80.0),
                    NullValidatorRoundButton(
                      buttonCaption: 'Next Step',
                      requiredValue:
                          TrainingApplicationVariables.selectedDistrictName,
                      nextPage: const Company(),
                      setState: (bool value) {
                        setState(
                          () {
                            _isShowErrorText = value;

                            //Get index of selected district
                            TrainingApplicationVariables.selectedDistrictId =
                                getItemId(
                                    list:
                                        TrainingApplicationVariables
                                            .trainingDistrictNames,
                                    itemName: TrainingApplicationVariables
                                        .selectedDistrictName,
                                    idList: TrainingApplicationVariables
                                        .trainingDistrictIds);
                            debugPrint(TrainingApplicationVariables
                                .selectedDistrictName);
                            debugPrint(TrainingApplicationVariables
                                .selectedDistrictId);
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
