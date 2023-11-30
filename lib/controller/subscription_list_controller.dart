

import 'package:get/get.dart';

import '../model/subscription_list_model.dart';
import '../repository/subscription_list_repo.dart';

class SubscriptionListController extends GetxController{

  Rx<SubscriptionListModel> model = SubscriptionListModel().obs;
  RxBool isDataLoading = false.obs;

  Future getData() async {
    isDataLoading.value = false;
    await subscriptionListData().then((value1) {
      isDataLoading.value = true;
      model.value = value1;
    });
    //loginRepo().
  }






}