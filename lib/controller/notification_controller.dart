
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/homepage_model.dart';
import '../model/model_verify_otp.dart';
import '../model/notification_model.dart';
import '../repository/homepage_repo.dart';
import '../repository/login_repository.dart';
import '../repository/notification_repo.dart';

class NotificationController extends GetxController{

  Rx<NotificationModel> model = NotificationModel().obs;
  RxBool isDataLoading = false.obs;

  getData(){
    isDataLoading.value = false;
    notificationData().then((value1) {
      isDataLoading.value = true;
      model.value = value1;
    });
    //loginRepo().
  }






}