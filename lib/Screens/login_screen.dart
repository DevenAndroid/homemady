import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/resources/add_text.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/login_repository.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: screenHeight,
          child: Stack(
            children:[
              Column(
                children: [
                  Container(
                  width: screenWidth,
                  height: screenHeight*.50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/LoginBackground.png'),
                      fit: BoxFit.fill
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      addHeight(45),
                      Image.asset('assets/images/AppLogo.png',width: 203,),
                      addHeight(85),
                      const Center(
                        child: Text('Login To Your Account',
                          style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'poppinsSans',
                          fontWeight: FontWeight.w600,
                          color:  Color(0xFF66656B),
                        ),),
                      ),
                    ],
                  ),
            ),
                ],
              ),
              Positioned(
                  top: 330,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Form(
                        key: _formKey,
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
                                  color: Colors.white
                              ),
                              child: CommonTextFieldWidget(
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
                            addHeight(15),
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
                                  color: Colors.white
                              ),
                              child: CommonTextFieldWidget(
                                hint: 'Password',
                                controller: passwordController,
                                  validator: (value){
                                  if(value!.isEmpty){
                                    return "Password is required";
                                  }
                                  else{
                                    return null;
                                  }
                                  },
                              ),
                            ),
                            addHeight(30),
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
                            addHeight(23),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
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
                                       const Icon(Icons.facebook,color: Colors.blue,size: 30,),
                                      addWidth(10),
                                      Text('Facebook',style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF4C5369)
                                      ),)
                                    ],
                                  ),
                                ),
                                Container(
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
                                      Text('Google',
                                        style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF4C5369)
                                      ),)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            addHeight(25),
                            InkWell(
                              onTap: (){
                                  Get.toNamed(MyRouters.emailVerificationScreen2);
                              },
                              child: Center(
                                child: Text(
                                  'Forget your Password?',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: const Color(0xFF7ED957)
                                ),
                                ),
                              ),
                            ),
                            addHeight(34),
                            CommonButton(title: 'Login',onPressed: ()  {
                              // var fcmToken = await FirebaseMessaging
                              //     .instance
                              //     .getToken();
                              if(_formKey.currentState!.validate()){

                                loginRepo(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context
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
                                  }
                                });

                              }

                            },),
                            addHeight(36),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Don\'t have an account?',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF3A3737),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14
                                ),
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.toNamed(MyRouters.signupScreen);
                                  },
                                  child:
                                  Text('  Signup',
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xFF69C541),
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
                    )
                    ),
                  )
          ]
          ),
        ),
      ),
    );
  }
}
