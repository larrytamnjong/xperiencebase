import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:xperiencebase/widgets_functions/functions/pdf_maker.dart';
import 'package:xperiencebase/widgets_functions/widgets/appbar.dart';

class ViewPdfReceipt extends StatefulWidget {
  const ViewPdfReceipt({Key? key}) : super(key: key);

  @override
  State<ViewPdfReceipt> createState() => _ViewPdfReceiptState();
}

class _ViewPdfReceiptState extends State<ViewPdfReceipt> {
  void _openPath(String path) async {
    OpenFile.open(path);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Receipt view', actions: [
        IconButton(onPressed: (){ _openPath('$pathName$fileName');}, icon: const Icon(Icons.open_in_new))
      ],),
      body: PdfView(path: '$pathName$fileName'),
    );
  }
}
