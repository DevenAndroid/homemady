import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/model_verify_otp.dart';
import '../model/privacy_policy_model.dart';
import '../model/referandearn_model.dart';
import '../resources/api_urls.dart';

Future<ReferAndEarnModel> referAndEarnData() async {
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
  await http.get(Uri.parse('${ApiUrl.referAndEarnUrl}?slug=privacy-policy'), headers: headers);
  log("<<<<<<<Refer And Earn Data=======>${response.body}");
  if (response.statusCode == 200) {
    log("<<<<<<<Refer And Earn Data=======>${response.body}");
    return ReferAndEarnModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}