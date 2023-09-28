import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/edit_address_model.dart';
import '../model/model_verify_otp.dart';
import '../resources/api_urls.dart';
import '../resources/helper.dart';

Future<EditAddressModel> editAddress(
    {required location,
      required flat_no,
      required landmark,
      required name,
      required address_type,
      required address_id,
      required postalCode,
      required deliveryInstruction,
      required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['location'] = location;
  map['name'] = name;
  map['flat_no'] = flat_no;
  map['landmark'] = landmark;
  map['address_type'] = address_type;
  map['address_id'] = address_id;
  map['pin_code'] = postalCode;
  map['note'] = deliveryInstruction;
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
  http.Response response = await http.post(Uri.parse(ApiUrl.editAddressUrl),
      body: jsonEncode(map), headers: headers);
  print(response.body);
  if (response.statusCode == 200 || response.statusCode == 400) {
    Helpers.hideLoader(loader);
    return EditAddressModel.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}