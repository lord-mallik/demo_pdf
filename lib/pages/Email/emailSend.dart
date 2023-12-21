import 'dart:convert';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class emailSend extends StatelessWidget {
  emailSend({super.key});

  Future sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
    // required Uint8List pdfBytes,
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
            'user_name': name,
            'user_email': email,
            'to_email': 'lordnikhil11@gmail.com',
            'user_subject': subject,
            'user_message': message,
            // 'pdf_bytes': base64Encode(pdfBytes),
          },
        }));
    debugPrint(response.body);
  }
  Future<Uint8List> generatePdfData() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Hello World!'),
        ),
      ),
    );
    return pdf.save();
  }
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userSubject = TextEditingController();
  TextEditingController userMessage = TextEditingController();

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
                // pdfBytes: pdfBytes,
              );
            },
            child: const Text('Send Mail'),
          ),
        ],
      ),
    );
  }
}


