// import 'dart:io';

// import 'package:googleapis/drive/v3.dart' as ga;
// import 'package:googleapis_auth/auth_io.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart' as p;
// import 'package:url_launcher/url_launcher.dart';
// import 'package:yoooto/modules/google_drive_screen/view/googleDrive_secure_storage.dart';

// const clientID =
//     // "673891912192-f4kn9p30uqisikknd96hh9egjirqsmtb.apps.googleusercontent.com";
//     "928797881054-08en0qmh5esurjca9ieugp76nlifp80j.apps.googleusercontent.com";

// const clientSecret = "";

// // const scope = [ga.DriveApi.driveFileScope];
// const scope = [
//   "https://www.googleapis.com/auth/drive",
//   "https://www.googleapis.com/auth/drive.file"
// ];

// class GoogleDrive {
//   //Get authentication
//   final storage = SecureStorage();
//   Future<http.Client> getHttpClient() async {
//     var credentials = await storage.getCredentials();
//     if (credentials.length == 0) {
//       var authClient =
//           await clientViaUserConsent(ClientId(clientID), scope, (url) {
//         launchUrl(Uri.parse(url));
//       });

//       return authClient;
//     } else {
//       return authenticatedClient(
//           http.Client(),
//           AccessCredentials(
//             AccessToken(
//               credentials['type'],
//               credentials['data'],
//               DateTime.parse(credentials['type']),
//             ),
//             credentials['data'],
//             scope,
//           ));
//     }
//   }

//   //Upload files
//   Future upload({required File file}) async {
//     var client = await getHttpClient();
//     var drive = ga.DriveApi(client);

//     var response = await drive.files.create(
//         ga.File()..name = p.basename(file.absolute.path),
//         uploadMedia: ga.Media(file.openRead(), file.lengthSync()));

//     print(response.toJson());
//   }
// }
