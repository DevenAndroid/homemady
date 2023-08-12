import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/filter_product_category_model.dart';
import '../model/search_store_model.dart';
import '../repository/filter_product_category_repo.dart';
import '../repository/search_store_repo.dart';

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

  getFilterCategoryData() async {
    isDataLoading.value = false;
    await filterProductCategoryRepo(distance:Get.arguments[0]).then((value) {
      isDataLoading.value = true;
      filterDataModel.value = value;
     // loading.value = false;
      /*loadMore.value = value.link!.next ?? false;
      filterDataModel.value.data!.addAll(value.data!);
      filterDataModel.value.data!.clear();*/
    }
    );
  }
}
