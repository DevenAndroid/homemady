import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/filter_model.dart';
import '../model/model_verify_otp.dart';
import '../resources/api_urls.dart';
//All Dropdown api
Future<FilterProductModel> filterDataRepo({required DateTime pickDate,required keyword}) async {

  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  // 2023/09/01

  String url = "${ApiUrl.filterDateUrl}?date=${DateFormat("yyyy/MM/dd").format(pickDate)}&keyword=$keyword";

  log(("Url...$url"));
  final response =
  await http.get(Uri.parse(url), headers: headers);


  print("Pick date and search Repository...${response.body}");
  if (response.statusCode == 200) {
    return FilterProductModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}

