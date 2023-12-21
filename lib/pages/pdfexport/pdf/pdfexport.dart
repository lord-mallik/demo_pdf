import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../models/invoice.dart';

Future<Uint8List> makePdf(Invoice invoice) async {
  final pdf = Document();
  final imageLogo = MemoryImage(
      (await rootBundle.load('assets/lordShiva.jpeg')).buffer.asUint8List());

  final List<TableRow> tableRows = [
    TableRow(
      children: [
        Padding(
          child: Text(
            'INVOICE FOR PAYMENT',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          padding: const EdgeInsets.all(20),
        ),
      ],
    ),
    ...invoice.items.map(
      (e) => TableRow(
        children: [
          Expanded(
            child: PaddedText(e.description),
            flex: 2,
          ),
          Expanded(
            child: PaddedText("\$${e.cost}"),
            flex: 1,
          ),
        ],
      ),
    ),
    TableRow(
      children: [
        PaddedText('TAX', align: TextAlign.right),
        PaddedText('\$${(invoice.totalCost() * 0.1).toStringAsFixed(2)}'),
      ],
    ),
    TableRow(
      children: [
        PaddedText('TOTAL', align: TextAlign.right),
        PaddedText('\$${(invoice.totalCost() * 1.1).toStringAsFixed(2)}'),
      ],
    ),
  ];

  // Function to create a table page with a subset of rows
  void addTablePage(List<TableRow> rows) {
    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("Attention to: ${invoice.customer}"),
                      Text(invoice.address),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image(imageLogo),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Table(
                border: TableBorder.all(color: PdfColors.black),
                children: rows,
              ),
              Padding(
                child: Text(
                  "THANK YOU FOR YOUR CUSTOM!",
                  style: Theme.of(context).header2,
                ),
                padding: EdgeInsets.all(20),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Maximum number of rows to fit on a single page
  const maxRowsPerPage = 15;

  // Split the tableRows into pages
  for (var i = 0; i < tableRows.length; i += maxRowsPerPage) {
    final endIndex = (i + maxRowsPerPage < tableRows.length)
        ? i + maxRowsPerPage
        : tableRows.length;
    final pageRows = tableRows.sublist(i, endIndex);
    addTablePage(pageRows);
  }

  return pdf.save();
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Text(
      text,
      textAlign: align,
    ),
  );
}
