import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/functions/lunch_whatsapp.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'package:xperiencebase/widgets_functions/functions/pagenavigation.dart';
import 'package:xperiencebase/app_screens/application_screens/select_option.dart';

class Apply extends StatefulWidget {
  const Apply({Key? key}) : super(key: key);

  @override
  State<Apply> createState() => _ApplyState();
}

class _ApplyState extends State<Apply> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          changePage(context: context, page: const Option());
        },
        child: const Icon(
          Icons.add,
          color: kWhiteColor,
        ),
      ),
      appBar: CustomAppBar(
        title: 'Application',
        actions: [
          IconButton(
            onPressed: () {
              launchWhatsApp(context: context);
            },
            icon: const Icon(Icons.help),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: CustomPadding(
          top: 13.0,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 200.0,
                  width: 200.0,
                  child: SvgPicture.asset('images/resume.svg'),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const Text(
                  'Click on the floating action button below to start a new application',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
