import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homemady/widgets/app_theme.dart';
import 'package:homemady/widgets/custome_size.dart';
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
      if (pref.getString('user_info') != null) {
        Get.offAllNamed(MyRouters.bottomNavbar);
      }
      else{
        Get.offAllNamed(MyRouters.onBoardingScreen);
      }
    }

    );
  }


  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: const Color(0xFF7ED957),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0  ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Image.asset('assets/images/Group 1000004174.png',),
             addHeight(40),
             const Text('HomeMade Food. A la carte, Catering and Meal Prep. Collection, Instant or Scheduled Delivery',
                style: TextStyle(
                   color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 21,
                  fontFamily: 'alegreyaSans'
                ),
               textAlign: TextAlign.center,
              )
            ],
          ),
        )
    );
  }

}

