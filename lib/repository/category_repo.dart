import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/category_model.dart';
import '../model/model_verify_otp.dart';
import '../resources/api_urls.dart';
//All Dropdown api
Future<CategoryModel> categoryListData() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  final response =
  await http.get(Uri.parse(ApiUrl.categoryUrl), headers: headers);

  // print("size data  Repository...${response.body}");
  if (response.statusCode == 200) {
    print("Category Repository...${response.body}");
    return CategoryModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}

