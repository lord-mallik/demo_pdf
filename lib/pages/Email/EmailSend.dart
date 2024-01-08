//This code is for sending mail using EmailJS.

import 'dart:convert';
/*import 'dart:html' as html;
import 'dart:io';*/

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;

import '../../Helper/GoogleDrive.dart';

class EmailSend extends StatelessWidget {
  EmailSend({super.key});

  Future sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
    required String pdfLink,
  }) async {
    const serviceId = 'service_xauzxbk';
    const templateId = 'template_7o9vnii';
    const userId = 'hXwV8yvwhIpydJ7Kj';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_name': name, // regard Name
            'user_email': email, // reply to email
            'to_email': 'lordnikhil11@gmail.com', // send to mail
            'user_subject': subject, // mail subject
            'user_message': message, // mail message
            'pdf_links': pdfLink, // pdf link
          },
        }));
    debugPrint(response.body);
  }

  Future<String> generatePdfData() async {
    debugPrint('Init generate pdf');
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Hello World!'),
        ),
      ),
    );
    debugPrint('Saving the pdf file');
    final pdfBytes = await pdf.save();
    final base64Pdf = base64Encode(pdfBytes);
    // Convert base64-encoded string back to Uint8List
    final pdfData = base64Decode(base64Pdf);
    debugPrint('converting the file');
    // Create a Blob from the Uint8List
/*    final blob = html.Blob([pdfData]);

    // Create an Object URL from the Blob
    final url = html.Url.createObjectUrlFromBlob(blob);
    debugPrint('url $url');
    final drive = GoogleDrive();
    debugPrint('init drive');*/

    final driveFile = /*await drive.upload(File(url));*/ "";
    debugPrint('uploading file');
    debugPrint(driveFile);
    return driveFile;
  }

  TextEditingController userName = TextEditingController(text: 'Nikhil');
  TextEditingController userEmail =
      TextEditingController(text: 'nmallik005@gmail.com');
  TextEditingController userSubject = TextEditingController(text: 'Testing');
  TextEditingController userMessage =
      TextEditingController(text: 'Testing pdf link through mail');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Send using EmailJS'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autofocus: false,
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'Enter your name',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              labelStyle: TextStyle(
                fontSize: 17.0,
              ),
              errorStyle: TextStyle(
                color: Colors.red,
                fontSize: 15,
              ),
            ),
            controller: userName,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autofocus: false,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your mail',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              labelStyle: TextStyle(
                fontSize: 17.0,
              ),
              errorStyle: TextStyle(
                color: Colors.red,
                fontSize: 15,
              ),
            ),
            controller: userEmail,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autofocus: false,
            decoration: const InputDecoration(
              labelText: 'Subject',
              hintText: 'Enter your subject',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              labelStyle: TextStyle(
                fontSize: 17.0,
              ),
              errorStyle: TextStyle(
                color: Colors.red,
                fontSize: 15,
              ),
            ),
            controller: userSubject,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autofocus: false,
            decoration: const InputDecoration(
              labelText: 'Message',
              hintText: 'Enter your message',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              labelStyle: TextStyle(
                fontSize: 17.0,
              ),
              errorStyle: TextStyle(
                color: Colors.red,
                fontSize: 15,
              ),
            ),
            controller: userMessage,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              final pdfBytes = await generatePdfData();
              sendEmail(
                name: userName.text,
                email: userEmail.text,
                subject: userSubject.text,
                message: userMessage.text,
                pdfLink: pdfBytes,
              );
            },
            child: const Text('Send Mail'),
          ),
        ],
      ),
    );
  }
}
