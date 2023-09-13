import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageServices extends GetxController {
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  saveCredentials({
    required String user,
    required String pass,
    required String id,
    required String name,
    required String dateJoined,
    required String email,
    required String company,
    required String occupation,
    required String phone,
    required String mobile,
    required String active,
    required String firstLogin,
    required String streetAddress1,
    required String streetAddress2,
    required String city,
    required String isRegistered,
  }) {
    storage.write("user", user);
    storage.write("pass", pass);
    storage.write("name", name);
    storage.write("id", id);
    storage.write("dateJoined", dateJoined);
    storage.write("email", email);
    storage.write("company", company);
    storage.write("occupation", occupation);
    storage.write("phone", phone);
    storage.write("mobile", mobile);
    storage.write("active", active);
    storage.write("firstLogin", firstLogin);
    storage.write("streetAddress1", streetAddress1);
    storage.write("streetAddress2", streetAddress2);
    storage.write("city", city);
    storage.write("isRegistered", isRegistered);
  }

  removeStorageCredentials() {
    storage.remove("user");
    storage.remove("pass");
    storage.remove("name");
    storage.remove("id");
    storage.remove("dateJoined");
    storage.remove("email");
    storage.remove("company");
    storage.remove("occupation");
    storage.remove("phone");
    storage.remove("mobile");
    storage.remove("active");
    storage.remove("firstLogin");
    storage.remove("streetAddress1");
    storage.remove("streetAddress2");
    storage.remove("city");
    storage.remove("isRegistered");

    storage.remove("expirationDate");
    storage.remove("data");
    storage.remove("myideas");
    storage.remove("shared");
    storage.remove("refreshToken");
    storage.remove("authorization");
  }

  saveExpirationDate({
    required String expirationDate,
  }) {
    storage.write("expirationDate", expirationDate);
  }

  saveLocalDataForCaching({required data}) {
    storage.write("data", data);
  }

  saveLocalDataMyIdeasForCaching({required data}) {
    storage.write("myideas", data);
  }

  saveLocalDataSharedWithMeForCaching({required data}) {
    storage.write("shared", data);
  }

  showcaseStateHomeScreen({required String isDone}) {
    storage.write("showcaseStateHomeScreen", isDone);
  }

  showcaseStateSelectPhoto({required String isDone}) {
    storage.write("showcaseStateSelectPhoto", isDone);
  }

  showcaseCapturePhoto({required String isDone}) {
    storage.write("showcaseCapturePhoto", isDone);
  }

  showcaseProjectSpace({required String isDone}) {
    storage.write("showcaseProjectSpace", isDone);
  }

  showcaseIdeasGallery({required String isDone}) {
    storage.write("showcaseIdeasGallery", isDone);
  }

  saveRefreshToken({required token}) async {
    storage.write("refreshToken", token);
  }

  saveAuthorization({required auth}) async {
    storage.write("authorization", "Bearer " + auth);
  }
}
