
import 'package:get/get.dart';
import '../model/category_model.dart';
import '../model/dietiary_model.dart';
import '../repository/category_repo.dart';

class CategoryController extends GetxController{
  Rx<CategoryModel> categoryModel = CategoryModel().obs;
  Rx<DietiartyModel> dietiaryModel = DietiartyModel().obs;

  Future getCategoryData() async {
    await categoryListData().then((value){
      categoryModel.value=value;
    });
  }
  // dietiary data
  Future getDietaryData() async {
    await dietiaryListData().then((value){
      dietiaryModel.value=value;
    });
  }

}