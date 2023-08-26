import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/checkout_order_model.dart';
import '../model/common_model.dart';
import '../model/model_verify_otp.dart';
import '../resources/api_urls.dart';
import '../resources/helper.dart';

Future<CheckoutOrderModel> checkOut(
    {required payment_type,
      required delivery_type,
      required deliveryInstruction,
      required specialRequest,
      required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['payment_type'] = payment_type;
  map['delivery_type'] = delivery_type;
  map['instruction_for_delivery'] = deliveryInstruction;
  map['special_request'] = specialRequest;
 // map['note'] = note;
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
  http.Response response = await http.post(Uri.parse(ApiUrl.checkOutUrl),headers: headers,body:jsonEncode(map));
  log(response.body.toString());
  if (response.statusCode == 200||response.statusCode == 400) {
    Helpers.hideLoader(loader);
    return CheckoutOrderModel.fromJson(json.decode(response.body));
  } else {
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}

Future<CheckoutOrderModel> payment(
    {required orderId,required token,required amount,required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['order_id'] = orderId;
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
  http.Response response = await http.post(Uri.parse(ApiUrl.paymentUrl),headers: headers,body:jsonEncode(map));
  log(response.body.toString());
  if (response.statusCode == 200||response.statusCode == 400) {
    Helpers.hideLoader(loader);
    return CheckoutOrderModel.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, "Something went worng");
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}

// For save card info

Future<ModelCommonResponse> saveCardDetailsRepo(
    {required stripeToken, required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['stripe_token'] = stripeToken;

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
  http.Response response = await http.post(Uri.parse(ApiUrl.saveCardDetailsUrl),headers: headers,body:jsonEncode(map));
  log(response.body.toString());
  if (response.statusCode == 200 || response.statusCode == 400) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, "Something went worng");
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}