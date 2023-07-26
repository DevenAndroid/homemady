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

Future<ModelCommonResponse> removeAddress(
    {required addressId,required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['address_id'] = addressId;
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  http.Response response = await http.post(Uri.parse(ApiUrl.removeAddressUrl),headers: headers,body:jsonEncode(map));
  log(response.body.toString());
  if (response.statusCode == 200 ||response.statusCode == 400) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}