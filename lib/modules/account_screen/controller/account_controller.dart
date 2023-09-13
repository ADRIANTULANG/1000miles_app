import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yoooto/services/storage_services.dart';
import '../../../constant/colors_class.dart';
import '../../login_and_register_screen/view/pre_login_and_register_view.dart';

class AccountScreenScreenController extends GetxController {
  RxDouble scrollPosition = 0.0.obs;
  TextEditingController name = TextEditingController();
  TextEditingController position = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController emailaddress = TextEditingController();
  TextEditingController telephone = TextEditingController();
  TextEditingController country = TextEditingController();
  ScrollController scrollController = ScrollController();

  RxString dropdownValue = "+123".obs;

  RxBool isLoading = true.obs;

  RxString users_name = "".obs;
  RxString users_id = "".obs;
  RxString users_email = "".obs;
  RxString users_phone_number = "".obs;
  RxString users_location = "".obs;
  RxString users_company = "".obs;
  RxString users_position = "".obs;

  RxBool isImageSaveSelected = false.obs;
  RxBool isWhatsAppSelected = false.obs;
  RxBool isEmailSelected = false.obs;

  ScreenshotController screenshotController = ScreenshotController();

  File? fileImage;
  RxString filePath = "".obs;
  Uint8List? imageFile;

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() async {
    isLoading(true);

    name.text = "Ellen Degeneres";
    position.text = "Manager";
    company.text = "HardwareHub.io";
    emailaddress.text = "address@gmail.com";
    country.text = "Philippines";
    telephone.text = "+639167089455";

    users_name.value =
        Get.find<StorageServices>().storage.read('name').toString();
    users_email.value = Get.find<StorageServices>().storage.read('email');
    users_phone_number.value =
        Get.find<StorageServices>().storage.read('phone');
    users_id.value = Get.find<StorageServices>().storage.read('id');
    users_location.value = Get.find<StorageServices>().storage.read('city') +
        " " +
        Get.find<StorageServices>().storage.read('streetAddress1') +
        " " +
        Get.find<StorageServices>().storage.read('streetAddress2');
    users_location.value = Get.find<StorageServices>().storage.read('city');
    users_position.value =
        Get.find<StorageServices>().storage.read('occupation');
    users_company.value = Get.find<StorageServices>().storage.read('company');

    scrollController.addListener(() {
      scrollPosition.value = scrollController.position.pixels;
      print(scrollPosition.value);
    });
    isLoading(false);
    super.onInit();
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'sample@example.com',
      query: encodeQueryParameters(<String, String>{
        'subject': '',
      }),
    );
    launchUrl(emailLaunchUri);
  }

  takeScreenShot() {
    screenshotController.capture().then((Uint8List? image) {
      //Capture Done
      imageFile = image;
      // print(imageFile.toString());
      fileImage = File.fromRawPath(imageFile!);
      filePath.value = fileImage!.path;
      // print(filePath.value);
      saveImageToGallery(dataImage: image!);
    }).catchError((onError) {
      print(onError);
    });
  }

  saveImageToGallery({required Uint8List dataImage}) async {
    final result = await ImageGallerySaver.saveImage(dataImage,
        quality: 60, name: "screenshot${DateTime.now()}.png");
    print(result);
    if (result['isSuccess'] == true) {
      Get.snackbar(
        "Message",
        "Business card image successfuly saved",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  openWhatsapp(
      {required BuildContext context,
      required String text,
      required String number}) async {
    var whatsapp = number; //+92xx enter like this
    var whatsappURlAndroid =
        "whatsapp://send?phone=" + whatsapp + "&text=$text";
    var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(Uri.parse(
          whatsappURLIos,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    }
  }

  logoutUser() async {
    await Get.find<StorageServices>().removeStorageCredentials();
    Get.offAll(() => PreLoginView());
  }
}
