import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/project_products_gallery_api.dart';
import '../model/UngroupedProducts_model.dart';
import '../model/final_product_gallery_model.dart';
import '../model/groupedproducts_model.dart';
import '../model/temporary_product_gallery_model.dart';

class ProjectProductsGalleryController extends GetxController {
  RxString projectID = "".obs;
  RxString projectName = "".obs;
  RxList<TemporaryProductGalleryModel> temporaryList =
      <TemporaryProductGalleryModel>[].obs;
  RxList<FinalProductGalleryModel> productsAndGroupsList =
      <FinalProductGalleryModel>[].obs;
  RxList<FinalProductGalleryModel> productsAndGroupsList_masterList =
      <FinalProductGalleryModel>[].obs;

  RxList<UngroupedProductsModel> ungrouped_products =
      <UngroupedProductsModel>[].obs;

  RxList<GroupedProductsModel> grouped_products = <GroupedProductsModel>[].obs;

  ScrollController scrollController = ScrollController();
  RxDouble scrollPosition = 0.0.obs;

  ScrollController group_scrollController = ScrollController();
  RxDouble group_scrollPosition = 0.0.obs;

  RxBool isLoading = true.obs;

  RxBool isGroupsOnly = false.obs;
  RxBool isRecentlyAdded = false.obs;

  @override
  void onInit() async {
    projectID.value = await Get.arguments['projectID'];
    projectName.value = await Get.arguments['projectName'];
    await getProductsAndGroups();
    scrollController.addListener(() {
      scrollPosition.value = scrollController.position.pixels;
    });
    group_scrollController.addListener(() {
      group_scrollPosition.value = group_scrollController.position.pixels;
    });
    getUngroupedProducts();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getProductsAndGroups() async {
    var result = await ProjectsProductApi.getProjects_ProductsAndGroups(
        projectID: projectID.value);
    if (result != "Session Expired") {
      RxList<FinalProductGalleryModel> listPlaceHolder =
          <FinalProductGalleryModel>[].obs;
      temporaryList.assignAll(result);

      for (var i = 0; i < temporaryList.length; i++) {
        if (temporaryList[i].isGroup == true) {
          FinalProductGalleryModel data = FinalProductGalleryModel(
              productIDorGroupedID: temporaryList[i].id,
              dateCreate: temporaryList[i].dateCreate,
              productOrGroupName: temporaryList[i].name,
              isGroup: true,
              productImage: "",
              noOfVariantsOrProducts: temporaryList[i].products.length);

          listPlaceHolder.add(data);
        } else {
          for (var x = 0; x < temporaryList[i].products.length; x++) {
            FinalProductGalleryModel data = FinalProductGalleryModel(
                productIDorGroupedID: temporaryList[i].products[x].id,
                dateCreate: temporaryList[i].products[x].dateCreate,
                productOrGroupName: temporaryList[i].products[x].name,
                isGroup: false,
                productImage:
                    await imageMainUrl(list: temporaryList[i].products[x].file),
                noOfVariantsOrProducts:
                    temporaryList[i].products[x].variants.length);

            listPlaceHolder.add(data);
          }
        }
      }
      productsAndGroupsList.assignAll(listPlaceHolder.reversed.toList());
      productsAndGroupsList_masterList
          .assignAll(listPlaceHolder.reversed.toList());
    }
    isLoading(false);
  }

  Future<String> imageMainUrl({required List<FileElement> list}) async {
    String imageUrl = "";
    for (var i = 0; i < list.length; i++) {
      if (list[i].main == true) {
        imageUrl = list[i].file;
      }
    }
    // print(AppEndpoint.endPointDomain + "/" + imageUrl);
    return imageUrl;
  }

  groupsOnly({required bool isGroup}) async {
    productsAndGroupsList.clear();
    if (isGroup == true) {
      for (var i = 0; i < temporaryList.length; i++) {
        if (temporaryList[i].isGroup == true) {
          FinalProductGalleryModel data = FinalProductGalleryModel(
              productIDorGroupedID: temporaryList[i].id,
              dateCreate: temporaryList[i].dateCreate,
              productOrGroupName: temporaryList[i].name,
              isGroup: true,
              productImage: "",
              noOfVariantsOrProducts: temporaryList[i].products.length);
          productsAndGroupsList.add(data);
        }
      }
    } else {
      productsAndGroupsList.assignAll(productsAndGroupsList_masterList);
    }
  }

  recentlyaddedFirst({required bool isRecentlyAdded}) {
    if (isRecentlyAdded == true) {
      RxList<FinalProductGalleryModel> partialList =
          <FinalProductGalleryModel>[].obs;
      partialList.assignAll(productsAndGroupsList_masterList);
      partialList.sort((a, b) => a.dateCreate.compareTo(b.dateCreate));
      productsAndGroupsList.assignAll(partialList.reversed.toList());
    } else {
      productsAndGroupsList.assignAll(productsAndGroupsList_masterList);
    }
  }

  getUngroupedProducts() async {
    for (var i = 0; i < temporaryList.length; i++) {
      if (temporaryList[i].isGroup == true) {
      } else {
        for (var x = 0; x < temporaryList[i].products.length; x++) {
          UngroupedProductsModel data = UngroupedProductsModel(
              productIDorGroupedID: temporaryList[i].products[x].id,
              isSelected: false.obs,
              dateCreate: temporaryList[i].products[x].dateCreate,
              productOrGroupName: temporaryList[i].products[x].name,
              isGroup: false,
              productImage:
                  await imageMainUrl(list: temporaryList[i].products[x].file),
              noOfVariantsOrProducts:
                  temporaryList[i].products[x].variants.length);
          ungrouped_products.add(data);
        }
      }
    }
  }

  getAllGroupedProducts({required int groupedID}) async {
    grouped_products.clear();
    for (var i = 0; i < temporaryList.length; i++) {
      if (temporaryList[i].isGroup == true &&
          temporaryList[i].id == groupedID) {
        for (var x = 0; x < temporaryList[i].products.length; x++) {
          GroupedProductsModel data = GroupedProductsModel(
              isSelected: false.obs,
              productIDorGroupedID: temporaryList[i].products[x].id,
              dateCreate: temporaryList[i].products[x].dateCreate,
              productOrGroupName: temporaryList[i].products[x].name,
              isGroup: false,
              productImage:
                  await imageMainUrl(list: temporaryList[i].products[x].file),
              noOfVariantsOrProducts:
                  temporaryList[i].products[x].variants.length);
          grouped_products.add(data);
        }
      }
    }
  }
}
