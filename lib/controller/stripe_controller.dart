import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/stripe_model.dart';
import '../repository/stripe_repo.dart';

class stripeController extends GetxController {
  RxBool isLoadingData = false.obs;
  Rx<StripeModel> model = StripeModel().obs;
  RxString id = "".obs;
  final TextEditingController stripeId = TextEditingController();
  final TextEditingController stripeKey = TextEditingController();
  getData() {
    stripeSaveDataRepo().then((value) {
      isLoadingData.value = true;
      model.value = value;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }
}
