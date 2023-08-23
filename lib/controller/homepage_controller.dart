import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../model/homepage_model.dart';
import '../repository/homepage_repo.dart';

class HomePageController extends GetxController {
  Rx<HomePageModel> model = HomePageModel().obs;
  RxBool isDataLoading = false.obs;
  // RxString filterCategoryId="".obs;
  // RxString categoryType="".obs;
  // RxString chooseDietaries="".obs;

  getData({
    String? filterCategory,
    String? categoryType,
    String? chooseDietaries,
    String? filter,
  }) {
    isDataLoading.value = false;
    homeData(
      filterCategory: filterCategory ?? "",
      categoryType: categoryType ?? "",
      dietaries: chooseDietaries ?? "",
      filter: filter ?? "",
    ).then((value1) {
      isDataLoading.value = true;
      model.value = value1;
    });
    //loginRepo();
  }
}
