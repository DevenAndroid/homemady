import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/category_model.dart';
import '../model/filter_model.dart';
import '../repository/category_repo.dart';
import '../repository/filter_repo.dart';

class FilterController extends GetxController {
  bool isDataLoading = false;
  Rx<FilterModel> filterModel = FilterModel().obs;
  RxString sendDate = "".obs;
  RxString availableOption=''.obs;
 final storeSearchController=TextEditingController();

  Future getFilterData() async {
    isDataLoading = false;
      await filterDataRepo(pickDate: sendDate.value, availableNow: availableOption.value, keyword:storeSearchController.text ).then((value) {
        isDataLoading = true;
        filterModel.value = value;
      });
  }
}
