
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/my_address_model.dart';
import '../repository/my_address_repo.dart';

class MyAddressController extends GetxController {
  RxString id = "".obs;
  RxBool isDataLoading = false.obs;
  Rx<MyAddressModel> model = MyAddressModel().obs;


  getData(){
    isDataLoading.value = false;
    myAddressRepo().then((value1) {
      isDataLoading.value = true;
      model.value = value1;
    });
  }
}