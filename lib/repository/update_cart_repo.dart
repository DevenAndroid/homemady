import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/model_verify_otp.dart';
import '../model/update_cart_repo.dart';
import '../resources/api_urls.dart';
import '../resources/helper.dart';

Future<UpdateCartRepo> updateCartRepo(cartItemId, qty, context) async {
  var map = <String, dynamic>{};
  map['cart_item_id'] = cartItemId;
  map['qty'] = qty;
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  log(map.toString());
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  try {
    final response = await http.post(Uri.parse(ApiUrl.updateCartUrl),
        body: jsonEncode(map), headers: headers);
    print("Update Cart Data...${response.body}");
    if (response.statusCode == 200 || response.statusCode == 400) {
      Helpers.hideShimmer(loader);
      print("Update Cart Data...${response.body}");
      return UpdateCartRepo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}