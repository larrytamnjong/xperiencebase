import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xperiencebase/app_screens/main_route.dart';
import 'package:xperiencebase/authentication/welcome.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //create variable to hold widgets pages
  Widget nextRouteScreen = const Welcome();
  preLaunchFunc() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('userId') == null) {
      setState(() {
        nextRouteScreen = const Welcome();
      });
    } else if (prefs.getString('userId') != null) {
      UserVariables.userId = prefs.getString('userId')!;
      UserVariables.name = prefs.getString('name')!;
      UserVariables.accountNumber = prefs.getString('accountNumber')!;
      UserVariables.phone = prefs.getString('phone')!;
      UserVariables.email = prefs.getString('email')!;
      UserVariables.gender = prefs.getString('gender')!;
      UserVariables.birthdate = prefs.getString('birthdate')!;
      UserVariables.creationDate = prefs.getString('creationDate')!;
      setState(() {
        nextRouteScreen = const MainRoute();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    preLaunchFunc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: 'Feeling great today..', fontFamily: 'DancingScript'),
      body: AnimatedSplashScreen(
        splashIconSize: 130.0,
        splash: 'images/icon.png',
        nextScreen: nextRouteScreen,
        splashTransition: SplashTransition.slideTransition,
      ),
    );
  }
}
