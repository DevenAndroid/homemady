import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/model_verify_otp.dart';
import '../model/resend_otp_model.dart';
import '../resources/api_urls.dart';
import '../widgets/new_helper.dart';

Future<ResendOtpModel> ratingReviewRepo(
    {

      required String orderId,
      required String review,
      required String foodQuality,
      required String foodQuantity,
      required String communication,
      required String hygiene,
      required String delivery,
      required BuildContext context
    }) async {
  OverlayEntry loader = NewHelper.overlayLoader(context);
  Overlay.of(context).insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  var map = <String, dynamic>{};

  map['order_id'] = orderId;
  map['review'] = review;
  map['is_food_quality'] = foodQuality;
  map['is_food_quantity'] = foodQuantity;
  map['is_communication'] = communication;
  map['is_hygiene'] = hygiene;
  map['is_delivery'] = delivery;
print(map);
  try {
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
    };
    http.Response response = await http.post(Uri.parse(ApiUrl.ratingReviewUrl),
        body: jsonEncode(map), headers: headers);
    if (response.statusCode == 200||response.statusCode == 400) {
      print("<<<<<<<Rating Review Data from repository=======>${response.body}");
      NewHelper.hideLoader(loader);
      return ResendOtpModel.fromJson(json.decode(response.body));
    } else {
      NewHelper.hideLoader(loader);
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}