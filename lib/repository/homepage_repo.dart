import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:homemady/resources/helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/homepage_model.dart';
import '../model/model_verify_otp.dart';
import '../resources/api_urls.dart';
import '../routers/routers.dart';

Future<HomePageModel> homeData({
  required String primariy_category,
  required String secondary_category,
  required String tertiary_category,
  required String dietaries,
    required String filter,
    required String longitude,
    required String latitude,
    BuildContext? context}) async {
  OverlayEntry? loader;
  try {
    if (context != null) {
      loader = Helpers.overlayLoader(context);
      Overlay.of(context).insert(loader);
    }

    // SharedPreferences pref = await SharedPreferences.getInstance();
    // ModelVerifyOtp? user = ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      // HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
    };
    // log(user.authToken.toString());

    String url = ApiUrl.homePageApi;
    List<String> types = [];
    log("Generated Url 11.....      $url");
    log("Generated Url 11.....      $longitude");

    // primariy_category=50,53&secondary_category=2,3,4&dietaries=4,3,5&keyword=store&filter=2&tertiary_category=26,27,28
    if(primariy_category.isNotEmpty)types.add("primariy_category=$primariy_category");
    if(secondary_category.isNotEmpty)types.add("secondary_category=$secondary_category");
    if(tertiary_category.isNotEmpty)types.add("tertiary_category=$tertiary_category");
    if(filter.isNotEmpty)types.add("filter=$filter");
    if(dietaries.isNotEmpty)types.add("dietaries=$dietaries");
    if(longitude.isNotEmpty)types.add("longitude=$longitude");
    if(latitude.isNotEmpty)types.add("latitude=$latitude");
    if (types.isNotEmpty) {
      url = "$url?${types.join("&")}";
    }

    log("Generated Url .....      $url");

    http.Response response = await http.get(Uri.parse(url), headers: headers);

    if (context != null) {
      Helpers.hideLoader(loader!);
    }

    if (response.statusCode == 200) {
      log("<<<<<<<HomePageData=======>${response.body}");
      return HomePageModel.fromJson(json.decode(response.body));
    }    else if(response.statusCode == 401){
      Get.offAllNamed(MyRouters.loginScreen);
      throw Exception(response.body);
    }
    else {
      throw Exception(response.body);
    }
  } catch (e) {
    if (context != null) {
      Helpers.hideLoader(loader!);
    }
    throw Exception(e);
  }
}
