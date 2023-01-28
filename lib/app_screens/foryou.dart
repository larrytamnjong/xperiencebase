import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/functions/training_application_api.dart';
import 'package:xperiencebase/widgets_functions/functions/training_application_brain.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';
import 'package:xperiencebase/widgets_functions/widgets/loading.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'package:xperiencebase/widgets_functions/functions/snackbar_menus.dart';
import 'package:xperiencebase/widgets_functions/functions/api.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:xperiencebase/widgets_functions/functions/account_brain.dart';

class ForYou extends StatefulWidget {
  const ForYou({Key? key}) : super(key: key);

  @override
  State<ForYou> createState() => _ForYouState();
}

bool _isLoadingEasyApply = false;

class _ForYouState extends State<ForYou> {
  getEasyApplyPost() async {
    setState(() {
      _isLoadingEasyApply = true;
    });
    await Api.getEasyApplyPosts();
    if (mounted) {
      setState(() {
        _isLoadingEasyApply = false;
        EasyApplyVariables.easyApplyDateOfPosts;
        EasyApplyVariables.easyApplySectorNames;
        EasyApplyVariables.easyApplyOptionNames;
        EasyApplyVariables.easyApplyIDs;
        EasyApplyVariables.easyApplyDistrictNames;
        EasyApplyVariables.easyApplyCityNames;
        EasyApplyVariables.easyApplyCompanyNames;
        EasyApplyVariables.easyApplyCompanyIDs;
      });
    }
  }

  void sendForYouApplication(int index) async {
    await  getAccountBalance();
    if ((int.parse(UserVariables.accountBalance!) >= 5000) ||
        (EasyApplyVariables.easyApplyCompanyNames[index] == 'CivilSalt' &&
            int.parse(UserVariables.accountBalance!) >= 2000)) {
      if(mounted) {
        displaySnackBar(
            context: context,
            content: const Text("Please wait sending request"),
            backgroundColor: Colors.orange);
      }
      TrainingApplicationVariables.selectedOptionName =
          EasyApplyVariables.easyApplyOptionNames[index];
      TrainingApplicationVariables.selectedSectorName =
          EasyApplyVariables.easyApplySectorNames[index];
      TrainingApplicationVariables.selectedCityName =
          EasyApplyVariables.easyApplyCityNames[index];
      TrainingApplicationVariables.selectedDistrictName =
          EasyApplyVariables.easyApplyDistrictNames[index];
      TrainingApplicationVariables.selectedCompanyName =
          EasyApplyVariables.easyApplyCompanyNames[index];
      TrainingApplicationVariables.selectedCompanyId =
          EasyApplyVariables.easyApplyCompanyIDs[index];
      TrainingApplicationVariables.school = 'Not specified';
      TrainingApplicationVariables.startDate = 'Not specified';
      TrainingApplicationVariables.endDate = 'Not specified';
      TrainingApplicationVariables.applicationStatus = 'Pending';

      var result = await TrainingApplicationApi.saveApplication();
      if (result == '1') {
        if (mounted) {
          QuickAlert.show(
              barrierDismissible: false,
              confirmBtnColor: kSecondaryColor,
              context: context,
              type: QuickAlertType.success,
              text: 'Application sent successfully, ${UserVariables.name}',
              onConfirmBtnTap: () {
                Navigator.pop(context);
              });
        }
      } else if (result == '0' || result == null) {
        if (mounted) {
          QuickAlert.show(
            confirmBtnColor: kSecondaryColor,
            context: context,
            type: QuickAlertType.error,
            title: 'Oops...',
            text: 'Sorry, something went wrong',
          );
        }
      } else {
        if (mounted) {
          showToast(
              title: "Failed",
              body: "Please check your connection or $result",
              snackBarType: ContentType.failure,
              context: context);
        }
      }
    } else {
      if(mounted) {
        showToast(
            title: "Failed",
            body:
            "You need to have at least 5000 XAF before you can apply or 2000 XAF for CivilSalt programs.",
            snackBarType: ContentType.failure,
            context: context);
      }
    }
  }
  getAccountBalance() async {
    DepositVariables.totalDeposit = await Api.userTotalDeposit();
    WithdrawalVariables.totalWithdrawal = await Api.userTotalWithdrawal();
    UserVariables.accountBalance = calculateBalance(
        DepositVariables.totalDeposit, WithdrawalVariables.totalWithdrawal);
    if (mounted) {
      setState(() {
        UserVariables.accountBalance;
      });
    }
  }
  @override
  void initState() {
    getEasyApplyPost();
    super.initState();
  }

