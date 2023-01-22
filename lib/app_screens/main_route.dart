import 'package:flutter/material.dart';
import 'package:xperiencebase/app_screens/profile.dart';
import 'package:xperiencebase/app_screens/foryou.dart';
import 'package:xperiencebase/app_screens/account.dart';
import 'package:xperiencebase/app_screens/applications_history.dart';
import 'package:xperiencebase/app_screens/apply.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/functions/api.dart';
import 'package:xperiencebase/app_screens/error_screen.dart';

class MainRoute extends StatefulWidget {
  const MainRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<MainRoute> createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {
  int selectedPageIndex = 0;
  PageController pageController = PageController();

  List<StatefulWidget> pages = [
    const Account(),
    const Apply(),
    const ForYou(),
    const ApplicationsHistory(),
    const Profile(),
  ];
  void checkAppVersion() async {
    String appVersion = await Api.getAppVersion();
    if (appVersion != '1.0.1') {
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ErrorScreen()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    checkAppVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: kSurfaceVariant),
          ),
          color: kWhiteColor,
        ),
        child: BottomNavigationBar(
          elevation: 1.0,
          iconSize: 25.5,
          backgroundColor: kWhiteColor,
          showUnselectedLabels: true,
          unselectedIconTheme: const IconThemeData(color: Colors.black54),
          enableFeedback: true,
          selectedItemColor: kBlackColor,
          type: BottomNavigationBarType.shifting,
          items: const [
            BottomNavigationBarItem(
              label: 'Accounts',
              icon: Icon(Icons.account_balance_rounded),
            ),
            BottomNavigationBarItem(
              label: 'Apply',
              icon: Icon(Icons.send_rounded),
            ),
            BottomNavigationBarItem(
              label: 'For you',
              icon: Icon(Icons.cases_rounded),
            ),
            BottomNavigationBarItem(
              label: 'Status',
              icon: Icon(Icons.history),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.person),
            ),
          ],
          currentIndex: selectedPageIndex,
          onTap: (index) {
            setState(() {
              selectedPageIndex = index;
              pageController.animateToPage(selectedPageIndex,
                  duration: const Duration(microseconds: 200),
                  curve: Curves.bounceIn);
            });
          },
        ),
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: pageController,
        children: pages,
        onPageChanged: (index) {
          setState(
            () {
              selectedPageIndex = index;
            },
          );
        },
      ),
    );
  }
}
