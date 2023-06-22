import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:homemady/Screens/homePageScreen.dart';
import 'package:homemady/Screens/notificationScreen.dart';
import 'package:homemady/Screens/otpScreen.dart';
import 'package:homemady/Screens/signupScreen.dart';
import '../Screens/onborading_screen.dart';
import '../Screens/splash_screen.dart';
import '../Screens/login_screen.dart';


class MyRouters {
  static var splashScreen = "/splashScreen";
  static var onBoardingScreen = "/onBoardingScreen";
  static var loginScreen = "/loginScreen";
  static var signupScreen = "/signupScreen";
  static var otpScreen = "/otpScreen";
  static var notificationScreen = "/notificationScreen";
  static var homePageScreen = "/homePageScreen";

  static var route = [
  GetPage(name: '/', page: () =>  const SplashScreen()),
  GetPage(name: '/onBoardingScreen', page: () =>  const OnBoardingScreen()),
  GetPage(name: '/loginScreen', page: () => const LoginScreen()),
  GetPage(name: '/signupScreen', page: () => const SignupScreen()),
  GetPage(name: '/otpScreen', page: () => const OtpScreen()),
  GetPage(name: '/notificationScreen', page: () => const NotificationScreen()),
  GetPage(name: '/homePageScreen', page: () => const HomePageScreen()),
  ];
}