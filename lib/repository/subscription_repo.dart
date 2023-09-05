import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/model_verify_otp.dart';
import '../model/subscription_model.dart';
import '../resources/api_urls.dart';
import '../resources/helper.dart';

Future<SubscriptionModel> subscription(
    {required token,required amount,required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['token'] = token;
  map['amount'] = amount;
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  log(map.toString());
  http.Response response = await http.post(Uri.parse(ApiUrl.subscriptionUrl),headers: headers,body:jsonEncode(map));
  log(response.body.toString());
  if (response.statusCode == 200||response.statusCode == 400) {
    Helpers.hideLoader(loader);
    return SubscriptionModel.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, "Something went worng");
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}