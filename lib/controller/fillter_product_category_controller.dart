import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/filter_product_category_model.dart';
import '../repository/filter_product_category_repo.dart';

class FilterProductCategoryController extends GetxController {
  RxBool isDataLoading = false.obs;
  RxBool loading = false.obs;
  RxInt pagination = 10.obs;
  RxBool isSustainable=false.obs;
   RxInt page = 1.obs;
  RxString distance = ''.obs;
  RxString quickDelivery = ''.obs;
  Rx<FilterProductCategoryModel> filterDataModel = FilterProductCategoryModel().obs;
  final searchController1 = TextEditingController();
  RxString name = ''.obs;

  String id = "";

  getFilterCategoryData({
    required String distance,
  }) async {
    isDataLoading.value = false;
    if(distance.isEmpty)return;
    await filterProductCategoryRepo(
        distance: distance
    ).then((value) {
      filterDataModel.value = value;
      isDataLoading.value = true;
    }
    );
  }
}
