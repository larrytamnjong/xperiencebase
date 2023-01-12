import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xperiencebase/widgets_functions/functions/snackbar_menus.dart';

launchWhatsApp({required BuildContext context}) async {
  const url = 'https://wa.me/237680162416?text=Hello!';
  if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
    showToast(
        title: 'Failure',
        body: 'Please make sure WhatsApp is installed on your device.',
        snackBarType: ContentType.failure,
        context: context);
  } else {
    //Do something here if launch is successful
  }
}
