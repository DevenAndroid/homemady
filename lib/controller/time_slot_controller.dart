
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../model/time_slot_model.dart';
import '../repository/time_slot_repo.dart';

class TimeSlotController extends GetxController{

  bool isDataLoading=false;
  Rx<TimeSlotModel> timeSlotModel = TimeSlotModel().obs;
  RxString sendDate = "".obs;
  RxString giveTime = "".obs;



  Future getTimeSlotData() async {
    String currentTime= DateFormat("hh:mm a").format(DateTime.now()).toString();
    isDataLoading=false;
    await timeSlotListData(pickDate: sendDate.value, mobileTime: currentTime).then((value){
      isDataLoading=true;
      timeSlotModel.value=value;
    });
  }

}