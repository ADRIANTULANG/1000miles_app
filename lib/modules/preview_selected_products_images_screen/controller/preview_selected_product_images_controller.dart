import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../select_photo_for_product_screen/controller/select_photo_for_product_controller.dart';
import '../../select_photo_for_product_screen/model/select_photo_for_product_model.dart';

class PreviewSelectedProductImage extends GetxController {
  CarouselController carouselController = CarouselController();

  RxInt selectedImageIndex = 1.obs;

  RxBool isSelectedImage = true.obs;

  RxBool isFromHomescreen = false.obs;
  RxString projectID = "".obs;
  RxString projectName = "".obs;
  RxString groupID = "".obs;

  @override
  void onInit() async {
    isFromHomescreen.value = await Get.arguments['isFromHomescreen'];
    projectID.value = await Get.arguments['projectID'];
    projectName.value = await Get.arguments['projectName'];
    groupID.value = await Get.arguments['groupID'];

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  setSelectedImage() async {
    if (Get.find<SelectProductPhotoController>().selected_images.length != 0) {
      isSelectedImage.value = Get.find<SelectProductPhotoController>()
          .selected_images[0]
          .isSelected
          .value;
    }
  }

  setImageSelectedtoFalse({required PicturesProductModel imageModel}) {
    for (var i = 0;
        i < Get.find<SelectProductPhotoController>().image.length;
        i++) {
      if (imageModel.path ==
          Get.find<SelectProductPhotoController>().image[i].path) {
        Get.find<SelectProductPhotoController>().image[i].isSelected.value =
            false;
      }
    }
  }

  setImageSelectedtoTrue({required PicturesProductModel imageModel}) {
    for (var i = 0;
        i < Get.find<SelectProductPhotoController>().image.length;
        i++) {
      if (imageModel.path ==
          Get.find<SelectProductPhotoController>().image[i].path) {
        Get.find<SelectProductPhotoController>().image[i].isSelected.value =
            true;
      }
    }
  }
}
