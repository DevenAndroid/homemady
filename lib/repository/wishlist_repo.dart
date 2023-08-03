import 'dart:developer';
import 'dart:io';
import 'package:homemady/model/common_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../model/model_verify_otp.dart';
import '../model/wishlist_model.dart';
import '../resources/api_urls.dart';

Future<ModelCommonResponse> wishlistRepo({required id}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  var map =  <String,dynamic>{};
  map ['store_id'] = id;
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  // try {
  final response = await http.post(Uri.parse(ApiUrl.wishlistUrl),
      headers: headers,body: jsonEncode(map),);
  // log("Wishlist Repository...${response.body}");
  //print("${ApiUrl.toggleStatusUrl}/$id");

  if (response.statusCode == 200) {
    log("Wishlist Repository...${response.body}");
    return ModelCommonResponse.fromJson(jsonDecode(response.body));
  } else {
    return ModelCommonResponse.fromJson(jsonDecode(response.body));
  }
  // }
  // catch (e) {
  //   throw Exception(e.toString());
  // }
}
