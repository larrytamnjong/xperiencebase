import 'package:flutter/material.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/functions/lunch_whatsapp.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';

import 'package:xperiencebase/widgets_functions/widgets/padding.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile information',
      ),
      body: SingleChildScrollView(
        child: CustomPadding(
          top: 13.0,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CircleAvatar(
                  radius: 35.0,
                  backgroundColor: kPrimaryColor,
                  child: Icon(
                    Icons.person,
                    color: kWhiteColor,
                    size: 40.0,
                  ),
                ),
                const SizedBox(height: 14.0),

                ///User name
                Text(UserVariables.name!,
                    style: boldText, textAlign: TextAlign.center),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ///Account creation date
                    Text(UserVariables.creationDate!),
                    const SizedBox(width: 5.0),
                    const Icon(
                      Icons.verified,
                      color: kGreenColor,
                    ),

                    ///Account status
                    const Text(
                      'Active',
                      style: TextStyle(color: kGreenColor),
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                Container(
                  height: 280.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: kSurfaceVariant),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 15.0, left: 12.0),
                        child: Text('Personal details', style: boldText),
                      ),

                      ///Account Number
                      ProfileDataRow(
                        icon: Icons.person,
                        text: '#${UserVariables.accountNumber!}',
                      ),

                      /// User email
                      ProfileDataRow(
                          icon: Icons.email, text: UserVariables.email!),

                      ///User phone
                      ProfileDataRow(
                          icon: Icons.phone_android_outlined,
                          text: UserVariables.phone!),

                      ///User date of birth
                      ProfileDataRow(
                          icon: Icons.calendar_month_sharp,
                          text: UserVariables.birthdate!),

                      ///User gender
                      ProfileDataRow(
                          icon: Icons.man_outlined,
                          text: UserVariables.gender!),

                      ///Country
                      const ProfileDataRow(
                          icon: Icons.location_on, text: 'Cameroon'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                const Text(
                  'Personal information can not be changed manually for changing information please contact support on WhatsApp or email only.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 18.0),
                RoundedTextButton(
                    text: 'Chat with support on WhatsApp',
                    buttonColor: kPrimaryColor,
                    onPressed: () {
                      launchWhatsApp(context: context);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileDataRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const ProfileDataRow({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        left: 12.0,
      ),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 5.0),
          Text(text),
        ],
      ),
    );
  }
}

const boldText = TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0);
