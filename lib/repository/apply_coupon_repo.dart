import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/common_model.dart';
import '../model/model_verify_otp.dart';
import '../resources/api_urls.dart';
import '../resources/helper.dart';

Future<ModelCommonResponse> applyCoupons(
    {required couponCode, required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['coupon_code'] = couponCode;
  log(map.toString());
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
  http.Response response = await http.post(Uri.parse(ApiUrl.applyCouponsUrl),
      body: jsonEncode(map), headers: headers);
  if (response.statusCode == 200 || response.statusCode ==400) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}


Future<ModelCommonResponse> removeCoupons(
    {required BuildContext context}) async {
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
  http.Response response = await http.get(Uri.parse(ApiUrl.removeCouponsUrl),headers: headers);
  if (response.statusCode == 200 ||response.statusCode == 400) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}

Future<ModelCommonResponse> deleteUserAccount() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  ModelVerifyOtp? user = ModelVerifyOtp.fromJson(jsonDecode(preferences.getString("user_info")!));

 try{
   final header={
     HttpHeaders.contentTypeHeader: 'application/json',
     HttpHeaders.acceptHeader: 'application/json',
     HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
   };
   http.Response data = await http.get(Uri.parse(ApiUrl.deleteUserAccount), headers: header);
   if(data.statusCode==200 || data.statusCode==400){
     return ModelCommonResponse.fromJson(jsonDecode(data.body));
   }else{
     throw Exception(data.body);
   }
 }catch(e){
   throw Exception(e.toString());
 }
}