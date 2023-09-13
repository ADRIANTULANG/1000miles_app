import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../api/product_variants_and_details_screen_api.dart';
import '../model/product_Details_model.dart';
import '../model/variant_details_model.dart';

class ProductVariantsAndDetailsController extends GetxController {
  RxBool isLoading = true.obs;

  RxString productId = "".obs;
  RxString productName = "".obs;
  RxString productDescription = "".obs;
  RxString variantName = "".obs;

  RxString incotermsName = "".obs;
  RxString incotermsPlace = "".obs;
  RxString incotermsLength = "".obs;
  RxString incotermsWidth = "".obs;
  RxString incotermsHeight = "".obs;
  RxString incotermsMetric = "".obs;
  RxString incotermsQuantity = "".obs;

  RxInt variant_no_indentifier = 1.obs;

  RxBool isShowIncoterms = false.obs;

  CarouselController carouselController = CarouselController();

  AutoScrollController autoscroll_controller = AutoScrollController();
  AutoScrollController autoscroll_controller_vertical_list =
      AutoScrollController();
  RxInt defaultSelectedIndex = 0.obs;

  ProductDetailsModel productDetails = ProductDetailsModel(
      id: 0,
      name: "",
      tags: [],
      description: "",
      dateCreate: DateTime.now(),
      dateWrite: DateTime.now(),
      variants: [],
      file: [],
      place: '',
      length: "",
      width: "",
      height: "",
      quantity: "",
      incoterms: null,
      metric: null);

  VariantDetailsModel variantDetails =
      VariantDetailsModel(id: 0, name: '', cellValues: []);

  RxList<Variant> product_variants_carousel_view = <Variant>[].obs;
  RxList<Variant> product_variants_verticalList_view = <Variant>[].obs;

  RxList<Tags> tagsList = <Tags>[].obs;

  RxList<CellValue> cellList = <CellValue>[].obs;

  @override
  void onInit() async {
    productId.value = await Get.arguments['productId'];
    productName.value = await Get.arguments['productName'];
    await getProductDetailsAndVariants();
    print(productId.value);
    isLoading(false);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getProductDetailsAndVariants() async {
    var result =
        await ProductDetailsAndVariantsApi.getProductVariantsAndDetails(
            productID: productId.value);
    if (result != "Session Expired") {
      productDetails = result;
      productDescription.value = productDetails.description;

      if (productDetails.incoterms != null) {
        incotermsName.value = productDetails.incoterms!.name!;
      }
      incotermsPlace.value = productDetails.place;
      incotermsLength.value = productDetails.length;
      incotermsHeight.value = productDetails.height;
      incotermsWidth.value = productDetails.width;
      if (productDetails.metric != null) {
        incotermsMetric.value = productDetails.metric!.name!;
      }
      incotermsQuantity.value = productDetails.quantity;

      for (var i = 0; i < productDetails.variants.length; i++) {
        if (i == 0) {
          getVariantDetails(
              variantID: productDetails.variants[i].id.toString());
        }
        Variant data = Variant(
            id: productDetails.variants[i].id,
            name: productDetails.variants[i].name,
            cellValues: productDetails.variants[i].cellValues,
            active: productDetails.variants[i].active,
            dateCreate: productDetails.variants[i].dateCreate,
            dateWrite: productDetails.variants[i].dateWrite,
            isSelected: i == 0 ? true.obs : false.obs,
            isAddNew: false.obs,
            file: productDetails.variants[i].file);
        product_variants_carousel_view.add(data);
        product_variants_verticalList_view.add(data);
      }

      Variant data = Variant(
          id: 0,
          name: "",
          cellValues: [],
          active: false,
          dateCreate: DateTime.now(),
          dateWrite: DateTime.now(),
          isSelected: false.obs,
          isAddNew: true.obs,
          file: []);
      product_variants_verticalList_view.add(data);

      for (var i = 0; i < productDetails.tags.length; i++) {
        Tags data = Tags(
          id: productDetails.tags[i].id,
          name: productDetails.tags[i].name,
        );

        tagsList.add(data);
      }
    }
  }

  getVariantDetails({required String variantID}) async {
    var result = await ProductDetailsAndVariantsApi.getVariantDetails(
        variantID: variantID);
    if (result != "Session Expired") {
      variantDetails = result;
      if (variantDetails.name != null) {
        variantName.value = variantDetails.name!;
      }
      cellList.clear();
      for (var i = 0; i < variantDetails.cellValues.length; i++) {
        CellValue data = CellValue(
            id: variantDetails.cellValues[i].id,
            variantRow: variantDetails.cellValues[i].variantRow,
            value: variantDetails.cellValues[i].value,
            createdBy: variantDetails.cellValues[i].createdBy,
            active: variantDetails.cellValues[i].active,
            dateCreate: variantDetails.cellValues[i].dateCreate,
            dateWrite: variantDetails.cellValues[i].dateWrite);
        cellList.add(data);
      }
    }
  }

  getMainUrl({required List<FileElement> fileList}) {
    String mainUrl = "";
    for (var i = 0; i < fileList.length; i++) {
      if (fileList[i].main == true) {
        mainUrl = fileList[i].file;
      }
    }
    return mainUrl;
  }

  changeImageBorder({required int index, required int id}) async {
    getVariantDetails(variantID: id.toString());
    for (var i = 0; i < product_variants_verticalList_view.length; i++) {
      if (product_variants_verticalList_view[i].isAddNew == false) {
        if (id == product_variants_verticalList_view[i].id) {
          product_variants_verticalList_view[i].isSelected.value = true;
        } else {
          product_variants_verticalList_view[i].isSelected.value = false;
        }
      }
    }
  }
}
