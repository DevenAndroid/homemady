import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/model_verify_otp.dart';
import '../model/privacy_policy_model.dart';
import '../resources/api_urls.dart';

Future<PrivacyPolicyModel> privacyPolicyData({required slug}) async {
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
  // log(user.authToken.toString());
  http.Response response =
  await http.get(Uri.parse('${ApiUrl.privacyPolicyUrl}?slug=privacy-policy'), headers: headers);
  log("<<<<<<<PrivacyPolicyData=======>${response.body}");
  if (response.statusCode == 200) {
    log("<<<<<<<PrivacyPolicyData=======>${response.body}");
    return PrivacyPolicyModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}
