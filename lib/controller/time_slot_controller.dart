
import 'package:get/get.dart';
import '../model/time_slot_model.dart';
import '../repository/time_slot_repo.dart';

class TimeSlotController extends GetxController{
  bool isDataLoading=false;
  Rx<TimeSlotModel> timeSlotModel = TimeSlotModel().obs;
  RxString sendDate = "".obs;

  Future getTimeSlotData() async {
    isDataLoading=false;
    await timeSlotListData(pickDate: sendDate.value).then((value){
      isDataLoading=true;
      timeSlotModel.value=value;
    });
  }

}