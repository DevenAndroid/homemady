

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/homepage_model.dart';
import '../model/model_verify_otp.dart';
import '../model/notification_model.dart';
import '../model/subscription_list_model.dart';
import '../repository/homepage_repo.dart';
import '../repository/login_repository.dart';
import '../repository/notification_repo.dart';
import '../repository/subscription_list_repo.dart';

class SubscriptionListController extends GetxController{

  Rx<SubscriptionListModel> model = SubscriptionListModel().obs;
  RxBool isDataLoading = false.obs;

  getData(){
    isDataLoading.value = false;
    subscriptionListData().then((value1) {
      isDataLoading.value = true;
      model.value = value1;
    });
    //loginRepo().
  }






}