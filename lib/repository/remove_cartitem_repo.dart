import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/model_verify_otp.dart';
import '../model/remove_cart_model.dart';
import '../resources/api_urls.dart';
import '../resources/helper.dart';

Future<RemoveCartModel> removeCartItemRepo(
{ required String cart_item_id, context} ) async {
  var map = <String, dynamic>{};
  map['cart_item_id'] = cart_item_id;
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
  try {
    final response = await http.post(Uri.parse(ApiUrl.removeCartItemUrl),
        body: jsonEncode(map), headers: headers);
    Helpers.hideLoader(loader);
    if (response.statusCode == 200 || response.statusCode == 400) {
      Helpers.hideLoader(loader);
      return RemoveCartModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    Helpers.hideLoader(loader);
    throw Exception(e.toString());
  }
}
