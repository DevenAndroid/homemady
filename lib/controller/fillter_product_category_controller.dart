
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

  String filterId = "";

  Future getFilterCategoryData({
    required String filter,
    required String categoryId,
    required BuildContext context
  }) async {
    isDataLoading.value = false;
    if(filter.isEmpty)return;
    filterId = filter;
    await filterProductCategoryRepo(
        filter: filter, context: context,
      product_option_id: categoryId
    ).then((value) {
      filterDataModel.value = value;
      isDataLoading.value = true;
    }
    );
  }
}
