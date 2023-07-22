

import 'dart:developer';

import 'package:get/get.dart';

import '../model/order_details_model.dart';
import '../repository/order_details_repo.dart';

class OrderDetailsController extends GetxController{

  Rx<OrderDetailsModel> model = OrderDetailsModel().obs;
  RxBool isDataLoading = false.obs;
  RxString id = ''.obs;

  getData(){
    isDataLoading.value = false;
    if(Get.arguments != null){
      log(Get.arguments[0].toString());
      orderDetailsRepo(id: Get.arguments[0].toString()).then((value) {
        isDataLoading.value = true;
        model.value = value;
      });
    }

  }

}