import 'package:flutter/material.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/form_header.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'confirm_application.dart';

class EndDate extends StatefulWidget {
  const EndDate({Key? key}) : super(key: key);

  @override
  State<EndDate> createState() => _EndDateState();
}

class _EndDateState extends State<EndDate> {
  DateTime endDate = DateTime.now();
  @override
  void initState() {
    TrainingApplicationVariables.endDate = endDate.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'End date',
      ),
      body: SingleChildScrollView(
        child: CustomPadding(
          top: 35.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FormHeader(
                heading: 'Select an end date for your training',
                body:
                    'We strongly recommend internships should last for at least 4 weeks and job experience for at least 4 months',
              ),
              SizedBox(
                height: 250,
                child: ScrollDatePicker(
                  minimumDate: DateTime.now(),
                  maximumDate: DateTime(2025),
                  selectedDate: endDate,
                  locale: const Locale('en'),
                  onDateTimeChanged: (DateTime value) {
                    setState(() {
                      endDate = value;
                      TrainingApplicationVariables.endDate = endDate.toString();
                      debugPrint(TrainingApplicationVariables.endDate);
                    });
                  },
                ),
              ),
              const SizedBox(height: 80.0),
              NullValidatorRoundButton(
                buttonCaption: 'Confirm entry',
                requiredValue: endDate.toString(),
                nextPage: const ConfirmApplication(),
                setState: (bool value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
