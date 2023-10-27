import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/model_verify_otp.dart';
import '../model/time_slot_model.dart';
import '../resources/api_urls.dart';
//All Dropdown api
Future<TimeSlotModel> timeSlotListData({required pickDate, required mobileTime}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  // log('${ApiUrl.featuredFilterUrl}?filter=$filter&pick_date=$pickDate&status=$status');
  final response =
  await http.get(Uri.parse("${ApiUrl.timeSlotUrl}?date=$pickDate&mobile_time=$mobileTime"), headers: headers);
  // print("size data  Repository...${response.body}");
  if (response.statusCode == 200) {
    return TimeSlotModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}

