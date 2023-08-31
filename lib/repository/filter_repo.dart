import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/category_model.dart';
import '../model/filter_model.dart';
import '../model/model_verify_otp.dart';
import '../resources/api_urls.dart';
//All Dropdown api
Future<FilterModel> filterDataRepo({required DateTime pickDate,required keyword}) async {
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
  // 2023/09/01

  String url = "${ApiUrl.filterDateUrl}?date=${DateFormat("yyyy/MM/dd").format(pickDate)}&store_name=$keyword";

  log(("Url...$url"));
  final response =
  await http.get(Uri.parse(url), headers: headers);


  // print("size data  Repository...${response.body}");
  if (response.statusCode == 200) {
    print("Filter store Repository...${response.body}");
    return FilterModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}

