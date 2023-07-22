import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/search_store_model.dart';
import '../repository/search_store_repo.dart';

class SearchStoreController extends GetxController {
  RxBool isDataLoading = false.obs;
  RxBool loading = false.obs;
  RxInt pagination = 20.obs;
  RxInt page = 1.obs;
  Rx<SearchStoreModel> searchDataModel = SearchStoreModel().obs;
  final searchController1 = TextEditingController();
  RxString name = ''.obs;
/*
  @override
  void onInit() {
    super.onInit();
    getData();
  }*/


 /* Future<HomeSearchModel> getSearchData1() async {
    isDataLoading1.value = false;
    return await homeSearchRepo(keyword: searchController.text.trim(),pagination: pagination.value ,page: page.value ).then((value) {
      isDataLoading1.value = true;
      searchDataModel.value = value;
      return value;
    });
  }*/

  getSearchData() async {
    isDataLoading.value = false;
    await searchStoreRepo(keyword: searchController1.text.trim(),pagination: pagination.value ,page: page.value ).then((value) {
      isDataLoading.value = true;
      searchDataModel.value = value;
      loading.value = false;
      //  loadMore.value = value.link!.next ?? false;
      searchDataModel.value.data!.addAll(value.data!);
      searchDataModel.value.data!.clear();
    }
    );
  }
}
