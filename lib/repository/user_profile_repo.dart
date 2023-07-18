import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/model_verify_otp.dart';
import '../model/user_profile_model.dart';
import '../resources/api_urls.dart';

Future<UserProfileModel> userProfileData() async {
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
  await http.get(Uri.parse(ApiUrl.userProfileUrl), headers: headers);
  log("<<<<<<<UserProfileData=======>${response.body}");
  if (response.statusCode == 200 ) {
    log("<<<<<<<UserProfileData=======>${response.body}");
    return UserProfileModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}
