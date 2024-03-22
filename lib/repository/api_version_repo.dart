import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:homemady/model/api_version_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/model_verify_otp.dart';
import '../model/privacy_policy_model.dart';
import '../resources/api_urls.dart';

Future<ModelAppVersion> getUpdateVersion({versioncode, type}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  }; // log(user.authToken.toString());
  http.Response response =
  await http.get(Uri.parse("http://52.50.121.179/api/get-app-version?version_code=$versioncode&type=$type"), headers: headers);
  log("<<<<<<<PrivacyPolicyData=======>${response.body}");
  if (response.statusCode == 200) {
    log("<<<<<<<PrivacyPolicyData=======>${response.body}");
    return ModelAppVersion.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}


