import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';

import 'package:xperiencebase/widgets_functions/widgets/padding.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: ''),
      body: SingleChildScrollView(
        child: CustomPadding(
            top: 100.0,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 180.0,
                    width: 180.0,
                    child: SvgPicture.asset('images/qa_engineer.svg'),
                  ),
                  const Text(
                    'Oops! It seems like your app is out of date or you are offline, please try updating your app or connecting to active internet connection. Close all instances of the app and then reload',
                    style: TextStyle(color: kRedColor),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
