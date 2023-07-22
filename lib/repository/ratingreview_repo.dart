import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/resend_otp_model.dart';
import '../resources/api_urls.dart';
import '../widgets/new_helper.dart';

Future<ResendOtpModel> ratingReviewRepo(
    {
      required String type,
      required String driverId,
      required String storeId,
      required String rating,
      required bool foodQuality,
      required bool foodQuantity,
      required bool communication,
      required bool hygiene,
      required bool delivery,
      required BuildContext context
    }) async {
  OverlayEntry loader = NewHelper.overlayLoader(context);
  Overlay.of(context).insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  //print("These are details.....${pref}");
  var map = <String, dynamic>{};
  map['type'] = type;
  map['driver_id'] = driverId;
  map['store_id'] = driverId;
  map['rating'] = rating;
  map['is_food_quality'] = foodQuality;
  map['is_food_quantity'] = foodQuantity;
  map['is_communication'] = communication;
  map['is_hygiene'] = hygiene;
  map['is_delivery'] = delivery;

  // map['device_id'] = pref.getString('deviceId');
  // map['device_token'] = fcmToken;

  //log("Login Data map$map");
  try {
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
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