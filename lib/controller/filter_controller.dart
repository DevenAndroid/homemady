import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/filter_model.dart';
import '../repository/filter_repo.dart';

class FilterController extends GetxController {
  bool isDataLoading = false;
  Rx<FilterProductModel> filterModel = FilterProductModel().obs;
  // RxString sendDate = "".obs;
  // RxString availableOption="".obs;
 final storeSearchController=TextEditingController();

 DateTime sendDate = DateTime.now();

  Future getFilterData() async {
    isDataLoading = false;
      await filterDataRepo(pickDate: sendDate, keyword:storeSearchController.text ).then((value) {
        isDataLoading = true;
        filterModel.value = value;
      });
  }
}
