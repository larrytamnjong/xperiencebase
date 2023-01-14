import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xperiencebase/app_screens/profile_screens/view_profile.dart';
import 'package:xperiencebase/authentication/welcome.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/functions/pagenavigation.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'application_screens/payment_register_screens/payment_home.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        actions: [
          IconButton(
              onPressed: () {
                changePage(context: context, page: const ViewProfile());
              },
              icon: const Icon(Icons.person))
        ],
      ),
      body: CustomPadding(
        top: 10.0,
        left: 9.6,
        right: 9.6,
        child: ListView(
          children: [
            const TitleBar(heading: 'Account Status'),
            ProfileListTile(
                leadingIconColor: kGreenColor,
                leadingIcon: Icons.verified,
                title: 'Active Account',
                subtitle: 'You can apply for all opportunities',
                onTap: () {}),
            const TitleBar(heading: 'Account Extra'),
            ProfileListTile(
              leadingIconColor: kPrimaryColor,
              leadingIcon: Icons.person_add,
              title: 'Share with your friends',
              subtitle: 'Get paid to share',
              onTap: () {},
            ),
            ProfileListTile(
                leadingIconColor: kPrimaryColor,
                leadingIcon: Icons.payment,
                title: 'Payment register',
                subtitle: 'Pay for a product or service with us',
                onTap: () {
                  changePage(context: context, page: const PaymentHome());
                }),
            const TitleBar(heading: 'Support'),
            ProfileListTile(
              leadingIcon: Icons.help,
              title: 'Find help',
              subtitle: 'Find answers to your questions',
              onTap: () {},
            ),
            ProfileListTile(
                leadingIcon: Icons.sunny,
                title: 'Suggest a feature',
                subtitle: 'Help us become better',
                onTap: () {}),
            ProfileListTile(
                leadingIcon: Icons.star,
                title: 'Rate us',
                subtitle: 'Please rate us on Google Play',
                onTap: () {}),
            ProfileListTile(
                leadingIcon: Icons.policy_outlined,
                title: 'Terms and conditions',
                subtitle: 'Get to understand our policy',
                onTap: () {}),
            ProfileListTile(
                leadingIconColor: kRedColor,
                leadingIcon: Icons.power_settings_new_outlined,
                title: 'Log Out',
                subtitle: '${UserVariables.name}',
                onTap: () async {
                  //Initialize and clear off saved value stored in shared preference
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('userId');
                  await prefs.remove('name');
                  await prefs.remove('accountNumber');
                  await prefs.remove('phone');
                  await prefs.remove('email');
                  await prefs.remove('gender');
                  await prefs.remove('birthdate');
                  await prefs.remove('creationDate');
                  //Reset account balance to 0
                  UserVariables.accountBalance = '0';
                  if (!mounted) return;
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const Welcome()),
                      (Route<dynamic> route) => false);
                }),
            ProfileListTile(
                leadingIconColor: kRedColor,
                leadingIcon: Icons.delete_forever_rounded,
                title: 'Delete account',
                subtitle: 'Delete your account forever?',
                onTap: () {})
          ],
        ),
      ),
    );
  }
}

class ProfileListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final Function onTap;
  final Color? leadingIconColor;

  const ProfileListTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.leadingIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          leading: Icon(
            leadingIcon,
            color: leadingIconColor ?? Colors.black54,
            size: 25.5,
          ),
          title: Text(title),
          enableFeedback: true,
          tileColor: kSurfaceVariant,
          subtitle: Text(subtitle),
          onTap: () {
            onTap();
          },
        ),
        const Divider(),
      ],
    );
  }
}

class TitleBar extends StatelessWidget {
  final String heading;
  const TitleBar({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        Text(
          heading,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 13.0),
      ],
    );
  }
}
