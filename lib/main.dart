import 'package:flutter/material.dart';
import 'package:xperiencebase/authentication/splash_screen.dart';
import 'app_screens/payment_register_screens/payment_history.dart';
import 'constants/colors.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: kWhiteColor,
        colorScheme: const ColorScheme.light().copyWith(
          primary: kPrimaryColor,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
