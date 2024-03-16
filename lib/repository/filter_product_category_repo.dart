import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/filter_product_category_model.dart';
import '../model/model_verify_otp.dart';
import '../resources/api_urls.dart';
import '../widgets/new_helper.dart';

Future<FilterProductCategoryModel> filterProductCategoryRepo({
  required filter,
  required BuildContext context,
  required product_option_id,
  required latitude,
  required longitude,
}) async {
  OverlayEntry loader = NewHelper.overlayLoader(context);
  Overlay.of(context).insert(loader);

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

  try {
    final response = await http.get(
      Uri.parse("${ApiUrl.filterProductCategoryUrl}?filter=$filter&product_option_id=$product_option_id&latitude=$latitude&longitude=$longitude"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      NewHelper.hideLoader(loader);
      log("sort stores by category...${response.body}");
      return FilterProductCategoryModel.fromJson(jsonDecode(response.body));
    } else {
      NewHelper.hideLoader(loader);
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    NewHelper.hideLoader(loader);
    throw Exception('Error: $e');
  }
}
