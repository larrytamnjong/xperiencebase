import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/functions/training_application_brain.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/loading.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'package:xperiencebase/widgets_functions/functions/api.dart';

class ApplicationsHistory extends StatefulWidget {
  const ApplicationsHistory({Key? key}) : super(key: key);

  @override
  State<ApplicationsHistory> createState() => _ApplicationsHistoryState();
}

bool _isLoadingHistory = false;

class _ApplicationsHistoryState extends State<ApplicationsHistory> {
  void getApplicationHistory() async {
    setState(() {
      _isLoadingHistory = true;
    });
    await Api.userApplicationHistory();
    if (mounted) {
      setState(() {
        ApplicationHistoryVariables.trainingApplicationStatus;
        ApplicationHistoryVariables.trainingApplicationDates;
        ApplicationHistoryVariables.trainingCompanyNames;
        ApplicationHistoryVariables.trainingSectorNames;
        _isLoadingHistory = false;
      });
    }
  }

  @override
  void initState() {
    getApplicationHistory();
    super.initState();
  }

  @override
  void dispose() {
    clearUserApplicationHistoryLists();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Application History',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info),
          )
        ],
      ),
      body: CustomPadding(
        top: 10.0,
        left: 5.0,
        right: 5.0,
        child: _isLoadingHistory
            ? const ApplicationsShimmerLoader()
            : ApplicationHistoryVariables.trainingCompanyNames.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 180.0,
                            width: 180.0,
                            child: SvgPicture.asset('images/no_data.svg'),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            "Hey ${UserVariables.name} we can't find any active applications, please ensure you have an internet connection",
                            style: const TextStyle(color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount:
                        ApplicationHistoryVariables.trainingCompanyNames.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimatedListView(
                        position: index,
                        child: ApplicationHistoryTile(
                          imageUrl: 'images/icon-rounded.png',
                          department: ApplicationHistoryVariables
                              .trainingSectorNames[index],
                          company: ApplicationHistoryVariables
                              .trainingCompanyNames[index]
                              .toUpperCase(),
                          date: ApplicationHistoryVariables
                              .trainingApplicationDates[index],
                          status: ApplicationHistoryVariables
                              .trainingApplicationStatus[index],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
      ),
    );
  }
}

class ApplicationHistoryTile extends StatelessWidget {
  final String imageUrl;
  final String department;
  final String company;
  final String date;
  final String status;

  const ApplicationHistoryTile({
    super.key,
    required this.imageUrl,
    required this.department,
    required this.company,
    required this.date,
    required this.status,
  });
  //Function to set status box Color based on application status
  Color setStatusBoxColor() {
    if (status == 'Pending') {
      return Colors.orange;
    } else if (status == 'Accepted') {
      return kGreenColor;
    } else if (status == 'Rejected') {
      return kRedColor;
    } else {
      return kPrimaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: kSurfaceVariant, borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundColor: kWhiteColor,
                child: Image(
                  image: AssetImage(imageUrl),
                ),
              ),
              title: Text(department),
              subtitle: Text(company),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: const TextStyle(color: Colors.grey),
                ),
                Container(
                  height: 29.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                      color: setStatusBoxColor(),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Center(
                    child: Text(
                      status,
                      style: const TextStyle(color: kWhiteColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
