
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../model/user_profile_model.dart';
import '../repository/user_profile_repo.dart';

class UserProfileController extends GetxController{

  Rx<UserProfileModel> model = UserProfileModel().obs;
  RxBool isDataLoading = false.obs;
  Rx<File> image = File("").obs;
  final ImagePicker picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
 // FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  getData(){
    isDataLoading.value = false;
    userProfileData().then((value1) {
      isDataLoading.value = true;
      model.value = value1;
      if(isDataLoading.value && model.value.data != null){
        nameController.text = model.value.data!.name.toString();
        emailController.text = model.value.data!.email.toString();
        mobileController.text = model.value.data!.phone.toString();
      }
    });
    //loginRepo().
  }






}