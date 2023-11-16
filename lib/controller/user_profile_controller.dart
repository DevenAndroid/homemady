import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../model/model_verify_otp.dart';
import '../model/user_profile_model.dart';
import '../repository/user_profile_repo.dart';

Future<String?> getMyUserId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  if(pref.getString('user_info') == null)return null;
  ModelVerifyOtp user = ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  return user.data!.id.toString();
}

class UserProfileController extends GetxController {
  Rx<UserProfileModel> model = UserProfileModel().obs;
  RxInt currentIndex = 0.obs;
  RxBool isDataLoading = false.obs;
  RxInt refreshInt = 0.obs;
  Rx<File> image = File("").obs;
  // String myProfileID = "";
  RxString countryCode = "".obs;
  RxString initialCode = "".obs;
  String get myProfileID1 => model.value.data!.id.toString();
  RxString address = "Select address".obs;
  final ImagePicker picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  // FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future getData() async {
    isDataLoading.value = false;
    refreshInt.value = DateTime.now().millisecondsSinceEpoch;
    await userProfileData().then((value1) {
      isDataLoading.value = true;
      model.value = value1;
      refreshInt.value = DateTime.now().millisecondsSinceEpoch;
      if (isDataLoading.value && model.value.data != null) {
        refreshInt.value = DateTime.now().millisecondsSinceEpoch;
        nameController.text = model.value.data!.name.toString();
        emailController.text = model.value.data!.email.toString();
        mobileController.text = model.value.data!.phone.toString();
        for (var element in countries) {
          // print("found info....      ${model.value.data!.countryCode.toString().replaceAll("+", "").trim()}     ${element.dialCode}");
          if (model.value.data!.countryCode.toString().replaceAll("+", "").trim() == element.dialCode) {
            print(
                "found info....      ${model.value.data!.countryCode.toString().replaceAll("+", "").trim()}     ${element.dialCode}");
            initialCode.value = element.code;
            break;
          }
        }
        countryCode.value = model.value.data!.countryCode.toString();
      }
    });
    //loginRepo().
  }
}
