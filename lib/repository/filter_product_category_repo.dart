import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/filter_product_category_model.dart';
import '../model/model_verify_otp.dart';
import '../model/search_store_model.dart';
import '../resources/api_urls.dart';

Future<FilterProductCategoryModel> filterProductCategoryRepo({
  required distance,
}) async {

  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user = ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  print("${ApiUrl.filterProductCategoryUrl}?filter=$distance");

  try {
    final response = await http.get(Uri.parse("${ApiUrl.filterProductCategoryUrl}?filter=$distance"), headers: headers);
    // log(response.body.toString());
    if (response.statusCode == 200) {
      //Helpers.hideShimmer(loader);
      log("sort stores by category...${response.body}");
      return FilterProductCategoryModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
