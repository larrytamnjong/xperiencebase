import 'package:flutter/material.dart';
import 'package:xperiencebase/app_screens/application_screens/start_date.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';
import 'package:xperiencebase/widgets_functions/widgets/form_header.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'package:xperiencebase/widgets_functions/functions/pagenavigation.dart';
import 'package:xperiencebase/widgets_functions/widgets/textformfield.dart';
import 'package:xperiencebase/widgets_functions/functions/validator.dart';

import 'package:xperiencebase/widgets_functions/functions/variables.dart';

class School extends StatefulWidget {
  const School({Key? key}) : super(key: key);

  @override
  State<School> createState() => _SchoolState();
}

class _SchoolState extends State<School> {
  TextEditingController school = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Education',
      ),
      body: SingleChildScrollView(
        child: CustomPadding(
          top: 35.0,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const FormHeader(
                  heading: "Which school do you attend?",
                  body:
                      'Enter the name of your current school or university. If you no longer attend school enter the name of the last school you graduated from.',
                ),
                UnderlineTextFormField(
                    labelText: 'School',
                    validator: requiredValidator,
                    controller: school,
                    obscureText: false,
                    textInputType: TextInputType.text),
                const SizedBox(
                  height: 45.0,
                ),
                RoundedTextButton(
                  text: 'Next',
                  buttonColor: kSecondaryColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      TrainingApplicationVariables.school = school.text;
                      changePage(context: context, page: const StartDate());
                      debugPrint(TrainingApplicationVariables.school);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
