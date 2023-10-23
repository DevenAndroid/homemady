
import 'package:get/get.dart';

import '../model/notification_model.dart';
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