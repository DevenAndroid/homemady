import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/add_address_model.dart';
import '../model/model_verify_otp.dart';
import '../resources/api_urls.dart';
import '../resources/helper.dart';

Future<AddAddressModel> addAddress(
    {required location,
      required flat_no,
      required landmark,
      required address_type,
      required name,
      required note,
      required pinCode,
      required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['location'] = location;
  map['flat_no'] = flat_no;
  map['landmark'] = landmark;
  map['address_type'] = address_type;
  map['name'] = name;
  map['note'] = note;
  map['pin_code'] = pinCode;
  // map['address_type'] = address_type;
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
  http.Response response = await http.post(Uri.parse(ApiUrl.addAddressUrl),
      body: jsonEncode(map), headers: headers);
  print(response.body);
  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return AddAddressModel.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}
