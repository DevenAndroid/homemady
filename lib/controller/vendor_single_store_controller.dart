

import 'package:get/get.dart';

import '../model/storebykeyword_model.dart';
import '../model/vendor_store_single_model.dart';
import '../repository/store_byKeyword_repo.dart';
import '../repository/vendor_store_single_repo.dart';

class VendorSingleStoreController extends GetxController{

  Rx<VendorStoreSingleModel> model = VendorStoreSingleModel().obs;
  Rx<StorebyKeywords> storeKeywordModel = StorebyKeywords().obs;
  RxBool isDataLoading = false.obs;
  RxString vendorStoreId = ''.obs;
  RxString filterId = '2'.obs;
  String storeId = "";


  getData(){
    isDataLoading.value = false;
    singleStoreData(id: storeId, filterId: filterId.value, ).then((value1) {
      isDataLoading.value = true;
      model.value = value1;
    });
    //loginRepo().
  }

  getStoreKeywordListData(){
    isDataLoading.value = false;
    storeKeywordListData().then((value1) {
      isDataLoading.value = true;
      storeKeywordModel.value = value1;
    });
    //loginRepo().
  }





}