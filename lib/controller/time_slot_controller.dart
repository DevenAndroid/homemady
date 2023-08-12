
import 'package:get/get.dart';
import '../model/category_model.dart';
import '../model/time_slot_model.dart';
import '../repository/category_repo.dart';
import '../repository/time_slot_repo.dart';

class TimeSlotController extends GetxController{
  bool isDataLoading=false;
  Rx<TimeSlotModel> timeSlotModel = TimeSlotModel().obs;

  Future getTimeSlotData() async {
    isDataLoading=false;
    await timeSlotListData().then((value){
      isDataLoading=true;
      timeSlotModel.value=value;
    });
  }

}