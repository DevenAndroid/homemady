
import 'package:get/get.dart';

import '../model/my_order_model.dart';
import '../repository/my_order_repo.dart';

class MyOrderController extends GetxController{

  Rx<MyOrderModel> model = MyOrderModel().obs;
  RxBool isDataLoading = false.obs;

  getData(){
    isDataLoading.value = false;
    myOrderData().then((value1) {
      isDataLoading.value = true;
      model.value = value1;
    });
    //loginRepo().
  }






}