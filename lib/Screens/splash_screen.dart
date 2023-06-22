import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routers/routers.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      // if(pref.getInt("role") == 0){
      Get.offAllNamed(MyRouters.onBoardingScreen);
      // }
      // else if(pref.getInt("role") == 1 ){
      //   Get.offAllNamed(MyRouters.);
      // }else{
      //   Get.offAllNamed(MyRouters.);
      // }

    }
    );
  }


  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          child: Image.asset('assets/images/Splash.png',
            fit: BoxFit.fill,),
        ));
  }

}

