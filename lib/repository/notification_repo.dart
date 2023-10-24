import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/model_verify_otp.dart';
import '../model/notification_model.dart';
import '../model/remove_notification_model.dart';
import '../resources/api_urls.dart';

Future<NotificationModel> notificationData() async {
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
  await http.get(Uri.parse(ApiUrl.notificationUrl), headers: headers);
  log("<<<<<<<NotificationData=======>${response.body}");
  if (response.statusCode == 200) {
    log("<<<<<<<NotificationData=======>${response.body}");
    return NotificationModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}
// for remove the notification after seen
Future<NotificationHideUdpateModel> notificationHideRepo({required id}) async {
  var map = <String, dynamic>{};


  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  //log(map.toString());
  // try {
  final response = await http.get(Uri.parse('${ApiUrl.notificationHideUpdateUrl}/$id'),
      headers: headers);
  log("Notification Hide Repository...${response.body}");

  if (response.statusCode == 200) {
    log("Notification Hide Repository...${response.body}");
    return NotificationHideUdpateModel.fromJson(jsonDecode(response.body));
  } else {
    return NotificationHideUdpateModel.fromJson(jsonDecode(response.body));
  }
  // }
  // catch (e) {
  //   throw Exception(e.toString());
  // }
}
