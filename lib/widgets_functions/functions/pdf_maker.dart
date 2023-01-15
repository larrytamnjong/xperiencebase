import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;


String fileName = '';
String pathName = '';
Future<void> generatePdfReceipt(
    {required String paymentReference,
      required String clientName,
      required String clientPhone,
      required String paymentAmount,
      required String accountCredited,
      required String clientEmail,
      required String accountNumber,
      required String paymentID,
      //required String serviceFee,
     // required String servicePaidFor,
      required String timeOfPayment}) async {
  final pdf = Document();
  var data = await rootBundle.load("assets/Roboto-Regular.ttf");
  final ttf = Font.ttf(data);
  final imageLogo = MemoryImage(
      (await rootBundle.load('assets/logo.jpeg'))
          .buffer
          .asUint8List());
  final qrCode = MemoryImage(
      (await rootBundle.load('assets/qr_code.png')).buffer.asUint8List());
  pdf.addPage(
    Page(
      build: (Context context) => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  child: Image(imageLogo),
                ),
                Container(
                  height: 39,
                  width: 250,
                  decoration: BoxDecoration(
                    color: PdfColor.fromHex("#6750A4"),
                  ),
                  child: Center(
                    child: Text(
                      'PAYMENT RECEIPT',
                      style: TextStyle(
                          font: ttf,
                          color: PdfColors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Row(children: [
              Text('Receipt Number'),
              Spacer(flex: 100),
              Text('$paymentReference #$paymentID '),
            ]),

            Row(children: [
              Text('Date'),
              Spacer(flex: 100),
              Text(timeOfPayment),
            ]),
            //Company Information
            Container(
              height: 32,
              width: 500,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 295),
                  child: Text('COMPANY INFORMATION',
                      style: const TextStyle(color: PdfColors.white)),
                ),
              ),
              decoration: BoxDecoration(
                color: PdfColor.fromHex("#6750A4"),
              ),
            ),
            Row(children: [
              Text('Company'),
              Spacer(flex: 100),
              Text('Xperiencebase.com'),
            ]),
            Row(children: [
              Text('Address'),
              Spacer(flex: 100),
              Text('Bamenda, Cameroon'),
            ]),
            Row(children: [
              Text('Phone'),
              Spacer(flex: 100),
              Text('+(237)680162416'),
            ]),
            //Client Information
            Container(
              height: 32,
              width: 500,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 295),
                  child: Text('CLIENT INFORMATION',
                      style: const TextStyle(color: PdfColors.white)),
                ),
              ),
              decoration: BoxDecoration(
                color: PdfColor.fromHex("#6750A4"),
              ),
            ),
            Row(children: [
              Text('Client Name'),
              Spacer(flex: 100),
              Text(clientName),
            ]),
            Row(children: [
              Text('Phone'),
              Spacer(flex: 100),
              Text(clientPhone),
            ]),
            Row(children: [
              Text('Email'),
              Spacer(flex: 100),
              Text(clientEmail),
            ]),
            Row(children: [
              Text('Account Number'),
              Spacer(flex: 100),
              Text('#$accountNumber'),
            ]),
            //Payment Information
            Container(
              height: 32,
              width: 500,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 295),
                  child: Text('PAYMENT INFORMATION',
                      style: const TextStyle(color: PdfColors.white)),
                ),
              ),
              decoration: BoxDecoration(
                color: PdfColor.fromHex("#6750A4"),
              ),
            ),

            Row(children: [
              Text('Amount'),
              Spacer(flex: 100),
              Text(paymentAmount),
            ]),
            Row(children: [
              Text('Service Fee'),
              Spacer(flex: 100),
              Text('N/A'),
            ]),
            Row(children: [
              Text('Method'),
              Spacer(flex: 100),
              Text('Rav Flutterwave Mobile Money'),
            ]),
            Row(children: [
              Text('Account Credited '),
              Spacer(flex: 100),
              Text(accountCredited),
            ]),
            Row(children: [
              Text('Reason'),
              Spacer(flex: 100),
              Text('Student Union Dues'),
            ]),
            Row(children: [
              Text('Payment Reference'),
              Spacer(flex: 100),
              Text(paymentReference),
            ]),
            SizedBox(height: 60),
            Text('Please report any inconsistencies in this receipt to the contact above.'),
            Container(
              height: 130,
              width: 130,
              child: Image(qrCode),
            ),


          ],
        ),
      ),
    ),
  );

  final path = (await getExternalStorageDirectory())?.path;

  File file = File("$path/receipt$paymentReference.pdf");
  file.writeAsBytesSync(await pdf.save());
  pathName = path!;
  fileName = "/receipt$paymentReference.pdf";
 // print(path);
}
