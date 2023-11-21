
import 'package:get/get.dart';
import '../model/order_tracking_model.dart';
import '../repository/order_tracking_repo.dart';

class OrderTrackingController extends GetxController{
  bool isDataLoading=false;
  Rx<OrderTrackingModel> orderTrackingModel = OrderTrackingModel().obs;

  Future getOrderTrackingDetails(String orderId) async {
    isDataLoading=false;
    await orderTrackingRepo(orderId: orderId).then((value){
      isDataLoading=true;
      orderTrackingModel.value=value;
    });
  }

}