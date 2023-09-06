import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/Social_Login_Model.dart';
import '../model/common_model.dart';
import '../resources/api_urls.dart';

Future<ModelCommonResponse> updateLocation(
    {required latitude,required longitude}) async {
  var map = <String, dynamic>{};
  map['latitude'] = latitude;
  map['longitude'] = longitude;
  log(map.toString());
  SharedPreferences pref = await SharedPreferences.getInstance();
  SocialLoginModel? user =
  SocialLoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  http.Response response = await http.post(Uri.parse(ApiUrl.updateLocationUrl),
      body: jsonEncode(map), headers: headers);
  log(response.body.toString());
  if (response.statusCode == 200 ||response.statusCode == 400) {
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}

