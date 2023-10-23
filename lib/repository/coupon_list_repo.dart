import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/coupon_list_model.dart';
import '../model/model_verify_otp.dart';
import '../resources/api_urls.dart';

Future<CouponModel> couponData(context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  http.Response response =
  await http.get(Uri.parse(ApiUrl.couponsUrl), headers: headers);

  if (response.statusCode == 200) {
    return CouponModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}
