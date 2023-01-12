import 'package:flutter/material.dart';
import 'package:xperiencebase/authentication/registration/r_phone.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'package:xperiencebase/widgets_functions/widgets/form_header.dart';
import 'package:xperiencebase/widgets_functions/functions/validator.dart';

class Gender extends StatefulWidget {
  const Gender({Key? key}) : super(key: key);

  @override
  State<Gender> createState() => _GenderState();
}

enum Genders {
  male,
  female,
  neutral,
}

class _GenderState extends State<Gender> {
  Genders genderOption = Genders.neutral;
  String? selectedGender;

  bool _isShowErrorText = false;

  //Function which gets gender option and sets selected gender
  void setGenderOption() {
    switch (genderOption) {
      case Genders.male:
        selectedGender = 'Male';
        break;
      case Genders.female:
        selectedGender = 'Female';
        break;
      default:
        selectedGender = 'neutral';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Gender',
      ),
      body: SingleChildScrollView(
        child: CustomPadding(
          top: 35.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FormHeader(
                heading: "What's your gender?",
                body:
                    'Your gender will be made public for potential recruiters. Gender might play a role in certain selections',
              ),
              ShowErrorText(showErrorText: _isShowErrorText),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RoundedTextButton(
                        text: 'Male',
                        buttonColor: genderOption == Genders.male
                            ? kSecondaryColor
                            : kPrimaryContainer,
                        textColor: genderOption == Genders.male
                            ? kWhiteColor
                            : kOnPrimaryContainer,
                        onPressed: () {
                          setState(() {
                            genderOption = Genders.male;
                            setGenderOption();
                          });
                        }),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: RoundedTextButton(
                      text: 'Female',
                      buttonColor: genderOption == Genders.female
                          ? kSecondaryColor
                          : kPrimaryContainer,
                      textColor: genderOption == Genders.female
                          ? kWhiteColor
                          : kOnPrimaryContainer,
                      onPressed: () {
                        setState(
                          () {
                            genderOption = Genders.female;
                            setGenderOption();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 80.0,
              ),
              NullValidatorRoundButton(
                  buttonCaption: 'Next',
                  color: kPrimaryColor,
                  requiredValue: selectedGender,
                  nextPage: const Phone(),
                  setState: (bool value) {
                    setState(() {
                      _isShowErrorText = value;
                    });
                    UserVariables.gender = selectedGender;
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
