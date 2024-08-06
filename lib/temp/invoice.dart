import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';

class InvoiceScreen extends StatelessWidget {
  Future<File> _generateInvoice() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('INVOICE', style: pw.TextStyle(fontSize: 40, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Bill To:'),
                      pw.Text('John Doe'),
                      pw.Text('123 Main St'),
                      pw.Text('Anytown, AT 12345'),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Invoice Number: INV-001'),
                      pw.Text('Date: ${DateTime.now().toString().split(' ')[0]}'),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 40),
              pw.Table.fromTextArray(
                headers: ['Item', 'Quantity', 'Unit Price', 'Total'],
                data: [
                  ['Product A', '2', '\$10.00', '\$20.00'],
                  ['Product B', '1', '\$15.00', '\$15.00'],
                  ['Product C', '3', '\$7.00', '\$21.00'],
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text('Total: \$56.00', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ],
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/invoice.pdf");
    await file.writeAsBytes(await pdf.save());

    return file;
  }

  Future<void> _previewInvoice() async {
    final file = await _generateInvoice();
    OpenFile.open(file.path);
  }

  Future<void> _shareInvoice() async {
    final file = await _generateInvoice();
    Share.shareFiles([file.path], text: 'Here is your invoice');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Invoice Generator')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Preview Invoice'),
              onPressed: _previewInvoice,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Share Invoice'),
              onPressed: _shareInvoice,
            ),
          ],
        ),
      ),
    );
  }
}