import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homemady/repository/forgot_password_repo.dart';
import 'package:homemady/resources/add_text.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';


class EmailVerificationScreen2 extends StatefulWidget {
  const EmailVerificationScreen2({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen2> createState() => _EmailVerificationScreen2State();
}

class _EmailVerificationScreen2State extends State<EmailVerificationScreen2> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
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
                      height: screenHeight*.40,
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
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 260,
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
                              const Center(
                                child: Text('Enter The Email Address Associated With Your Account',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'poppinsSans',
                                    fontWeight: FontWeight.w600,
                                    color:  Color(0xFF66656B),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              addHeight(22),
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
                                  hint: 'Phone Number',
                                  controller: emailController,
                                  // validator: MultiValidator([
                                  //   EmailValidator(
                                  //       errorText:
                                  //       'enter a valid email address'),
                                  //   RequiredValidator(
                                  //       errorText: 'Please enter a email')
                                  // ]),
                                ),
                              ),
                              addHeight(25),
                              CommonButton(title: 'Send',onPressed: (){
                                if(_formKey.currentState!.validate()){
                                  forgotPasswordRepo(email: emailController.text, context: context, roleText: '2').then((value) {
                                    if(value.status == true){
                                      showToast(value.message.toString());
                                      Get.toNamed(MyRouters.otpForgotScreen,arguments: emailController.text);
                                    }
                                  });
                                }
                              },),
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
