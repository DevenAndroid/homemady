import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/model_verify_otp.dart';
import '../model/vendor_store_single_model.dart';
import '../resources/api_urls.dart';

Future<VendorStoreSingleModel> singleStoreData({required id, required filterId,required latitude, required longitude}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? userInfo = pref.getString('user_info');
  ModelVerifyOtp? user;

  if (userInfo != null) {
    user = ModelVerifyOtp.fromJson(jsonDecode(userInfo));
  }

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  if (user != null) {
    headers[HttpHeaders.authorizationHeader] = 'Bearer ${user.authToken}';
  }
  // log(user.authToken.toString());
  http.Response response =
  await http.get(Uri.parse('${ApiUrl.singleStoreApi}/$id?filter=$filterId&latitude=$latitude&longitude=$longitude'), headers: headers);
  log("<<<<<<<SingleStoreData=======>${response.body}");
  log('${ApiUrl.singleStoreApi}/$id?filter=$filterId&latitude=$latitude&longitude=$longitude');
  if (response.statusCode == 200) {
    log("<<<<<<<SingleStoreData=======>${response.body}");
    return VendorStoreSingleModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}
