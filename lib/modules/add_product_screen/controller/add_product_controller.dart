import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../model/add_product_model.dart';

class AddProductController extends GetxController {
  final ImagePicker picker = ImagePicker();
  RxList<ImageModel> imagesList = <ImageModel>[].obs;
  var pickedColor = Color(0xffFFFFFF);
  RxList<ColorModels> colorList = <ColorModels>[].obs;
  RxString dropdownValue = "USD".obs;
  RxString defaultCategoryValue = "Clothing".obs;
  RxString radioGroupValue = "".obs;

  TextEditingController pasteLinkEditior = TextEditingController();
  RxList<ProductCategoryModel> categoryList = <ProductCategoryModel>[
    ProductCategoryModel(
        categoryIcon: SvgPicture.asset(
          CustomIcons.clothing,
        ),
        categoryName: "Clothing".obs),
    ProductCategoryModel(
        categoryIcon: SvgPicture.asset(
          CustomIcons.accessories,
        ),
        categoryName: "Accessories".obs),
    ProductCategoryModel(
        categoryIcon: SvgPicture.asset(
          CustomIcons.gadgets,
        ),
        categoryName: "Gadgets".obs),
    ProductCategoryModel(
        categoryIcon: SvgPicture.asset(
          CustomIcons.homedecor,
        ),
        categoryName: "Home Decors".obs)
  ].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  addImages_from_gallery() async {
    final List<XFile>? images = await picker.pickMultiImage();
    if (images!.length == 0) {
    } else {
      for (var i = 0; i < images.length; i++) {
        imagesList.add(ImageModel(
            imagePath: images[i].path, imageFile: images[i], isLink: false));
      }
    }
  }

  addImages_camera() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      imagesList.add(
          ImageModel(imagePath: image.path, imageFile: image, isLink: false));
    }
  }

  addImages_from_network({required String urlLink}) async {
    try {
      (await NetworkAssetBundle(Uri.parse(urlLink)).load(urlLink))
          .buffer
          .asUint8List();

      print("The image exists!");
      imagesList.add(ImageModel(imagePath: urlLink, isLink: true));
    } catch (e) {
      Get.snackbar(
        "Message",
        "Please provide link",
        colorText: Colors.white,
        backgroundColor: AppColor.redAccent,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
