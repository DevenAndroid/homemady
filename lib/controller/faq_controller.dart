
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/faq_model.dart';
import '../model/homepage_model.dart';
import '../model/model_verify_otp.dart';
import '../repository/faq_repo.dart';
import '../repository/homepage_repo.dart';
import '../repository/login_repository.dart';

  class FaqController extends GetxController{

  Rx<FaqModel> model = FaqModel().obs;
  RxBool isDataLoading = false.obs;

  getData(){
    isDataLoading.value = false;
    faqData().then((value1) {
      isDataLoading.value = true;
      model.value = value1;
    });
    //loginRepo().
  }






}