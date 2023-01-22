import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:xperiencebase/constants/colors.dart';
import 'package:xperiencebase/widgets_functions/functions/variables.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';
import 'package:xperiencebase/widgets_functions/widgets/padding.dart';
import 'package:xperiencebase/widgets_functions/widgets/button.dart';
import 'package:flutter/services.dart';
import 'package:xperiencebase/widgets_functions/functions/snackbar_menus.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:xperiencebase/widgets_functions/functions/api.dart';
import 'package:xperiencebase/widgets_functions/functions/account_brain.dart';
import 'package:xperiencebase/widgets_functions/functions/pagenavigation.dart';
import 'package:xperiencebase/widgets_functions/widgets/deposit_widget.dart';

bool setShowWithdrawal = false;

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  void getAccountBalance() async {
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
    getAccountBalance();
    Api.userDepositHistory();
    Api.userWithdrawalHistory();

    super.initState();
  }

  @override
  void deactivate() {
    clearDepositWithdrawalList();
    super.deactivate();
  }

  @override
  void dispose() {
    clearDepositWithdrawalList();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
          IconButton(
            onPressed: () {
              QuickAlert.show(
                  title: 'Good to know',
                  barrierDismissible: true,
                  confirmBtnColor: kSecondaryColor,
                  context: context,
                  type: QuickAlertType.info,
                  text:
                      'You can long press the deposit or withdraw button to navigate and view credit or debit logs',
                  onConfirmBtnTap: () {
                    Navigator.pop(context);
                  });
            },
            icon: const Icon(Icons.info),
          )
        ],
        title: 'Accounts',
      ),
      body: CustomPadding(
        top: 5.0,
        left: 15.0,
        right: 15.0,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: kSurfaceVariant,
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5.0),

                  ///Account number
                  AccountTextField(
                    text: "#${UserVariables.accountNumber}",
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    bottom: 0.5,
                  ),

                  ///Account status
                  const AccountTextField(
                    text: '~Active',
                    fontSize: 15.0,
                    color: kGreenColor,
                    bottom: 5.0,
                  ),

                  ///Account balance
                  AccountTextField(
                    text: '${UserVariables.accountBalance}.00 XAF',
                    fontSize: 19.5,
                    fontWeight: FontWeight.w500,
                    bottom: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10.0),
                      TextButtonWithIcon(
                        label: 'Deposit',
                        icon: Icons.wallet_rounded,
                        onPressed: () async {
                          await Api.getFlutterwavePublicKey();
                          changePage(
                              context: context, page: const DepositWidget());
                        },
                        onLongPressed: () {
                          setState(() {
                            setShowWithdrawal = false;
                          });
                        },
                      ),
                      TextButtonWithIcon(
                        label: 'Withdraw',
                        icon: Icons.download,
                        onPressed: () {},
                        onLongPressed: () {
                          setState(() {
                            setShowWithdrawal = true;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const TitleTransactionHistoryIcon(),
            TransactionHistoryView(
              showWithdrawal: setShowWithdrawal,
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionHistoryView extends StatefulWidget {
  final bool showWithdrawal;
  const TransactionHistoryView({
    Key? key,
    required this.showWithdrawal,
  }) : super(key: key);

  @override
  State<TransactionHistoryView> createState() => _TransactionHistoryViewState();
}

class _TransactionHistoryViewState extends State<TransactionHistoryView> {
  bool shouldDisplayNothing() {
    if (DepositVariables.depositAmount.isEmpty &&
        WithdrawalVariables.withdrawalAmount.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
        child: Scaffold(
          backgroundColor: kSurfaceVariant,
          body: shouldDisplayNothing()
              ? const NothingToDisplay()
              : ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: widget.showWithdrawal
                      ? WithdrawalVariables.withdrawalAmount.length
                      : DepositVariables.depositAmount.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimatedListView(
                      position: index,
                      child: Slidable(
                        startActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (BuildContext context) {
                                Clipboard.setData(ClipboardData(
                                        text: widget.showWithdrawal
                                            ? '${WithdrawalVariables.withdrawalReferences[index]}'
                                            : '${DepositVariables.depositReferences[index]}'))
                                    .then((value) => displaySnackBar(
                                        context: context,
                                        content: const Text(
                                            'Reference has been copied'),
                                        backgroundColor: kPrimaryColor));
                              },
                              backgroundColor: kWhiteColor,
                              foregroundColor: kBlackColor,
                              icon: Icons.copy,
                              label: 'Copy reference',
                            ),
                          ],
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          title: widget.showWithdrawal
                              ? const Text('Withdraw & debit')
                              : const Text('Deposit & credit'),
                          trailing: widget.showWithdrawal
                              ? Text(
                                  '- ${WithdrawalVariables.withdrawalAmount[index]} XAF',
                                  style: const TextStyle(color: kRedColor))
                              : Text(
                                  '+ ${DepositVariables.depositAmount[index]} XAF',
                                  style: const TextStyle(color: kGreenColor)),
                          subtitle: widget.showWithdrawal
                              ? Text(
                                  '${WithdrawalVariables.withdrawalTime[index]}')
                              : Text('${DepositVariables.depositTime[index]}'),
                          leading: const Icon(
                            Icons.currency_franc,
                            color: kOnPrimaryContainer,
                          ),
                          onTap: () {},
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
        ),
      ),
    );
  }
}

///If transaction list is empty display this widget
class NothingToDisplay extends StatelessWidget {
  const NothingToDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No history to display or loading history',
        style: TextStyle(fontSize: 16.0),
        textAlign: TextAlign.center,
      ),
    );
  }
}

///Transaction history and icon => [Header]
class TitleTransactionHistoryIcon extends StatelessWidget {
  const TitleTransactionHistoryIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'Transaction history',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Icon(Icons.access_time)
        ],
      ),
    );
  }
}

///Account Text Field
class AccountTextField extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final double bottom;

  final FontWeight? fontWeight;
  const AccountTextField({
    Key? key,
    required this.text,
    required this.fontSize,
    this.fontWeight,
    this.color,
    required this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.0, left: 10.0, bottom: bottom),
      child: Text(
        text,
        style: TextStyle(
          color: color ?? kBlackColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
