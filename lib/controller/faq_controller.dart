
import 'package:get/get.dart';

import '../model/faq_model.dart';
import '../repository/faq_repo.dart';

  class FaqController extends GetxController{

  Rx<FaqModel> model = FaqModel().obs;
  RxBool isDataLoading = false.obs;

  getData(){
    isDataLoading.value = false;
    faqData(faqType: "customer").then((value1) {
      isDataLoading.value = true;
      model.value = value1;
    });
    //loginRepo().
  }






}