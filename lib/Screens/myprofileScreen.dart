import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/widgets/app_assets.dart';
import 'package:homemady/widgets/app_theme.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:homemady/widgets/dimenestion.dart';
import 'package:homemady/widgets/editprofiletextfiled.dart';
import 'package:homemady/widgets/new_helper.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/user_profile_controller.dart';
import '../repository/update_profile_repo.dart';
import '../repository/user_profile_repo.dart';
import '../resources/add_text.dart';



class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
   final controller = Get.put(UserProfileController());
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getData();
    });


  }
  final _formKey = GlobalKey<FormState>();
  Rx<File> image = File("").obs;
  final ImagePicker picker = ImagePicker();
  showUploadWindow() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AddSize.padding16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AddSize.size10),
                    Text("Choose From Which",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: AddSize.font16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          child: Text("Gallery",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.primaryColor,
                                  fontSize: AddSize.font14)),
                          onPressed: () {
                            NewHelper().addFilePicker().then((value) {
                              image.value = value!;
                            });
                            Get.back();
                          },
                        ),
                        TextButton(
                          child: Text("Camera",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.primaryColor,
                                  fontSize: AddSize.font14)),
                          onPressed: () {
                            NewHelper()
                                .addImagePicker(imageSource: ImageSource.camera)
                                .then((value) {
                              image.value = value!;
                            });
                            Get.back();
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AddSize.size20,
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      body: Obx(() {
        return  controller.isDataLoading.value
            ? Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                      top: -height * .02,
                      left:  width* .24,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppAssets.profileIcon1)
                            )
                        ),
                      )),
                  Positioned(
                      top:  -height * .01,
                      left: -width * .05,
                      child: Container(
                        height: 150,
                        width: 140,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppAssets.profileIcon2),
                            )
                        ),
                      )),
                  Positioned(
                      top: -height * .08,
                      right: -width * .04,
                      child: Container(
                        height: 285,
                        width: 180,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppAssets.profileIcon3,)

                            )
                        ),
                      )),
                  Positioned(
                      top: height * .11,
                      //bottom: 10,
                      left: width * .35,
                      //right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.peachColor,
                        ),
                        height: 120,
                        width: 120,
                        child: CircleAvatar(
                            backgroundColor: AppTheme.peachColor,
                            radius: 20,
                            child: Container(
                              // margin: const EdgeInsets.only(bottom: 32),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: const ShapeDecoration(
                                shape: CircleBorder(),
                                // color: Colors.white,
                              ),
                              child: controller.image.value.path == "" ?
                                  controller.model.value.data!.profileImage!.isEmpty ||
                                      controller.model.value.data!.profileImage! == 'https://homemady.eoxyslive.com/uploads/profile-images/1689241368-wtp.jpg' ?
                                  const SizedBox(
                                    height: 100,
                                    width: 100,
                                  ) :
                                  Image.network(
                                    controller.model.value.data!
                                        .profileImage
                                        .toString(),
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: 100,
                                  )
                                  //ClipOval(child: Image.asset('assets/images/image 13.png',height: 98,))
                                  : Image.file(
                                controller.image.value,
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                              ),
                            )),
                      )),
                  Positioned(
                      right: width * .35,
                      top: height * .21,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          //color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              showUploadWindow();
                            },
                            child: const Image(
                                height: 45,
                                width: 45,
                                image: AssetImage(
                                    AppAssets.cameraImage)),
                          ),
                        ),
                      )),
                  Positioned.fill(
                    top: height * .25,
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            addHeight(20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  controller.model.value.data!.name == null ? 'Test Customer' :
                                    '${controller.model.value.data!.name}',
                                  style: GoogleFonts.alegreyaSans(
                                    color: const Color(0xFF000000),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700
                                  )
                                ),
                                addHeight(2),
                                Text(
                                  "Edit Profile",
                                    style: GoogleFonts.alegreyaSans(
                                        color: const Color(0xFFADADB8),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500
                                    )
                                ),
                                // const SizedBox(
                                //   height: 20,
                                // ),
                              ],
                            ),
                            SizedBox(height: height* .02,),
                            Expanded(
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            /*Text(
                                              "First name".tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,color: const Color(0xff828282)),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const EditProfileTextFieldWidget(
                                              hint: "Eljad ",
                                              // controller: controller.firstNameController,
                                              // validator: validateName,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),*/
                                            Text(
                                              "Name",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,color: const Color(0xff828282)),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                             EditProfileTextFieldWidget(
                                              hint: "Enter Your Name",
                                               controller: controller.nameController,
                                               validator: validateName,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              "E-mail",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,color: const Color(0xff828282)),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                             EditProfileTextFieldWidget(
                                              hint: "Enter Your Email",
                                              controller: controller.emailController,
                                              readOnly: true,
                                               validator: validateEmail,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              "Mobile Number",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,color: const Color(0xff828282)),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                             EditProfileTextFieldWidget(
                                              hint: "Enter Your Mobile Number",
                                               controller: controller.mobileController,
                                               validator: validateMobile,
                                              keyboardType: TextInputType.number,
                                              length: 10,
                                            ),
                                            const SizedBox(
                                              height: 40,
                                            ),
                                            CommonButton(title: 'Save',onPressed: (){
                                              if(_formKey.currentState!.validate()){
                                                Map<String,String> mapData ={
                                                  'name' : controller.nameController.text,
                                                  'email' : controller.emailController.text,
                                                  'phone' : controller.mobileController.text,
                                                };
                                                editUserProfileRepo(
                                                  context: context,
                                                  mapData: mapData,
                                                  fieldName1: 'profile_image',
                                                  file1: controller.image.value).then((value) {
                                                  showToast(value.message);
                                                  if(value.status == true){
                                                    controller.getData();
                                                  }
                                                  else{
                                                    showToast(value.message);
                                                  }
                                                });
                                              }
                                              else {}
                                            },),
                                            const SizedBox(
                                              height: 90,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                    ),)
                ],
              ),
            ),

          ],
        ) : const Center(child:  CircularProgressIndicator()) ;
      }),
    );
  }

}


