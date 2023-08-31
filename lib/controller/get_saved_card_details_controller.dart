
import 'package:get/get.dart';
import '../model/get_saved_card_Details_model.dart';
import '../repository/get_saved_card_detaills_repo.dart';

class SavedCardDetailsController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<GetSavedCardDetails> savedDetailsModel = GetSavedCardDetails().obs;

  Future getSavedCardData() async {
    isDataLoading.value = false;
    await getSavedCardDetailsREpo().then((value) {
      isDataLoading.value = true;
      savedDetailsModel.value = value;
    });
  }
}
