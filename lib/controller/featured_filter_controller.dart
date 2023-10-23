import 'package:get/get.dart';
import '../model/featured_filter_ model.dart';
import '../repository/featured_filter_repo.dart';

class FeaturedFilterController extends GetxController{

  Rx<FeaturedFilterModel> model = FeaturedFilterModel().obs;
  RxBool isDataLoading = false.obs;
  RxString filterId="".obs;
  // DateTime sendDate=DateTime.now();
  RxString sendDate ="".obs;
  RxString status ="".obs;


  getData(){
    isDataLoading.value = false;
    featuredFilterRepo(filter:filterId.value, pickDate: sendDate.value,status:status.value).then((value1) {
      isDataLoading.value = true;
      model.value = value1;
    });
    //loginRepo();

  }
}