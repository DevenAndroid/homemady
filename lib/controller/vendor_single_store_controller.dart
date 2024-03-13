

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


  Future getData(latitude,longitude) async {
    isDataLoading.value = false;
    await singleStoreData(id: storeId, filterId: filterId.value, latitude: latitude, longitude: longitude).then((value1) {
      isDataLoading.value = true;
      model.value = value1;
    });
    //loginRepo().
  }

  Future getStoreKeywordListData() async {
    isDataLoading.value = false;
    await storeKeywordListData().then((value1) {
      isDataLoading.value = true;
      storeKeywordModel.value = value1;
    });
    //loginRepo().
  }





}