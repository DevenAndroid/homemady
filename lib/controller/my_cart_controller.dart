
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/my_cart_model.dart';
import '../repository/my_cart_repo.dart';

class MyCartListController extends GetxController{

  Rx<MyCartListModel> model = MyCartListModel().obs;
  RxBool isDataLoading = false.obs;
  RxInt sum = 0.obs;

  Future getData() async {
    isDataLoading.value = false;
    await myCartRepo().then((value1) {
      isDataLoading.value = true;
      sum.value = 0;
      for(int i=0; i < value1.data!.cartItems!.length; i++){
        sum.value = sum.value + int.parse(value1.data!.cartItems![i].cartItemQty.toString());
        print('SSSSSSS-----${sum.value}');
      }
      model.value = value1;
    });
    //loginRepo().
  }






}