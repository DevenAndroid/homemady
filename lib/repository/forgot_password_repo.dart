import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/forgot_password_model.dart';
import '../resources/api_urls.dart';
import '../widgets/new_helper.dart';

Future<ForgotPasswordModel> forgotPasswordRepo(
    {required String email,
      // required String fcmToken,
      required BuildContext context}) async {
  OverlayEntry loader = NewHelper.overlayLoader(context);
  Overlay.of(context).insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  //print("These are details.....${pref}");
  var map = <String, dynamic>{};
  map['email'] = email;

  log("Forgot password Data map$map");
  try {
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    http.Response response = await http.post(Uri.parse('${ApiUrl.forgotPasswordUrl}?email=$email'),
        body: jsonEncode(map), headers: headers);

    if (response.statusCode == 200||response.statusCode == 400) {
      print("<<<<<<<Forgot password from repository=======>${response.body}");
      NewHelper.hideLoader(loader);
      return ForgotPasswordModel.fromJson(json.decode(response.body));
    } else {
      NewHelper.hideLoader(loader);
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}