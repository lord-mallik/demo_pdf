import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googleapis_auth/auth_io.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();

  //Save Credentials
  Future saveCredentials(AccessToken token, String refreshToken) async {
    debugPrint(token.expiry.toIso8601String());
    await storage.write(key: "type", value: token.type);
    await storage.write(key: "data", value: token.data);
    await storage.write(key: "expiry", value: token.expiry.toString());
    await storage.write(key: "refreshToken", value: refreshToken);
  }

  //Get Saved Credentials
  Future<Map<String, dynamic>?> getCredentials() async {
    var result = await storage.readAll();
    if (result.length == 0) return null;
    return result;
  }
 /* Future<void> setCredentials(String accessToken, String refreshToken) async {
    final file = File('.credentials');
    final data = {
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
    await file.writeAsString(jsonEncode(data));
  }

  Future<Map<String, String>?> getCredentials() async {
    final file = File('.credentials');
    if (await file.exists()) {
      final data = jsonDecode(await file.readAsString());
      return {
        'access_token': data['access_token'],
        'refresh_token': data['refresh_token'],
      };
    } else {
      return null;
    }
  }*/
  //Clear Saved Credentials
  Future clear() {
    return storage.deleteAll();
  }
}