  @override
  void dispose() {
    clearForYouList();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoadingEasyApply
          ? const ForYouShimmerLoader()
          : CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: kWhiteColor,
                  statusBarIconBrightness: Brightness.dark,
                ),
                iconTheme: const IconThemeData(color: kBlackColor),
                elevation: 0,
                pinned: true,
                snap: true,
                floating: true,
                centerTitle: false,
                backgroundColor: kWhiteColor,
                expandedHeight: 160.0,
                flexibleSpace: const FlexibleSpaceBar(
                    centerTitle: false,
                    title: Text(
                      'Xperience Base',
                      style: TextStyle(
                        color: kBlackColor,
                      ),
                    ),
                    background: Icon(
                      Icons.cases_rounded,
                      size: 50.0,
                      color: kBlackColor,
                    )),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search_outlined,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.filter_alt_rounded,
                      )),
                ],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return CustomPadding(
                      top: 10.0,
                      left: 10.0,
                      right: 10.0,
                      child: AnimatedListView(
                        position: index,
                        child: JobViewTile(
                          sector:
                              EasyApplyVariables.easyApplySectorNames[index],
                          company: EasyApplyVariables
                              .easyApplyCompanyNames[index],
                          date: EasyApplyVariables.easyApplyDateOfPosts[index],
                          option:
                              EasyApplyVariables.easyApplyOptionNames[index],
                          city: EasyApplyVariables.easyApplyCityNames[index],
                          district:
                              EasyApplyVariables.easyApplyDistrictNames[index],
                          duration: 'Not specified',
                          imageUrl: 'images/icon-rounded.png',
                          onButtonPressed: () {
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(13.0),
                                    topRight: Radius.circular(13.0)),
                              ),
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return EasyApplyConfirmation(
                                  negative: () {
                                    Navigator.pop(context);
                                  },
                                  positive: () async {
                                    Navigator.pop(context);
                                    //send details to submit function
                                    sendForYouApplication(index);
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                  childCount: EasyApplyVariables.easyApplyCompanyIDs.length,
                ),
              )
            ]),
    );
  }
}

class JobViewTile extends StatelessWidget {
  final String sector;
  final String company;
  final String date;
  final String option;
  final String city;
  final String district;
  final String duration;
  final String imageUrl;
  final Function onButtonPressed;

  const JobViewTile({
    super.key,
    required this.sector,
    required this.company,
    required this.date,
    required this.option,
    required this.city,
    required this.duration,
    required this.onButtonPressed,
    required this.district,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 335.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: kSurfaceVariant,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundColor: kWhiteColor,
                child: Image(
                  image: AssetImage(imageUrl),
                ),
              ),
              horizontalTitleGap: 10.0,
              trailing:
                  const Icon(Icons.verified_outlined, color: Colors.blueAccent),
              title: Text(sector),
              subtitle: Text(company),
            ),
            const Divider(),
            Row(
              children: [
                const SizedBox(width: 3.0),
                const Text('Verified~', style: TextStyle(color: kGreenColor)),
                const SizedBox(width: 10.0),
                Text(date, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const Divider(),
            CustomForYouApplyRow(text: option, icons: Icons.cases_outlined),
            CustomForYouApplyRow(text: city, icons: Icons.location_on),
            CustomForYouApplyRow(text: district, icons: Icons.directions),
            CustomForYouApplyRow(
                text: duration, icons: Icons.calendar_month_rounded),
            const SizedBox(height: 15.0),
            const Divider(),
            RoundedTextButton(
              text: 'Easy Apply',
              buttonColor: kPrimaryColor,
              onPressed: () {
                onButtonPressed();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomForYouApplyRow extends StatelessWidget {
  final String text;
  final IconData icons;
  const CustomForYouApplyRow({
    super.key,
    required this.text,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Icon(
              icons,
              color: Colors.black54,
              size: 18.0,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(text),
        ],
      ),
    );
  }
}
