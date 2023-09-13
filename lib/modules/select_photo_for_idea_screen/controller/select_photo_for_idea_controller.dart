import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:image_picker/image_picker.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../services/storage_services.dart';
import '../model/select_photo_for_idea_model.dart';

class SelectIdeaPhotoController extends GetxController {
  RxList<PicturesIdeaModel> image = <PicturesIdeaModel>[].obs;
  RxList<PicturesIdeaModel> imageNew = <PicturesIdeaModel>[].obs;

  final picker = ImagePicker();
  final player = AudioPlayer();

  RxList<PicturesIdeaModel> selected_images = <PicturesIdeaModel>[].obs;
  RxList<PicturesIdeaModel> storageImages = <PicturesIdeaModel>[].obs;

  // ScrollController scrollController = ScrollController();
  RxDouble scrollPosition = 0.0.obs;

  AutoScrollController autoscroll_controller = AutoScrollController();

  List<CameraDescription> cameras = [];
  CameraController? cameraController;
  RxBool isCameraFlashON = false.obs;
  RxBool isLoading = true.obs;

  RxBool isFromHomescreen = false.obs;
  RxString projectID = "".obs;
  RxString projectName = "".obs;
  RxString groupID = "".obs;
  RxBool isSavetoMyIdeas = false.obs;

  RxBool onTapCamera = false.obs;
  RxBool isForwardCameraPress = false.obs;

  final GlobalKey selectPhotoShowcase = GlobalKey();
  final GlobalKey previewShowcase = GlobalKey();
  final GlobalKey capturePhotoShowcase = GlobalKey();
  final GlobalKey photoLibraryShowcase = GlobalKey();
  @override
  void onInit() async {
    // await newGallery();
    isSavetoMyIdeas.value = await Get.arguments['isSavetoMyIdeas'];
    isFromHomescreen.value = await Get.arguments['isFromHomescreen'];
    projectID.value = await Get.arguments['projectID'];
    projectName.value = await Get.arguments['projectName'];
    groupID.value = await Get.arguments['groupID'];

    // var source = await player.setSource(AssetSource("sounds/camera.mp3"));
    print("IS SAVE TO MY IDEAS: ${isSavetoMyIdeas.value}");
    print("GROUP ID: ${groupID.value}");
    print("FROM HOME SCREEN? ${isFromHomescreen.value}");
    print("PROJECT ID: ${projectID.value}");
    print("PROJECT NAME: ${projectName.value}");

    cameras = await availableCameras();
    cameraController = await CameraController(cameras[0], ResolutionPreset.max,
        enableAudio: false);
    try {
      await cameraController!.initialize();
    } on Exception catch (e) {
      print(e);
    }
    await cameraController!.setFlashMode(FlashMode.off);

    await isLoading(false);
    if (Get.find<StorageServices>().storage.read("showcaseCapturePhoto") ==
        null) {
      Timer(Duration(seconds: 2), () {
        ShowCaseWidget.of(Get.context!)
            .startShowCase([capturePhotoShowcase, photoLibraryShowcase]);
      });
      Get.find<StorageServices>().showcaseCapturePhoto(isDone: "done");
    }

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

  setShowcaseSelectPhotos() {
    if (Get.find<StorageServices>().storage.read("showcaseStateSelectPhoto") ==
        null) {
      Timer(Duration(seconds: 1), () {
        ShowCaseWidget.of(Get.context!)
            .startShowCase([selectPhotoShowcase, previewShowcase]);
      });
      Get.find<StorageServices>().showcaseStateSelectPhoto(isDone: "done");
    }
  }

  newGallery() async {
    imageNew.clear();
    image.clear();
    try {
      // StorageImages? storageImages = await GalleryImages.getStorageImages();
      // final stores = storageImages!.images!.map((e) => e.imagePath).toSet();
      // storageImages.images!.retainWhere((x) => stores.remove(x.imagePath));

      for (var i = 0; i < storageImages.length; i++) {
        PicturesIdeaModel map = PicturesIdeaModel(
          path: storageImages[i].path,
          isFirst: storageImages[i].isFirst,
          isLast: storageImages[i].isLast,
          isSelected: storageImages[i].isSelected,
        );

        imageNew.add(map);
      }

      // PicturesIdeaModel mapnew = await PicturesIdeaModel(
      //     path: "", isFirst: true, isLast: false, isSelected: false.obs);

      // imageNew.add(mapnew);

      image.assignAll(imageNew.reversed.toList());

      PicturesIdeaModel map = PicturesIdeaModel(
          path: "", isFirst: false, isLast: true, isSelected: false.obs);
      image.add(map);
      print("NEW length " + image.length.toString());
    } catch (error) {
      print(error.toString());
    }
  }

  addImage({required PicturesIdeaModel imageSelected}) async {
    // if (selected_images.length != 5) {
    print("age dre");
    selected_images.add(imageSelected);
    // } else {
    //   print("age sa else");
    //   for (var i = 0; i < image.length; i++) {
    //     if (selected_images[0].path == image[i].path) {
    //       image[i].isSelected.value = false;
    //     }
    //   }
    //   await selected_images.removeAt(0);
    //   selected_images.add(imageSelected);
    // }
  }

  removeImage({required PicturesIdeaModel imageToRemove}) async {
    for (var i = 0; i < image.length; i++) {
      if (imageToRemove.path == image[i].path) {
        image[i].isSelected.value = false;
      }
    }
    selected_images
        .removeWhere((element) => element.path == imageToRemove.path);
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
        File file = await File(pickimage[i].path);

        int quality = 70;
        int percentage = 70;
        final bytes = file.readAsBytesSync().lengthInBytes;
        final kb = bytes / 1024;

        if (kb > 900) {
          quality = 30;
          percentage = 30;
        } else if (kb < 900 && kb > 300) {
          quality = 50;
          percentage = 50;
        }

        print(quality.toString() + "  " + percentage.toString());

        File compressedFile = await FlutterNativeImage.compressImage(file.path,
            quality: quality, percentage: percentage);

        final kbnew = compressedFile.readAsBytesSync().lengthInBytes / 1024;
        print("image size is $kbnew KB");

        PicturesIdeaModel map = PicturesIdeaModel(
          path: compressedFile.path,
          isFirst: false,
          isLast: false,
          isSelected: false.obs,
        );
        storageImages.add(map);
      }
    }
  }

  getPictureInGalleryInSelectphotoScreen() async {
    final List<XFile>? pickimage = await picker.pickMultiImage();
    if (pickimage != null) {
      for (var i = 0; i < pickimage.length; i++) {
        PicturesIdeaModel map = PicturesIdeaModel(
          path: pickimage[i].path,
          isFirst: false,
          isLast: false,
          isSelected: false.obs,
        );
        storageImages.add(map);
        image.insert(1, map);
      }
    }
  }
}
