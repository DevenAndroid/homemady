
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/homepage_model.dart';
import '../model/model_verify_otp.dart';
import '../model/vendor_store_single_model.dart';
import '../repository/homepage_repo.dart';
import '../repository/login_repository.dart';
import '../repository/vendor_store_single_repo.dart';
import '../resources/add_text.dart';

class VendorSingleStoreController extends GetxController{

  Rx<VendorStoreSingleModel> model = VendorStoreSingleModel().obs;
  RxBool isDataLoading = false.obs;
  RxString vendorStoreId = ''.obs;
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
    singleStoreData(id: Get.arguments[0]).then((value1) {
      isDataLoading.value = true;
      model.value = value1;
    });
    //loginRepo().
  }






}