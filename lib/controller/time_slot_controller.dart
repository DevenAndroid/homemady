
import 'package:get/get.dart';
import '../model/time_slot_model.dart';
import '../repository/time_slot_repo.dart';

class TimeSlotController extends GetxController{

  bool isDataLoading=false;
  Rx<TimeSlotModel> timeSlotModel = TimeSlotModel().obs;
  RxString sendDate = "".obs;
  RxString giveTime = "".obs;


  Future getTimeSlotData() async {
    DateTime now = DateTime.now();
    String formattedTime = "${now.hour}:${now.minute}:${now.second}";
    isDataLoading=false;
    await timeSlotListData(pickDate: sendDate.value, mobileTime: formattedTime).then((value){
      isDataLoading=true;
      timeSlotModel.value=value;
    });
  }

}