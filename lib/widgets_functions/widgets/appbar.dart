import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xperiencebase/constants/colors.dart';

///Custom AppBar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool? automaticallyImplyLeading;
  final bool? centerTitle;
  final String? fontFamily;
  const CustomAppBar(
      {Key? key,
      required this.title,
      this.actions,
      this.automaticallyImplyLeading,
      this.centerTitle, this.fontFamily})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      centerTitle: centerTitle ?? false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: kWhiteColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      iconTheme: const IconThemeData(color: kBlackColor),
      actions: actions,
      title: Text(
        title,
        style:  TextStyle(color: Colors.black, fontSize: 21.0, fontFamily: '$fontFamily'),
      ),
      elevation: 0,
      backgroundColor: kWhiteColor,
    );
  }

  static final _appBar = AppBar();
  @override
  Size get preferredSize => _appBar.preferredSize;
}
