import 'package:get/get.dart';
import 'package:dropbox_client/dropbox_client.dart';

class DropBoxController extends GetxController {
  @override
  void onInit() {
    testLogin();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Future initDropbox() async {
  //   // init dropbox client. (call only once!)
  //   await Dropbox.init(dropbox_clientId, dropbox_key, dropbox_secret);
  // }

  Future testLogin() async {
    // this will run Dropbox app if possible, if not it will run authorization using a web browser.
    await Dropbox.authorize();
  }
}
