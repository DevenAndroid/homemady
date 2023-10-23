
import 'package:get/get.dart';
import '../model/order_tracking_model.dart';
import '../repository/order_tracking_repo.dart';

class OrderTrackingController extends GetxController{
  bool isDataLoading=false;
  Rx<OrderTrackingModel> orderTrackingModel = OrderTrackingModel().obs;
  RxString orderIdTracking="".obs;

  Future getOrderTrackingDetails() async {
    isDataLoading=false;
    await orderTrackingRepo(orderId: orderIdTracking.value).then((value){
      isDataLoading=true;
      orderTrackingModel.value=value;
    });
  }

}