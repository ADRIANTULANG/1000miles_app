import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:image_picker/image_picker.dart';
import '../model/select_photo_for_product_model.dart';

class SelectProductPhotoController extends GetxController {
  RxList<PicturesProductModel> image = <PicturesProductModel>[].obs;
  RxList<PicturesProductModel> imageNew = <PicturesProductModel>[].obs;

  final picker = ImagePicker();

  RxList<PicturesProductModel> selected_images = <PicturesProductModel>[].obs;
  RxList<PicturesProductModel> storageImages = <PicturesProductModel>[].obs;

  // ScrollController scrollController = ScrollController();
  RxDouble scrollPosition = 0.0.obs;

  AutoScrollController autoscroll_controller = AutoScrollController();

  List<CameraDescription> cameras = [];
  CameraController? cameraController;
  RxBool isLoading = true.obs;

  final player = AudioPlayer();

  RxBool isFromHomescreen = false.obs;
  RxString projectID = "".obs;
  RxString projectName = "".obs;
  RxString groupID = "".obs;

  RxBool onTapCamera = false.obs;

  RxBool isFlashOn = false.obs;

  @override
  void onInit() async {
    // await newGallery();

    isFromHomescreen.value = await Get.arguments['isFromHomescreen'];
    projectID.value = await Get.arguments['projectID'];
    projectName.value = await Get.arguments['projectName'];
    groupID.value = await Get.arguments['groupID'];

    print("FROM HOME SCREEN ? ${isFromHomescreen.value}");
    print("POJECT ID ? ${projectID.value}");
    print("PROJECT NAME ? ${projectName.value}");
    print("GROUP ID ? ${groupID.value}");

    cameras = await availableCameras();
    cameraController = await CameraController(cameras[0], ResolutionPreset.max);
    try {
      await cameraController!.initialize();
    } on Exception catch (e) {
      print(e);
    }
    cameraController!.setFlashMode(FlashMode.off);

    isLoading(false);
    autoscroll_controller.addListener(() {
      scrollPosition.value = autoscroll_controller.position.pixels;
      print(scrollPosition.value);
    });

    super.onInit();
  }

  @override
  void onClose() async {
    await cameraController!.setFlashMode(FlashMode.off);

    cameraController!.dispose();
    super.onClose();
  }

  newGallery() async {
    imageNew.clear();
    image.clear();
    try {
      // StorageImages? storageImages = await GalleryImages.getStorageImages();
      // final stores = storageImages!.images!.map((e) => e.imagePath).toSet();
      // storageImages.images!.retainWhere((x) => stores.remove(x.imagePath));

      for (var i = 0; i < storageImages.length; i++) {
        PicturesProductModel map = PicturesProductModel(
          path: storageImages[i].path,
          isFirst: storageImages[i].isFirst,
          isLast: storageImages[i].isLast,
          isSelected: storageImages[i].isSelected,
        );

        imageNew.add(map);
      }

      PicturesProductModel mapnew = await PicturesProductModel(
          path: "", isFirst: true, isLast: false, isSelected: false.obs);

      imageNew.add(mapnew);

      image.assignAll(imageNew.reversed.toList());

      PicturesProductModel map = PicturesProductModel(
          path: "", isFirst: false, isLast: true, isSelected: false.obs);
      image.add(map);
      print("NEW length " + image.length.toString());
    } catch (error) {
      print(error.toString());
    }
  }

  addImage({required PicturesProductModel imageSelected}) async {
    if (selected_images.length != 5) {
      print("age dre");
      selected_images.add(imageSelected);
    } else {
      print("age sa else");
      for (var i = 0; i < image.length; i++) {
        if (selected_images[0].path == image[i].path) {
          image[i].isSelected.value = false;
        }
      }
      await selected_images.removeAt(0);
      selected_images.add(imageSelected);
    }
  }

  removeImage({required PicturesProductModel imageToRemove}) async {
    for (var i = 0; i < image.length; i++) {
      if (imageToRemove.path == image[i].path) {
        image[i].isSelected.value = false;
      }
    }
    selected_images
        .removeWhere((element) => element.path == imageToRemove.path);

    print(selected_images.length);
  }

  scrollToItem() async {
    autoscroll_controller.scrollToIndex(40,
        duration: Duration(seconds: 1),
        preferPosition: AutoScrollPosition.begin);
    print("scrolling");
  }

  // getPictureInGallery() async {
  //   XFile? pickimage = await picker.pickImage(source: ImageSource.gallery);

  //   if (pickimage != null) {
  //     for (var i = 0; i < image.length; i++) {
  //       if (image[i].path == pickimage.path) {
  //         print("from image: ${image[i].path}");
  //         print("from image pciker${pickimage.path}");
  //       }
  //     }
  //   }
  // }

  getPicktureInGallery() async {
    final List<XFile>? pickimage = await picker.pickMultiImage();
    if (pickimage != null) {
      for (var i = 0; i < pickimage.length; i++) {
        PicturesProductModel map = PicturesProductModel(
          path: pickimage[i].path,
          isFirst: false,
          isLast: false,
          isSelected: false.obs,
        );

        storageImages.add(map);
      }
    }
  }
}
