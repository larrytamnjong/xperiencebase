import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:xperiencebase/constants/colors.dart';

///Validator for Password Field
MultiValidator passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Required'),
  MaxLengthValidator(10,
      errorText: 'Password cannot be more than 9 characters'),
  MinLengthValidator(6, errorText: 'Password cannot be less than 6 characters'),
  RequiredValidator(errorText: 'Required'),
]);

///Validator for phone Field
MultiValidator phoneValidator = MultiValidator([
  RequiredValidator(errorText: 'Required'),
  PatternValidator(r'^[0-9]*$', errorText: 'Invalid phone number'),
  MaxLengthValidator(9,
      errorText: 'Phone number cannot be more than 9 characters'),
  MinLengthValidator(9,
      errorText: 'Phone number cannot be less than 9 characters'),
]);

///Required Validator
RequiredValidator requiredValidator = RequiredValidator(errorText: 'Required');

///Email Validator
MultiValidator emailValidator = MultiValidator([
  EmailValidator(errorText: 'Invalid email address'),
  RequiredValidator(errorText: 'Required')
]);

///Custom required validator error message and widget
String errorText = 'You must make a selection';

class ShowErrorText extends StatelessWidget {
  const ShowErrorText({
    Key? key,
    required this.showErrorText,
  }) : super(key: key);

  final bool showErrorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15.0,
          child: showErrorText
              ? Text(
                  errorText,
                  style: const TextStyle(color: kErrorColor),
                  textAlign: TextAlign.center,
                )
              : null,
        ),
        const SizedBox(height: 12.0),
      ],
    );
  }
}
