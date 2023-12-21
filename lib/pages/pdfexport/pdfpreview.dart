import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:printing/printing.dart';
import '../../models/invoice.dart';
import 'pdf/pdfexport.dart';

class PdfPreviewPage extends StatelessWidget {
  final Invoice invoice;
  const PdfPreviewPage({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(invoice),
      ),
    );
  }
}
