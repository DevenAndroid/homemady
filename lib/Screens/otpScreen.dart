import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/repository/resend_otp_repo.dart';
import 'package:homemady/resources/add_text.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:homemady/widgets/dimenestion.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/signup_repository.dart';


class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    text = Get.arguments[0];
  }
  String text = '';
  TextEditingController otpController = TextEditingController();
  final formKey99 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
           Column(
             children: [
               Container(
                 height: AddSize.screenHeight,
                 decoration: const BoxDecoration(
                   gradient: LinearGradient
                     (
                       begin: Alignment.topCenter,
                       end: Alignment.bottomCenter,
                       colors: [
                     Color(0xFF7ED957),
                     Color(0xFF6BD13F)
                   ])
                 ),
                 ),
             ],
           ),
          Positioned(
            top: 55,
            left: 0,
              right: 0,
              child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/otpScreen.png',height: 152,),
              addHeight(20),
              Text('OTP Verification',style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),),
              addHeight(18),
              Text('Enter the OTP Send to Your Phone no.',style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 16,
              ),)
            ],
          )),
          Positioned(
            top: 350,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: AddSize.screenWidth,
                height: AddSize.screenHeight/2,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(88))
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      addHeight(height*0.070),
                      Padding(
                        padding: const EdgeInsets.only(left: 29.0,right: 29),
                        child: Form(
                          key: formKey99,
                          child:  PinCodeTextField(
                            appContext: context,
                            textStyle: const TextStyle(color: Colors.black),
                            controller: otpController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            pastedTextStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "OTP code Required";
                              } else if (v.length != 4) {
                                return "Enter complete OTP code";
                              }
                              return null;
                            },
                            length: 4,
                            pinTheme: PinTheme(
                                shape: PinCodeFieldShape.underline,
                                // borderRadius: BorderRadius.circular(5),
                                fieldWidth: 60,
                                fieldHeight: 50,
                                activeFillColor: Colors.black,
                                inactiveColor:  Colors.grey.shade300,
                                inactiveFillColor: Colors.green,
                                selectedFillColor: Colors.deepPurple,
                                selectedColor: Colors.green,
                                activeColor: Colors.grey.shade300
                            ),
                            cursorColor: Colors.green,
                            keyboardType: TextInputType.number,
                            onChanged: (v) {
                              setState(() {
                                // currentText = v;
                              });
                            },
                          ),
                          // Pinput(
                          //   controller: otpController,
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   keyboardType: TextInputType.number,
                          //   length: 4,
                          //   defaultPinTheme: defaultPinTheme,
                          // ),
                        ),
                      ),
                      addHeight(height*0.040),
                      Center(
                        child: Text('Didn\'t you receive the OTP?',style: GoogleFonts.poppins(
                            fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xFF3D4260)
                        )),
                      ),
                      addHeight(height*0.030),
                      InkWell(
                        onTap: (){
                          resendOtpRepo(email: text, context: context, roleText: '2').then((value) {
                            if(value.status == true){
                              showToast(value.message.toString());
                              Get.toNamed(MyRouters.otpScreen);
                            }
                          });
                        },
                        child: Center(
                          child:  Text('Resend OTP',style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF578AE8)
                          )),
                        ),
                      ),
                      addHeight(height*0.033),
                      Padding(
                        padding:  const EdgeInsets.all(8),
                        child: CommonButton(title: 'Verify OTP',
                         onPressed: (){


                          //print("Hello");
                          if(formKey99.currentState!.validate()){
                            verifyOTPPassword(Get.arguments[0],otpController.text, '2' ,context).then((value) async {
                              if(value.status==true){
                                showToast(value.message);
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                pref.setString(
                                    'user_info', jsonEncode(value));
                                Get.toNamed(MyRouters.bottomNavbar);
                              }
                              else{
                                showToast(value.message);
                              }
                            });
                          }
                         },
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}
