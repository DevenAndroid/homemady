import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/model_verify_otp.dart';
import '../model/order_tracking_model.dart';
import '../resources/api_urls.dart';

Future<OrderTrackingModel> orderTrackingRepo({required orderId}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  final response =
  await http.get(Uri.parse("${ApiUrl.orderTrackingUrl}?order_id=$orderId"), headers: headers);

  if (response.statusCode == 200) {
    print("Order Tracking Details...${response.body}");
    return OrderTrackingModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}