import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:homemady/resources/helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/homepage_model.dart';
import '../model/model_verify_otp.dart';
import '../resources/api_urls.dart';

Future<HomePageModel> homeData(
    {required String filterCategory,
    // required categoryType,
    required String dietaries,
    required String filter,
    BuildContext? context}) async {
  OverlayEntry? loader;
  try {
    if (context != null) {
      loader = Helpers.overlayLoader(context);
      Overlay.of(context).insert(loader);
    }

    SharedPreferences pref = await SharedPreferences.getInstance();
    ModelVerifyOtp? user = ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
    };
    log(user.authToken.toString());

    String url = ApiUrl.homePageApi;
    List<String> types = [];

    if (filterCategory != "") {
      types.add("filter_category=$filterCategory");
    }
    if (dietaries != "") {
      types.add("dietaries=$dietaries");
    }
    if (filter != "") {
      types.add("filter=$filter");
    }
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
    } else {
      if (context != null) {
        Helpers.hideLoader(loader!);
      }
      throw Exception(response.body);
    }
  } catch (e) {
    if (context != null) {
      Helpers.hideLoader(loader!);
    }
    throw Exception(e);
  }
}
