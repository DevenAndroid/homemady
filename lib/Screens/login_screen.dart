import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';


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
                    children: [
                      addHeight(45),
                      Image.asset('assets/images/AppLogo.png',width: 203,),
                      addHeight(60),
                      Center(
                        child: Text('Login To Your Account',
                          style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF66656B),
                        ),),
                      ),
                    ],
                  ),
            ),
                ],
              ),
              Positioned(
                  top: 290,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
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
                              child: CustomTextField(
                                hintText: 'Enter your email or phone number'.obs,
                                obSecure: false.obs,
                                controller: emailController,
                                validator: (value) {

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
                              child: CustomTextField(
                                hintText: 'Password'.obs,
                                obSecure: false.obs,
                                controller: passwordController,

                              ),
                            ),
                            addHeight(20),
                            Center(
                              child: Text(
                                'Or Continue With',style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: const Color(0xFF333848)
                              ),
                              ),
                            ),
                            addHeight(16),
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                         const Icon(Icons.facebook,color: Colors.blue,),
                                        addWidth(10),
                                        Text('Facebook',style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF4C5369)
                                        ),)
                                      ],
                                    ),
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                         Image.asset('assets/images/google.png',height: 20,),
                                        addWidth(10),
                                        Text('Facebook',style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF4C5369)
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            addHeight(20),

                            InkWell(
                              onTap: (){
                                  Get.toNamed(MyRouters.otpScreen);
                              },
                              child: Center(
                                child: Text(
                                  'Forget your Password?',style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: const Color(0xFF7ED957)
                                ),
                                ),
                              ),
                            ),
                            addHeight(30),
                            CommonButton(title: 'Login',onPressed: (){
                              Get.toNamed(MyRouters.homePageScreen);
                            },),
                            addHeight(30),
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
                                  Text('Signup',
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
