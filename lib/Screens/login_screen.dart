import 'dart:convert';
import 'dart:developer';
 import 'package:client_information/client_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
 import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homemady/resources/add_text.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/login_repository.dart';
import '../repository/resend_otp_repo.dart';
import '../repository/social_login_repo.dart';
import 'dart:io';

import '../widgets/new_helper.dart';
import 'otpScreen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String removeFirstLetter(String input) {
    if(input.isEmpty)return input;
    if(input.substring(0,1) != "0") return input;
    return input.substring(1, input.length);

  }
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String roleText = '2';
  var obscureText1 = true;
  String text ="";
  String currentMessage ="";


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Form(
           key: _formKey,
            child: Column(
              children:[
                Stack(
                  children: [
                    SizedBox(
                        height: screenHeight*.35,
                        width: double.maxFinite,
                        child: Image.asset('assets/images/LoginBackground.png',fit: BoxFit.cover,)),
                    SizedBox(
                      width: screenWidth,
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenHeight * .02,
                          ),
                          Image.asset('assets/images/AppLogo.png',width: 203,),
                          SizedBox(
                            height: screenHeight * .05,
                          ),
                          const Center(
                            child: Text('Login To Your Account',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'poppinsSans',
                                fontWeight: FontWeight.w600,
                                color:  Color(0xFF66656B),
                              ),),
                          ),
                          SizedBox(
                            height: screenHeight * .03,
                          ),

                          currentMessage==""?SizedBox():
                          RichText(
                            text: TextSpan(
                              text: 'You are not verify ? ', style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              fontFamily: 'poppinsSans',
                              color:  Color(0xFF333848),
                            ),
                              children:  <TextSpan>[
                                TextSpan(

                                    recognizer: TapGestureRecognizer()..onTap=(){
                                      resendOtpRepo(email: text, context: context, roleText: '2').then((value) {
                                        if(value.status == true){
                                          // showToast(value.message.toString());

                                          Get.toNamed(MyRouters.otpScreen,arguments: [emailController.text.toString()]);
                                        }
                                      });
                                    },
                                    text: 'Resend OTP', style: TextStyle(fontWeight: FontWeight.bold,   color: Colors.redAccent)),

                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child:  Container(
                              width: screenWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF37C666).withOpacity(0.10),
                                    offset: const Offset(.1, .1,
                                    ),
                                    blurRadius: 20.0,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: CommonTextFieldWidget(
                                textInputAction: TextInputAction.next,
                                hint: 'Enter your email or phone number',
                                controller: emailController,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Email or Phone is required";
                                  }
                                  else{
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * .02,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      width: screenWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF37C666).withOpacity(0.10),
                            offset: const Offset(.1, .1,
                            ),
                            blurRadius: 20.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: CommonTextFieldWidget(
                        hint: 'Password',
                        controller: passwordController,
                        obscureText: obscureText1,
                        suffix: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscureText1 = !obscureText1;
                              });
                            },
                            child: obscureText1
                                ? const Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            )
                                : const Icon(
                              Icons.visibility,
                              color: Color(0xFF53B176),
                            )),
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'Please Enter The Password'),
                        ]).call,
                      ),
                    ),

                    SizedBox(
                      height: screenHeight * .03,
                    ),
                    const Center(
                      child: Text(
                        'Or Continue With',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: 'poppinsSans',
                          color:  Color(0xFF333848),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * .03,
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // GestureDetector(
                        //   behavior: HitTestBehavior.translucent,
                        //   onTap: signInWithFacebook,
                        //   child: Container(
                        //     width: 152,
                        //     height: 50,
                        //     decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(10),
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: const Color(0xFF37C666).withOpacity(0.10),
                        //           offset: const Offset(.1, .1,
                        //           ),
                        //           blurRadius: 20.0,
                        //           spreadRadius: 1.0,
                        //         ),
                        //       ],
                        //     ),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         const Icon(Icons.facebook,color: Colors.blue,size: 30,),
                        //         addWidth(10),
                        //         const Text('Facebook',
                        //           style: TextStyle(
                        //               fontSize: 15,
                        //               fontWeight: FontWeight.w600,
                        //               color:  Color(0xFF4C5369)
                        //           ),)
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        if(Platform.isAndroid)
                        Expanded(
                          child: GestureDetector(
                            onTap: signInWithGoogle,
                            child: Container(
                              width: 152,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF37C666).withOpacity(0.10),
                                    offset: const Offset(.1, .1,
                                    ),
                                    blurRadius: 20.0,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/google.png',height: 25,),
                                  addWidth(10),
                                  const Text('Google',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color:  Color(0xFF4C5369)
                                    ),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        addWidth(10),
                        if(Platform.isIOS)
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                loginWithApple();
                              },
                              child: Container(
                                width: 152,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF37C666).withOpacity(0.10),
                                      offset: const Offset(.1, .1,
                                      ),
                                      blurRadius: 20.0,
                                      spreadRadius: 1.0,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/apple.png',height: 25,),
                                    addWidth(10),
                                    const Text('Apple',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color:  Color(0xFF4C5369)
                                      ),)
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * .03,
                    ),
                    InkWell(
                      onTap: (){
                        Get.toNamed(MyRouters.emailVerificationScreen2);
                      },
                      child: const Center(
                        child: Text(
                          'Forget your Password?',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.5,
                              color:  Color(0xFF7ED957)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * .03,
                    ),
                    CommonButton(title: 'Login',onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        var fcmToken = await FirebaseMessaging
                            .instance
                            .getToken();
                        // ignore: use_build_context_synchronously
                        loginRepo(
                            email: removeFirstLetter(emailController.text),
                            password: passwordController.text,
                            context: context,
                          fcmToken: fcmToken!,
                          role: roleText,
                        ).then((value) async {
                          if(value.status==true){
                            SharedPreferences pref =
                            await SharedPreferences
                                .getInstance();
                            pref.setString(
                                'user_info', jsonEncode(value));
                            showToast(value.message);
                            Get.offAllNamed(MyRouters.bottomNavbar);
                          }
                          else if(value.status==false){

                            showToast(value.message);
                            if(value.message=="You are not verified"){
                              currentMessage=value.message!;
                              setState(() {

                              });
                            }
                          }
                        });

                      }

                    },),
                    SizedBox(
                      height: screenHeight * .03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?',
                          style: TextStyle(
                              color: Color(0xFF3A3737),
                              fontWeight: FontWeight.w300,
                              fontSize: 14
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Get.toNamed(MyRouters.signupScreen);
                          },
                          child:
                          const Text('  Signup',
                            style: TextStyle(
                                color: Color(0xFF69C541),
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                ),
            ]
            ),
          ),
        ),
      ),
    );
  }
  signInWithGoogle() async {
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn().catchError((e){
      throw Exception(e);
    });

    log(googleUser!.email.toString());

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final value = await FirebaseAuth.instance.signInWithCredential(credential);

    log("Tokenisss -------${value.credential!.accessToken}");
    // return;
    //log(value.additionalUserInfo.a);
    socialLogin(
        provider: "google",
        token: value.credential!.accessToken!,
        context: context,
        role: roleText
    ).then((value) async {
      if (value.status == true) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('user_info', jsonEncode(value));
        showToast(value.message);
        Get.offAllNamed(MyRouters.bottomNavbar);
      } else {
        showToast(value.message);
      }
    });
  }
  // signInWithFacebook() async {
  //   final facAuth = FacebookAuthProvider();
  //   facAuth.addScope("email");
  //   final item = await FirebaseAuth.instance.signInWithProvider(facAuth);
  //   if(!mounted)return;
  //   socialLogin(provider: "google", token: item.credential!.accessToken!, context: context,role: roleText).then((value) async {
  //     if (value.status == true) {
  //       SharedPreferences pref = await SharedPreferences.getInstance();
  //       pref.setString('user_info', jsonEncode(value));
  //       showToast(value.message);
  //       Get.offAllNamed(MyRouters.bottomNavbar);
  //     } else {
  //       showToast(value.message);
  //     }
  //   });
  // }

  loginWithApple() async {
    log("Hello from apple ");
    final appleProvider =
    AppleAuthProvider().addScope("email").addScope("fullName");
    await FirebaseAuth.instance
        .signInWithProvider(appleProvider)
        .then((value) async {

      log("Tokenisss -------${value.credential!.accessToken}");
      socialLogin( provider: "apple", token: value.credential!.accessToken!, context: context, role: roleText)
          .then((value1) async {
        if (value1.status == true) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString('user_info', jsonEncode(value1));
          // pref.get(value1.authToken!);
          // log("Tokenisss from auth is -------${value1.authToken}");
          showToast(value1.message);
          Get.offAllNamed(MyRouters.bottomNavbar);
          // tokenData().then((value1) async {
          //   SharedPreferences pref = await SharedPreferences.getInstance();
          //   pref.setString('token', jsonEncode(value1));
          // });
        } else {
          showToast(value1.message);
        }
      });
    });
  }
}
