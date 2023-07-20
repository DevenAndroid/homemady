import 'package:get/get.dart';
import 'package:homemady/repository/favorite_list_repo.dart';

import '../model/favorite_list_model.dart';

class FavoriteListController extends GetxController{

  Rx<FavoriteListModel> model = FavoriteListModel().obs;
  RxBool isDataLoading = false.obs;

  get(){
    isDataLoading.value = false;
    favoriteData().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}