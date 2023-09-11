
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../model/review_screen_model.dart';
import '../repository/review_screen_repo.dart';

class StoreRevierwController extends GetxController{

  Rx<FeedBackModel> model = FeedBackModel().obs;
  RxBool isDataLoading = false.obs;
  RxString vendorId = ''.obs;

  getData(){
    isDataLoading.value = false;
    feedbackRepo(vendorId:vendorId.value ).then((value1) {
      isDataLoading.value = true;
      model.value = value1;
    });
    //loginRepo().
  }






}