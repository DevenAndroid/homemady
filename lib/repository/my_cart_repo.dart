import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/My_Cart_Model.dart';
import '../model/model_verify_otp.dart';
import '../resources/api_urls.dart';

Future<MyCartModel> myCartRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  try {
    final response =
    await http.get(Uri.parse(ApiUrl.myCartApi), headers: headers);

    if (response.statusCode == 200) {
      log("My Cart Data...${response.body}");
      return MyCartModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
  catch (e) {
    throw Exception(e.toString());
  }
}
