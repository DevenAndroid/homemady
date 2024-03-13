import 'package:get/get.dart';
import '../model/featured_filter_ model.dart';
import '../repository/featured_filter_repo.dart';

class FeaturedFilterController extends GetxController {
  Rx<FeaturedFilterModel> model = FeaturedFilterModel().obs;
  RxBool isDataLoading = false.obs;
  RxString filterId = "2".obs;
  // DateTime sendDate=DateTime.now();
  RxString sendDate = "".obs;
  RxString status = "".obs;
  RxInt refreshInt = 0.obs;

  getData(latitude,longitude) {
    featuredFilterRepo(
            filter: filterId.value, pickDate: sendDate.value, status: status.value, latitude: latitude, longitude: longitude)
        .then((value1) {
      model.value = value1;
      isDataLoading.value = true;
      refreshInt.value = DateTime.now().millisecondsSinceEpoch;
    });
    //loginRepo();
  }
}
