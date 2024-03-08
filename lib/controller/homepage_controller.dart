import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../model/homepage_model.dart';
import '../repository/homepage_repo.dart';
import 'category_controller.dart';

class HomePageController extends GetxController {
  Rx<HomePageModel> model = HomePageModel().obs;
  RxBool isDataLoading = false.obs;
  final storeSearchController = TextEditingController();

  final categoryController = Get.put(CategoryController());
  String? timeSlot;
  // String currentTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String selectedDate = DateFormat("hh:mm a").format(DateTime.now()).toString();
  Future getData({required String filter, BuildContext? context}) async {
    String primary = "";
    String sec = "";
    String tert = "";
    if (categoryController.categoryModel.value.data != null) {
      Set<String> selectedIds = categoryController.categoryModel.value.data!.selectedIds.value;
      primary = categoryController.categoryModel.value.data!.category!
          .where((element) => selectedIds.contains(element.id.toString()))
          .map((e) => e.id.toString())
          .join(",");
      sec = categoryController.categoryModel.value.data!.secondaryCategory!
          .where((element) => selectedIds.contains(element.id.toString()))
          .map((e) => e.id.toString())
          .join(",");
      tert = categoryController.categoryModel.value.data!.tertiaryCategory!
          .where((element) => selectedIds.contains(element.id.toString()))
          .map((e) => e.id.toString())
          .join(",");
    }
    await homeData(
            primariy_category: primary,
            secondary_category: sec,
            tertiary_category: tert,
            dietaries: categoryController.dietiaryModel.value.data != null
                ? categoryController.dietiaryModel.value.data!.selectedIds.toList().join(",")
                : "",
            filter: filter,
            context: context)
        .then((value1) {
      isDataLoading.value = true;
      model.value = value1;
    });
    //loginRepo();
  }
}
