//This code is for sending mail using Smtp mailer.

import 'dart:io';

import 'package:demo_pdf/pages/login/GoogleSignIn.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:pdf/widgets.dart' as pw;

import 'smtpServerConnection.dart';

class EmailSending extends StatefulWidget {
  const EmailSending({super.key});

  @override
  State<EmailSending> createState() => _EmailSendingState();
}

class _EmailSendingState extends State<EmailSending> {
  AuthSignIn authSignIn = AuthSignIn();

  // Oauth2Client oauth2client = Oauth2Client();

  Future<String> generatePdfData() async {
    // GoogleDrive googleDrive = GoogleDrive();
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Hello World!'),
        ),
      ),
    );
    final pdfBytes = await pdf.save();

    final directory = await path_provider.getTemporaryDirectory();
    final path = '${directory.path}/test.pdf';

    await File(path).writeAsBytes(pdfBytes);
    return path;
  }

  Future<void> sendingMail() async {
    try {
/*      final accessToken = Oauth2Client();
      accessToken.toString();*/

      final pdfPath = await generatePdfData();
      var message = Message();
      message.from = Address(userEmail.toString(), 'Aarav Kumar');
      message.recipients.add('lordnikhil11@gmail.com');
      message.bccRecipients.add('bccAddress@example.com');
      message.ccRecipients.addAll(
          [const Address('destCc1@example.com'), 'destCc2@example.com']);
      message.subject = 'Mailer Test';
      message.text = 'Email from the mailer testing';
      message.attachments = [FileAttachment(File(pdfPath))];
      var smtpServer = gmail(userEmail, passwordToken);

      await send(message, smtpServer);

      debugPrint('Mail sent successfully');
    } catch (e) {
      debugPrint('The error is ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Send using Smtp mailer'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                // final pdfBytes = await generatePdfData();
                sendingMail();
              },
              child: const Text('Send Mail'),
            ),
          ],
        ),
      ),
    );
  }
}
