/*

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/checkout_order_model.dart';
import '../model/homepage_model.dart';
import '../model/model_verify_otp.dart';
import '../repository/checkout_order_repo.dart';
import '../repository/homepage_repo.dart';
import '../repository/login_repository.dart';

class CheckOutController extends GetxController{

  Rx<CheckoutOrderModel> model = CheckoutOrderModel().obs;
  RxBool isDataLoading = false.obs;
  RxString context = ''.obs;
  getData(){
    isDataLoading.value = false;
    checkOut().then((value1) {
      isDataLoading.value = true;
      model.value = value1;
    });
    //loginRepo().
  }






}
*/
