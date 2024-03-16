import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/featured_filter_ model.dart';
import '../model/model_verify_otp.dart';
import '../resources/api_urls.dart';

Future<FeaturedFilterModel> featuredFilterRepo(
    {required filter, required pickDate, required status, required latitude, required longitude}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? userInfo = pref.getString('user_info');
  ModelVerifyOtp? user;

  if (userInfo != null) {
    user = ModelVerifyOtp.fromJson(jsonDecode(userInfo));
  }

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  if (user != null) {
    headers[HttpHeaders.authorizationHeader] = 'Bearer ${user.authToken}';
  }
  http.Response response = await http.get(
      Uri.parse('${ApiUrl.featuredFilterUrl}?filter=$filter&pick_date=$pickDate&status=$status&latitude=$latitude&longitude=$longitude'),
      headers: headers);
   log("<<<<<<<Featured Filter Repo data=======>${response.body}");
  if (response.statusCode == 200) {
    log("<<<<<<<Featured Filter Repo data=======>${response.body}");
    return FeaturedFilterModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}
