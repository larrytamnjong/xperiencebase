import 'package:flutter/material.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/functions/pagenavigation.dart';

///Custom  TextButton
class CustomTextButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const CustomTextButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          text,
          style: const TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}

///Rounded TextButton
class RoundedTextButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color buttonColor;
  final Color? textColor;
  const RoundedTextButton(
      {super.key,
      required this.text,
      required this.buttonColor,
      this.textColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: buttonColor,
      ),
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? kWhiteColor,
          ),
        ),
      ),
    );
  }
}

///Text Button with Icon
class TextButtonWithIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  final void Function() onPressed;
  final void Function() onLongPressed;
  const TextButtonWithIcon(
      {super.key,
      required this.label,
      required this.icon,
      required this.onPressed,
      required this.onLongPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        width: 125.0,
        decoration: const BoxDecoration(color: kWhiteColor),
        child: TextButton(
          onPressed: () {
            onPressed();
          },
          onLongPress: () {
            onLongPressed();
          },
          child: Row(
            children: [
              Icon(
                icon,
                color: kBlackColor,
              ),
              const SizedBox(
                width: 5.0,
              ),
              Text(
                label,
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom DropdownButton
class CustomDropDownButton extends StatelessWidget {
  final String? value;
  final String hint;
  final List<String> list;
  final Function onChanged;
  const CustomDropDownButton(
      {super.key,
      required this.value,
      required this.hint,
      required this.list,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: DropdownButton<String>(
        value: value,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: kBlackColor,
        ),
        hint: Text(hint),
        enableFeedback: true,
        isExpanded: true,
        dropdownColor: kWhiteColor,
        elevation: 16,
        style: const TextStyle(color: kBlackColor),
        underline: Container(
          height: 1.1,
          color: kBlackColor,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          onChanged(value);
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

/// Null Validator RoundButton (Use this button on dropdown form field without validator requiring a user to enter  a value)
class NullValidatorRoundButton extends StatefulWidget {
  final void Function(bool value) setState;
  final String? buttonCaption;
  final String? requiredValue;
  final Widget nextPage;
  final Color? color;
  const NullValidatorRoundButton(
      {super.key,
      required this.buttonCaption,
      required this.requiredValue,
      required this.nextPage,
      required this.setState,
      this.color});

  @override
  State<NullValidatorRoundButton> createState() =>
      _NullValidatorRoundButtonState();
}

class _NullValidatorRoundButtonState extends State<NullValidatorRoundButton> {
  @override
  Widget build(BuildContext context) {
    return RoundedTextButton(
      text: widget.buttonCaption!,
      buttonColor: widget.color ?? kSecondaryColor,
      onPressed: () {
        if (widget.requiredValue != null) {
          changePage(context: context, page: widget.nextPage);
          setState(() {
            widget.setState(false);
          });
        } else {
          setState(() {
            widget.setState(true);
          });
        }
      },
    );
  }
}
