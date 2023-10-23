import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/social_login_model.dart';
import '../resources/api_urls.dart';
import '../resources/helper.dart';

Future<SocialLoginModel> socialLogin(
    {required String provider,required String token,
      required BuildContext context}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var map = <String, dynamic>{};
  map['provider'] = provider;
  map['token'] = token;

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  //print('REQUEST ::${jsonEncode(map)}');
  // log(pref.getString('deviceId')!);
  http.Response response = await http.post(Uri.parse(ApiUrl.socialUrl),
      body: jsonEncode(map), headers: headers);
  log(map.toString());
  log(response.statusCode.toString());
  log(response.body);
  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return SocialLoginModel.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}

