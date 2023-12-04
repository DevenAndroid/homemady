import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/homepage_model.dart';
import '../repository/homepage_repo.dart';
import 'category_controller.dart';

class HomePageController extends GetxController {
  Rx<HomePageModel> model = HomePageModel().obs;
  RxBool isDataLoading = false.obs;
  final storeSearchController=TextEditingController();

  final categoryController = Get.put(CategoryController());
  // RxString filterCategoryId="".obs;
  // RxString categoryType="".obs;
  // RxString chooseDietaries="".obs;

 Future getData({
    // String? filterCategory,
    // String? categoryType,
    // String? chooseDietaries,
    required String filter,
   BuildContext? context
  }) async{
    // isDataLoading.value = false;

   // filterCategory: categoryController
   //     .categoryModel.value.data!.selectedIds.value
   //     .toList()
   //     .join(","),
   // // categoryType: ,
   // chooseDietaries: categoryController.dietiaryModel.value.data!.selectedIds
   //     .toList()
   //     .join(","),
  await homeData(
      filterCategory: categoryController
          .categoryModel.value.data != null ?
      categoryController
          .categoryModel.value.data!.selectedIds.value
          .toList()
          .join(",") : "",
      dietaries: categoryController.dietiaryModel.value.data != null ?
      categoryController.dietiaryModel.value.data!.selectedIds
          .toList()
          .join(",") : "",
      filter: filter,
    context: context
    ).then((value1) {
      isDataLoading.value = true;
      model.value = value1;
    });
    //loginRepo();
  }
}
