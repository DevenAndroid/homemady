import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/homepage_model.dart';
import '../model/model_verify_otp.dart';
import '../resources/api_urls.dart';

Future<HomePageModel> homeData() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  log(user.authToken.toString());
  http.Response response =
  await http.get(Uri.parse(ApiUrl.homePageApi), headers: headers);
  log("<<<<<<<HomePageData=======>${response.body}");
  if (response.statusCode == 200) {
    log("<<<<<<<HomePageData=======>${response.body}");
    return HomePageModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}