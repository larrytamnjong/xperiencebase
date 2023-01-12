import 'package:flutter/material.dart';
import 'package:xperiencebase/authentication/registration/r_gender.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'package:xperiencebase/widgets_functions/functions/pagenavigation.dart';
import 'package:xperiencebase/widgets_functions/widgets/form_header.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';

import 'package:xperiencebase/widgets_functions/functions/variables.dart';

class BirthDate extends StatefulWidget {
  const BirthDate({Key? key}) : super(key: key);

  @override
  State<BirthDate> createState() => _BirthDateState();
}

class _BirthDateState extends State<BirthDate> {
  DateTime selectedDate = DateTime(1999);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Birthday',
      ),
      body: SingleChildScrollView(
        child: CustomPadding(
          top: 35.0,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const FormHeader(
                  heading: "What's your birthday?",
                  body:
                      'Choose your date of birth. Make sure you scroll through the dates to select your birth date.',
                ),
                SizedBox(
                  height: 250,
                  child: ScrollDatePicker(
                    selectedDate: selectedDate,
                    minimumDate: DateTime(1950),
                    maximumDate: DateTime(2010),
                    locale: const Locale('en'),
                    onDateTimeChanged: (DateTime value) {
                      setState(() {
                        selectedDate = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  child: Text(
                    " ${DateTime.now().year - selectedDate.year} Years old",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 80.0,
                ),
                RoundedTextButton(
                  text: 'Next',
                  buttonColor: kPrimaryColor,
                  onPressed: () {
                    UserVariables.birthdate = selectedDate.year.toString();
                    changePage(context: context, page: const Gender());
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
