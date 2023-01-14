import 'package:flutter/material.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Payment history'),
      body: SingleChildScrollView(
        child: CustomPadding(
          top: 10.0,
          child: Column(
            children: const [],
          ),
        ),
      ),
    );
  }
}
