import 'package:flutter/material.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:xperiencebase/app_screens/application_screens/end_date.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/widgets/form_header.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';

class StartDate extends StatefulWidget {
  const StartDate({Key? key}) : super(key: key);

  @override
  State<StartDate> createState() => _StartDateState();
}

class _StartDateState extends State<StartDate> {
  DateTime startDate = DateTime.now();
  @override
  void initState() {
    TrainingApplicationVariables.startDate = startDate.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Start date',
      ),
      body: SingleChildScrollView(
        child: CustomPadding(
          top: 35.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FormHeader(
                heading: 'Select a start date for your training',
                body:
                    'Please select a date on which you would like to commence work. This date might be changed by the company your are applying to.',
              ),
              SizedBox(
                height: 250,
                child: ScrollDatePicker(
                  minimumDate: DateTime.now(),
                  maximumDate: DateTime(2025),
                  selectedDate: startDate,
                  locale: const Locale('en'),
                  onDateTimeChanged: (DateTime value) {
                    setState(() {
                      startDate = value;
                      TrainingApplicationVariables.startDate =
                          startDate.toString();
                      debugPrint(TrainingApplicationVariables.startDate);
                    });
                  },
                ),
              ),
              const SizedBox(height: 80.0),
              NullValidatorRoundButton(
                buttonCaption: 'Next Step',
                requiredValue: startDate.toString(),
                nextPage: const EndDate(),
                setState: (bool value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
