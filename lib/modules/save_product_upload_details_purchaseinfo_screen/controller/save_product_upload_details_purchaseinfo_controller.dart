import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../preview_selected_products_images_screen/controller/preview_selected_product_images_controller.dart';
import '../../project_products_gallery/controller/project_products_gallery_controller.dart';
import '../../project_products_gallery/view/project_products_gallery_view.dart';
import '../../project_screen/controller/projects_controller.dart';
import '../../select_photo_for_product_screen/controller/select_photo_for_product_controller.dart';
import '../../select_photo_for_product_screen/model/select_photo_for_product_model.dart';
import '../api/save_product_upload_details_purchaseinfo_api.dart';
import '../model/products_projects_and_group.dart';
import '../widget/product_details_widget.dart';
import '../widget/purchase_info_widget.dart';
import '../widget/upload_product_widget.dart';

class ProductUploadDetailsPurchaseInfoController extends GetxController {
  CarouselController carouselController = CarouselController();
  RxInt carouselIndex = 0.obs;
  RxInt initialIndex = 0.obs;

  ScrollController scrollController = ScrollController();
  RxDouble scrollPosition = 0.0.obs;

  RxList<Widget> views =
      [UploadProductWidget(), ProductDetailsWidget(), PurchaseInfoWidget()].obs;

  RxList<PicturesProductModel> final_selected_images =
      <PicturesProductModel>[].obs;

  RxList<ProjectGroupAndProducts> projects_and_groups_list =
      <ProjectGroupAndProducts>[].obs;

  RxBool isFromHomescreen = false.obs;
  RxString projectID = "".obs;
  RxString projectName = "".obs;
  RxString groupID = "".obs;

  RxBool isCreateToNewProject = false.obs;

  TextEditingController product_name = TextEditingController();
  TextEditingController product_category = TextEditingController();
  TextEditingController product_description = TextEditingController();
  TextEditingController product_purchase_price = TextEditingController();
  TextEditingController product_minimum_order_quantiy = TextEditingController();
  RxString product_currency_value = "".obs;
  RxString product_supplier_value = "".obs;

  RxBool isCreatingProducts = false.obs;

  @override
  void onInit() async {
    isFromHomescreen.value = await Get.arguments['isFromHomescreen'];
    projectID.value = await Get.arguments['projectID'];
    projectName.value = await Get.arguments['projectName'];
    groupID.value = await Get.arguments['groupID'];
    if (isFromHomescreen.value == false) {
      carouselIndex.value = 1;
      initialIndex.value = 1;
      carouselController.jumpToPage(1);
    }
    print("GROUP ID: ${groupID.value}");
    print("FROM HOME SCREEN? ${isFromHomescreen.value}");
    print("PROJECT ID: ${projectID.value}");
    print("PROJECT NAME: ${projectName.value}");

    for (var i = 0;
        i < Get.find<SelectProductPhotoController>().selected_images.length;
        i++) {
      if (Get.find<SelectProductPhotoController>()
              .selected_images[i]
              .isSelected
              .value ==
          true) {
        final_selected_images
            .add(Get.find<SelectProductPhotoController>().selected_images[i]);
      }
    }

    scrollController.addListener(() {
      scrollPosition.value = scrollController.position.pixels;
      print(scrollPosition.value);
    });

    print(carouselIndex.value);
    getProjectsAndGroups();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getProjectsAndGroups() async {
    var result = await ProductsProjectsAndGroups.getProjectsAndGroup();
    if (result == "Session Expired") {
    } else {
      projects_and_groups_list.assignAll(result);
      for (var i = 0; i < projects_and_groups_list.length; i++) {
        for (var x = 0; x < projects_and_groups_list[i].groups.length; x++) {
          projects_and_groups_list[i]
              .groups
              .removeWhere((element) => element.isGroup == false);
        }
      }
    }
  }

  checkSelectedProjectAndUncheckUnselected({required int id}) {
    for (var i = 0; i < projects_and_groups_list.length; i++) {
      if (id == projects_and_groups_list[i].id) {
        projects_and_groups_list[i].isSelected.value = true;
      } else {
        projects_and_groups_list[i].isSelected.value = false;
      }
      for (var x = 0; x < projects_and_groups_list[i].groups.length; x++) {
        projects_and_groups_list[i].groups[x].isSelected.value = false;
      }
    }
  }

  uncheckAll() {
    for (var i = 0; i < projects_and_groups_list.length; i++) {
      projects_and_groups_list[i].isSelected.value = false;
      for (var x = 0; x < projects_and_groups_list[i].groups.length; x++) {
        projects_and_groups_list[i].groups[x].isSelected.value = false;
      }
    }
  }

  createProduct() async {
    isCreatingProducts(true);
    var result = await ProductsProjectsAndGroups.createProductWithUploadImage(
        productname: product_name.text,
        productdescription: product_description.text,
        productcategory: product_category.text,
        listfile: final_selected_images,
        projectid: projectID.value,
        groupid: groupID.value,
        incoterms: "",
        height: "",
        length: "",
        width: "",
        metric: "",
        place: "",
        quantity: product_minimum_order_quantiy.text);

    if (result == false) {
    } else {
      if (isFromHomescreen.value == false) {
        Get.back();
        Get.back();
        Get.back();
        if (Get.isRegistered<PreviewSelectedProductImage>() == true) {
          Get.back();
        }
        if (Get.isRegistered<ProjectProductsGalleryController>() == true) {
          await Get.find<ProjectProductsGalleryController>()
              .getProductsAndGroups();
          Get.find<ProjectProductsGalleryController>().getUngroupedProducts();
          Get.find<ProjectsScreenController>().getProjectsAll();
        }
      } else if (isFromHomescreen.value == true) {
        Get.back();
        Get.back();
        Get.back();
        if (Get.isRegistered<PreviewSelectedProductImage>() == true) {
          Get.back();
        }
        Get.to(() => ProjectProductsGalleryView(), arguments: {
          "projectID": result[0].toString(),
          "projectName": result[1].toString()
        });
        if (Get.isRegistered<ProjectProductsGalleryController>() == true) {
          Get.find<ProjectProductsGalleryController>().getUngroupedProducts();
          Get.find<ProjectsScreenController>().getProjectsAll();
        }
      }
    }
    isCreatingProducts(false);
  }
}
