import 'dart:async';
import 'dart:developer';
import 'package:client_information/client_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routers/routers.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  void initState() {
    super.initState();
    _getClientInformation();
    Timer(const Duration(seconds: 3), () async {
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
  Future<void> _getClientInformation() async {
    ClientInformation? info;
    try {
      info = await ClientInformation.fetch();
    } on PlatformException {
      log('Failed to get client information');
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('deviceId', info!.deviceId.toString());
  }

  @override
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

