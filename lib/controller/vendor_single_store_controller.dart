
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/homepage_model.dart';
import '../model/model_verify_otp.dart';
import '../model/storebykeyword_model.dart';
import '../model/vendor_store_single_model.dart';
import '../repository/homepage_repo.dart';
import '../repository/login_repository.dart';
import '../repository/store_byKeyword_repo.dart';
import '../repository/vendor_store_single_repo.dart';
import '../resources/add_text.dart';

class VendorSingleStoreController extends GetxController{

  Rx<VendorStoreSingleModel> model = VendorStoreSingleModel().obs;
  Rx<StorebyKeywords> storeKeywordModel = StorebyKeywords().obs;
  RxBool isDataLoading = false.obs;
  RxString vendorStoreId = ''.obs;
  RxString storeKeyword = '4'.obs;
  // RxInt counter= 0.obs;

  // increaseQty(){
  //   counter=counter++;
  // }
  // decreaseQty(){
  //   if(counter.value>=1){
  //     counter=counter--;
  //   }
  //   else{
  //     showToast("Qty should be 1");
  //   }


  // }

  getData(){
    isDataLoading.value = false;
    singleStoreData(id: Get.arguments[0], keyword:storeKeyword.value ).then((value1) {
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