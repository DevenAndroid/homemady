

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/order_details_model.dart';
import '../repository/order_details_repo.dart';

class OrderDetailsController extends GetxController{

  Rx<OrderDetailsModel> model = OrderDetailsModel().obs;
  RxBool isDataLoading = false.obs;
  // RxString id = ''.obs;
  final TextEditingController feedbackController= TextEditingController();

  getData(String orderId){
    isDataLoading.value = false;
      log(orderId);
      orderDetailsRepo(id: orderId).then((value) {
        isDataLoading.value = true;
        model.value = value;
      });
  }

}