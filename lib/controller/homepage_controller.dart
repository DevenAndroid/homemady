
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/homepage_model.dart';
import '../model/model_verify_otp.dart';
import '../repository/homepage_repo.dart';
import '../repository/login_repository.dart';

class HomePageController extends GetxController{

  Rx<HomePageModel> model = HomePageModel().obs;
  RxBool isDataLoading = false.obs;
  RxString filterCategoryId="".obs;
  RxString categoryType="".obs;
  RxString chooseDietaries="".obs;

  getData(){
    isDataLoading.value = false;
    homeData(filterCategory: filterCategoryId.value, categoryType: categoryType.value, dietaries: chooseDietaries.value,).then((value1) {
      isDataLoading.value = true;
      model.value = value1;
    });
    //loginRepo();

  }






}