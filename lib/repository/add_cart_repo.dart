import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/add_cart_model.dart';
import '../model/model_verify_otp.dart';
import '../resources/api_urls.dart';
import '../resources/helper.dart';

Future<AddCartModel> addToCartRepo(
    {product_id, qty, context}) async {
  var map = <String, dynamic>{};
  map['product_id'] = product_id;
  map['qty'] = qty;
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  log(map.toString());
  try {
    final response = await http.post(Uri.parse(ApiUrl.addCartApi),
        body: jsonEncode(map), headers: headers);
    log("Add To Cart Data...${response.body}");
    if (response.statusCode == 200 || response.statusCode == 400) {
      Helpers.hideShimmer(loader);
      log("Add To Cart Data...${response.body}");
      return AddCartModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}