// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:googleapis_auth/auth_io.dart';

// class SecureStorage {
//   final storage = FlutterSecureStorage();

//   Future saveCredentials(
//       {required AccessToken token, required String refreshToken}) async {
//     await storage.write(key: "type", value: token.type);
//     await storage.write(key: "data", value: token.data);
//     await storage.write(key: "expiry", value: token.expiry.toIso8601String());
//     await storage.write(key: "refreshToken", value: refreshToken);
//   }

//   Future<Map<String, dynamic>> getCredentials() async {
//     var result = await storage.readAll();

//     return result;
//   }

//   Future clear() async {
//     storage.deleteAll();
//   }
// }
