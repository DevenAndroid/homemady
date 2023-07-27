
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/homepage_model.dart';
import '../model/model_verify_otp.dart';
import '../model/my_order_model.dart';
import '../repository/homepage_repo.dart';
import '../repository/login_repository.dart';
import '../repository/my_order_repo.dart';

class MyOrderController extends GetxController{

  Rx<MyOrderModel> model = MyOrderModel().obs;
  RxBool isDataLoading = false.obs;

  getData(){
    isDataLoading.value = false;
    myOrderData().then((value1) {
      isDataLoading.value = true;
      model.value = value1;
      print(model.value.toString());
    });
    //loginRepo().
  }






}