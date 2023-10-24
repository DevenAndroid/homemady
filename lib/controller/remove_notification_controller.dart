import 'package:get/get.dart';
import '../model/remove_notification_model.dart';
import '../repository/notification_repo.dart';

class NotificationHideController extends GetxController{

  Rx<NotificationHideUdpateModel> model = NotificationHideUdpateModel().obs;
  RxBool isDataLoading = false.obs;
  RxString id = "".obs;


  getData(){
    isDataLoading.value = false;
    notificationHideRepo(id: id.value).then((value) {
      isDataLoading.value = true;
    });
  }



}


