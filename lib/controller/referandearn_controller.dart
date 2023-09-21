
import 'package:get/get.dart';

import '../model/referandearn_model.dart';
import '../repository/referandearn_repo.dart';

class ReferAndEranController extends GetxController{
  RxBool isDataLoading = false.obs;
  Rx<ReferAndEarnModel> model = ReferAndEarnModel().obs;


  getData(){
    isDataLoading.value = false;
    referAndEarnData().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }

}

