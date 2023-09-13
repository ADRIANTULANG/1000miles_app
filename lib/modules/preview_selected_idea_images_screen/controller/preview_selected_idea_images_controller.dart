import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../select_photo_for_idea_screen/controller/select_photo_for_idea_controller.dart';

class PreviewSelectedIdeaImage extends GetxController {
  CarouselController carouselController = CarouselController();

  RxInt selectedImageIndex = 1.obs;

  RxBool isSelectedImage = true.obs;
  RxBool isSavetoMyIdeas = false.obs;
  RxBool isFromHomescreen = false.obs;
  RxString projectID = "".obs;
  RxString projectName = "".obs;
  RxString groupID = "".obs;

  @override
  void onInit() async {
    isSavetoMyIdeas.value = await Get.arguments['isSavetoMyIdeas'];
    isFromHomescreen.value = await Get.arguments['isFromHomescreen'];
    projectID.value = await Get.arguments['projectID'];
    projectName.value = await Get.arguments['projectName'];
    groupID.value = await Get.arguments['groupID'];
    print("IS SAVE TO MY IDEAS: ${isSavetoMyIdeas.value}");
    print("GROUP ID: ${groupID.value}");
    print("FROM HOME SCREEN? ${isFromHomescreen.value}");
    print("PROJECT ID: ${projectID.value}");
    print("PROJECT NAME: ${projectName.value}");
    setSelectedImagevalue();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  setSelectedImagevalue() async {
    if (Get.find<SelectIdeaPhotoController>().image.length != 0) {
      isSelectedImage.value =
          Get.find<SelectIdeaPhotoController>().image[0].isSelected.value;
    }
  }
}
