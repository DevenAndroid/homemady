import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/common_model.dart';
import '../model/model_verify_otp.dart';
import '../model/my_cart_model.dart';
import '../resources/api_urls.dart';
import '../resources/helper.dart';

Future<MyCartListModel> myCartRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  // try {
    final response =
    await http.get(Uri.parse(ApiUrl.myCartApi), headers: headers);

    if (response.statusCode == 200) {
      log("My Cart Data...${response.body}");
      return MyCartListModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  // }
  // catch (e) {
  //   throw Exception(e.toString());
  // }
}

// Reorder repo
Future<ModelCommonResponse> reOrderRepo(
    {required context,required id}) async {
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
  // log(map.toString());
  http.Response response = await http.post(Uri.parse("${ApiUrl.reOrderUrl}$id"),headers: headers,);
  log(response.body.toString());
  if (response.statusCode == 200 || response.statusCode==400) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}