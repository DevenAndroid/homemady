import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/model_verify_otp.dart';
import '../model/order_details_model.dart';
import '../resources/api_urls.dart';

Future<OrderDetailsModel> orderDetailsRepo({required id}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  // try {
  final response = await http.get(
      Uri.parse("${ApiUrl.orderDetailsUrl}?order_id=$id"),
      headers: headers);
  log("Order Details...${response.body}");
  if (response.statusCode == 200) {
    log("Order Details...${response.body}");
    return OrderDetailsModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
  // } catch (e) {
  // }
}
