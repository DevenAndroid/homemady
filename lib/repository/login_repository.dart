import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:homemady/model/common_model.dart';
import 'package:homemady/routers/routers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/model_verify_otp.dart';
import '../resources/api_urls.dart';
import '../widgets/new_helper.dart';

Future<ModelVerifyOtp> loginRepo(
    {required String email,
      required String password,
      required String fcmToken,
      required String role,
      required BuildContext context}) async {
  OverlayEntry loader = NewHelper.overlayLoader(context);
  Overlay.of(context).insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  //print("These are details.....${pref}");
  var map = <String, dynamic>{};
  map['email_number'] = email;
  map['password'] = password;
  map['role'] = role;
 map['device_id'] = pref.getString("deviceId");
 map['device_token'] = fcmToken;


  log("Login Data map$map");
  try {
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    http.Response response = await http.post(Uri.parse(ApiUrl.loginApi),
        body: jsonEncode(map), headers: headers);
    if (response.statusCode == 200||response.statusCode == 400) {

      NewHelper.hideLoader(loader);
      return ModelVerifyOtp.fromJson(json.decode(response.body));
    }

    else if(response.statusCode == 401){
      Get.offAllNamed(MyRouters.loginScreen);
      throw Exception(response.body);
    }
    else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}


Future<ModelVerifyOtp> profileRepo() async {
  /*OverlayEntry loader = NewHelper.overlayLoader(context);
  Overlay.of(context)!.insert(loader);*/
  SharedPreferences pref = await SharedPreferences.getInstance();
  //print("These are details.....${pref}");
 /* var map = <String, dynamic>{};
  map['email'] = email;
  map['password'] = password;
  map['device_id'] = pref.getString('deviceId');
  // map['device_token'] = fcmToken;*/

  //log("Login Data map$map");
  try {
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    http.Response response = await http.post(Uri.parse(ApiUrl.loginApi),
         headers: headers);

    if (response.statusCode == 200||response.statusCode == 400) {
      //NewHelper.hideLoader(loader);
      return ModelVerifyOtp.fromJson(json.decode(response.body));
    } else {
     // NewHelper.hideLoader(loader);
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}


