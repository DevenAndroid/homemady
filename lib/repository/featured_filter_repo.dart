import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/featured_filter_ model.dart';
import '../model/homepage_model.dart';
import '../model/model_verify_otp.dart';
import '../model/vendor_store_single_model.dart';
import '../resources/api_urls.dart';

Future<FeaturedFilterModel> featuredFilterRepo({required filter, required pickDate,required status}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  log(user.authToken.toString());
  http.Response response =
  await http.get(Uri.parse('${ApiUrl.featuredFilterUrl}?filter=$filter&pick_date=$pickDate&status=$status'), headers: headers);
  // log("<<<<<<<Featured Filter Repo data=======>${response.body}");
  log('${ApiUrl.featuredFilterUrl}?filter=$filter&pick_date=$pickDate&status=$status');
  if (response.statusCode == 200) {
    log("<<<<<<<Featured Filter Repo data=======>${response.body}");
    return FeaturedFilterModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}
