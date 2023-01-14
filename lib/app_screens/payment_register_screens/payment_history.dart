import 'package:flutter/material.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/functions/training_application_brain.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/loading.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'package:xperiencebase/widgets_functions/functions/api.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}
bool _isLoadingRegisterHistory = false;
class _PaymentHistoryState extends State<PaymentHistory> {

  void getPaymentRegisterHistory()async{
    setState(() {
      _isLoadingRegisterHistory = true;
    });
    await Api.getPaymentRegisterHistory();
    if (mounted) {
      setState(() {
        PaymentRegisterHistoryVariables.companyNames;
        PaymentRegisterHistoryVariables.paymentAmounts;
        PaymentRegisterHistoryVariables.paymentReferences;
        PaymentRegisterHistoryVariables.paymentPeriods;
        PaymentRegisterHistoryVariables.paymentTime;
        _isLoadingRegisterHistory = false;
      });
    }
  }

  @override
  void initState() {
    getPaymentRegisterHistory();
    super.initState();
  }
  @override
  void dispose() {
   clearPaymentHistoryRegisterList();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return _isLoadingRegisterHistory ? const LoadingScreen(waitingText: 'Getting transactions'): Scaffold(
      appBar: const CustomAppBar(title: 'Payment history'),
      body: CustomPadding(
        top: 10.0,
        left: 7.0,
        right: 7.0,
        child: PaymentRegisterHistoryVariables.companyNames.isEmpty? const Center(child: Text('Nothing to show here'),)
            : ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: PaymentRegisterHistoryVariables.companyNames.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              iconColor: kPrimaryColor,
              leading: const Icon(Icons.account_balance),
              title: Text(PaymentRegisterHistoryVariables.companyNames[index]),
              subtitle: Text(PaymentRegisterHistoryVariables.paymentTime[index]),
              trailing: Text('${PaymentRegisterHistoryVariables.paymentAmounts[index]} XAF', style: const TextStyle(color: kGreenColor),),
              enableFeedback: true,
              onTap: (){

              },
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        ),
      ),
    );
  }
}
