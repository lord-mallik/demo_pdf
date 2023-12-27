import 'dart:io';

import 'package:googleapis/drive/v3.dart' as ga;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:url_launcher/url_launcher.dart';

import 'SecureStorage.dart';
//Error: Expected a value of type 'File', but got one of type 'NativeUint8List'

/*const _clientId =
    "188721097392-89s2mck3u67lavm7e2aebep4gkgtgceb.apps.googleusercontent.com";
const _clientSecret = "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";
// var _scopes = ['https://www.googleapis.com/auth/drive'];

const _scopes = [ga.DriveApi.driveFileScope];*/

class GoogleDrive {
  final storage = SecureStorage();
  final _clientId =
      "188721097392-89s2mck3u67lavm7e2aebep4gkgtgceb.apps.googleusercontent.com";
  final _clientSecret = "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";
// var _scopes = ['https://www.googleapis.com/auth/drive'];

  final _scopes = [ga.DriveApi.driveFileScope];
  //Get Authenticated Http Client
  Future<http.Client> getHttpClient() async {
    //Get Credentials
    var credentials = await storage.getCredentials();
    if (credentials == null) {
      //Needs user authentication
      var authClient = await clientViaUserConsent(
          ClientId(_clientId, _clientSecret), _scopes, (url) {
        //Open Url in Browser
        launch(url);
      });
      //Save Credentials
      await storage.saveCredentials(authClient.credentials.accessToken,
          authClient.credentials.refreshToken!);
      return authClient;
    } else {
      print(credentials["expiry"]);
      //Already authenticated
      return authenticatedClient(
          http.Client(),
          AccessCredentials(
              AccessToken(credentials["type"], credentials["data"],
                  DateTime.tryParse(credentials["expiry"])!),
              credentials["refreshToken"],
              _scopes));
    }
  }

  //Upload File
  Future upload(File file) async {
    var client = await getHttpClient();
    var drive = ga.DriveApi(client);
    print("Uploading file");
    var response = await drive.files.create(
        ga.File()..name = p.basename(file.path),
        uploadMedia: ga.Media(file.openRead(), file.lengthSync()));

    print("Result ${response.toJson()}");

  }
}

/*import 'dart:convert';
import 'dart:html';
import 'package:googleapis/drive/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
String GOOGLE_APPLICATION_CREDENTIALS="assets/jsonFile/flutterdrive-409305-b172c2efc322.json";
class GoogleDrive {
  final String accessToken;

  GoogleDrive({required this.accessToken});

  Future<String> upload({
    required String filePath,
    required String folderId,
    required String fileName,
  }) async {

    final clientId = ClientId("_clientId", "_clientSecret");
    final scopes = [DriveApi.driveScope];

    final httpClient =
        await clientViaApplicationDefaultCredentials(scopes: scopes);
    final driveApi = DriveApi(httpClient);

    final file = await File(filePath).readAsBytes();
    final metadata = File()
      ..name = fileName
      ..parents = [folderId];

    final driveFile = await driveApi.files.create(
      metadata,
      Stream.fromIterable([file]),
      uploadMedia: UploadMedia(
        metadata,
        Stream.fromIterable([file]),
        mediaType: 'multipart/related; boundary="myBoundary"',
      ),
    );

    return driveFile.webViewLink ?? '';
  }
  }*/
