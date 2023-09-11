
import 'package:get/get.dart';

import '../model/coupon_list_model.dart';
import '../repository/coupon_list_repo.dart';

class CouponController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<CouponModel> model = CouponModel().obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async {
    isDataLoading.value = false;
    couponData(Get.context).then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
