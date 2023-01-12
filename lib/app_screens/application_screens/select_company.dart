import 'package:flutter/material.dart';
import 'package:xperiencebase/app_screens/application_screens/enter_school.dart';
import 'package:xperiencebase/widgets_functions/functions/training_application_api.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';
import 'package:xperiencebase/widgets_functions/widgets/form_header.dart';
import 'package:xperiencebase/widgets_functions/widgets/loading.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'package:xperiencebase/widgets_functions/functions/validator.dart';
import 'package:xperiencebase/widgets_functions/functions/training_application_brain.dart';

class Company extends StatefulWidget {
  const Company({Key? key}) : super(key: key);

  @override
  State<Company> createState() => _CompanyState();
}

bool _isShowErrorText = false;
bool _isLoadingCompany = false;

class _CompanyState extends State<Company> {
  void setCompanies() async {
    setState(() {
      _isLoadingCompany = true;
    });
    await TrainingApplicationApi.getCompanies();
    setState(() {
      TrainingApplicationVariables.trainingCompanyNames;
      _isLoadingCompany = false;
    });
  }

  @override
  void initState() {
    setCompanies();
    super.initState();
  }

  @override
  void dispose() {
    clearTrainingApplicationCompanyLists();
    _isShowErrorText = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoadingCompany
        ? const LoadingScreen(waitingText: 'Getting available companies')
        : Scaffold(
            appBar: const CustomAppBar(
              title: 'Company',
            ),
            body: SingleChildScrollView(
              child: CustomPadding(
                top: 35.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const FormHeader(
                      heading: 'Select a company for your training',
                      body:
                          'Once you select a company we will send a request to them and ideally you should get a response within 7 days',
                    ),
                    ShowErrorText(showErrorText: _isShowErrorText),
                    CustomDropDownButton(
                      value: TrainingApplicationVariables.selectedCompanyName,
                      hint: 'No companies for current selection',
                      list: TrainingApplicationVariables.trainingCompanyNames,
                      onChanged: (value) {
                        setState(() {
                          TrainingApplicationVariables.selectedCompanyName =
                              value!;
                        });
                      },
                    ),
                    const SizedBox(height: 80.0),
                    NullValidatorRoundButton(
                      buttonCaption: 'Next Step',
                      requiredValue:
                          TrainingApplicationVariables.selectedCompanyName,
                      nextPage: const School(),
                      setState: (bool value) {
                        setState(
                          () {
                            _isShowErrorText = value;
                            //Get index of selected company
                            TrainingApplicationVariables.selectedCompanyId =
                                getItemId(
                                    list: TrainingApplicationVariables
                                        .trainingCompanyNames,
                                    itemName: TrainingApplicationVariables
                                        .selectedCompanyName,
                                    idList: TrainingApplicationVariables
                                        .trainingCompanyIds);
                            debugPrint(TrainingApplicationVariables
                                .selectedCompanyName);
                            debugPrint(
                                TrainingApplicationVariables.selectedCompanyId);
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
