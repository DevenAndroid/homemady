
import 'package:get/get.dart';
import '../model/category_model.dart';
import '../model/dietiary_model.dart';
import '../repository/category_repo.dart';

class CategoryController extends GetxController{
  bool isDataLoading=false;
  Rx<CategoryModel> categoryModel = CategoryModel().obs;
  Rx<DietiartyModel> dietiaryModel = DietiartyModel().obs;

  Future getCategoryData() async {
    isDataLoading=false;
    await categoryListData().then((value){
      isDataLoading=true;
      categoryModel.value=value;
    });
  }
  // dietiary data
  Future getDietiaryData() async {
    isDataLoading=false;
    await dietiaryListData().then((value){
      isDataLoading=true;
      dietiaryModel.value=value;
    });
  }

}