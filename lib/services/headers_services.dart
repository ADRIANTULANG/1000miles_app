import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:yoooto/services/storage_services.dart';

class HeadersServices extends GetxController {
  updateCookie(http.Response response) async {
    Map<String, String> headers = {};
    String? rawCookie = response.headers['set-cookie'];
    String? authorization = response.headers['authorization'];

    if (rawCookie != null) {
      print("rawCookie ${rawCookie}");
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);

      List splittedList = rawCookie.split(";");
      print("Session Expiration Date: ${splittedList[3]}");
    }

    if (authorization != null) {
      print("authorization ${authorization}");
      int index = authorization.indexOf(';');
      headers['authorization'] =
          (index == -1) ? authorization : authorization.substring(0, index);
    }

    // log("headers ni: $headers");

    if (headers["cookie"] != null) {
      Get.find<StorageServices>().saveRefreshToken(token: headers["cookie"]);
    }
    if (headers["authorization"] != null) {
      Get.find<StorageServices>()
          .saveAuthorization(auth: headers["authorization"]);
    }
  }

  // updateCookiesNew(http.Response response) {
  //   String? rawCookie = response.headers['set-cookie'];
  //   if (rawCookie != null) {
  //     print(rawCookie);
  //     int index = rawCookie.indexOf(';');
  //     headers['cookie'] =
  //         (index == -1) ? rawCookie : rawCookie.substring(0, index);
  //     print(headers['cookie']);
  //   }
  // }
}
