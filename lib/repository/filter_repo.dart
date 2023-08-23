import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/category_model.dart';
import '../model/filter_model.dart';
import '../model/model_verify_otp.dart';
import '../resources/api_urls.dart';
//All Dropdown api
Future<FilterModel> filterDataRepo({required pickDate,required availableNow, required keyword}) async {
  // var map = <String, dynamic>{};
  //
  //   map['date'] = pickDate;

  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  final response =
  await http.get(Uri.parse("${ApiUrl.filterDateUrl}?date=$pickDate&available_now=$availableNow&keyword=$keyword"), headers: headers);

  log(("Url...${ApiUrl.filterDateUrl}?date=$pickDate&available_now=$availableNow&store_name=$keyword"));

  // print("size data  Repository...${response.body}");
  if (response.statusCode == 200) {
    print("Filter store Repository...${response.body}");
    return FilterModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}

