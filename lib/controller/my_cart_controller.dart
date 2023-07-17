
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/My_Cart_Model.dart';
import '../model/homepage_model.dart';
import '../model/model_verify_otp.dart';
import '../repository/homepage_repo.dart';
import '../repository/login_repository.dart';
import '../repository/my_cart_repo.dart';

class MyCartListController extends GetxController{

  Rx<MyCartModel> model = MyCartModel().obs;
  RxBool isDataLoading = false.obs;

  getData(){
    isDataLoading.value = false;
    myCartRepo().then((value1) {
      isDataLoading.value = true;
      model.value = value1;
    });
    //loginRepo().
  }






}