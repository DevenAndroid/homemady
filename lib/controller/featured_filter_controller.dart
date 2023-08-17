import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../model/featured_filter_ model.dart';
import '../repository/featured_filter_repo.dart';

class FeaturedFilterController extends GetxController{

  Rx<FeaturedFilterModel> model = FeaturedFilterModel().obs;
  RxBool isDataLoading = false.obs;
  RxString filterId="4".obs;


  getData(){
    isDataLoading.value = false;
    featuredFilterRepo(filter:filterId.value).then((value1) {
      isDataLoading.value = true;
      model.value = value1;
    });
    //loginRepo();

  }
}