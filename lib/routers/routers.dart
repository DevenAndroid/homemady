import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:homemady/Screens/checkoutScreen.dart';
import 'package:homemady/Screens/homePageScreen.dart';
import 'package:homemady/Screens/homedetails_Screen.dart';
import 'package:homemady/Screens/myAddressScreen.dart';
import 'package:homemady/Screens/mycart_Screen.dart';
import 'package:homemady/Screens/notificationScreen.dart';
import 'package:homemady/Screens/otpScreen.dart';
import 'package:homemady/Screens/signupScreen.dart';
import 'package:homemady/Screens/thankyou_Screen.dart';
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
  static var thankYouScreen = "/thankYouScreen";
  static var myCartScreen = "/myCartScreen";
  static var homeDetailsScreen = "/homeDetailsScreen";
  static var checkOutScreen = "/checkOutScreen";
  static var myAddressScreen = "/myAddressScreen";


  static var route = [
  GetPage(name: '/', page: () =>  const SplashScreen()),
  GetPage(name: '/onBoardingScreen', page: () =>  const OnBoardingScreen()),
  GetPage(name: '/loginScreen', page: () => const LoginScreen()),
  GetPage(name: '/signupScreen', page: () => const SignupScreen()),
  GetPage(name: '/otpScreen', page: () => const OtpScreen()),
  GetPage(name: '/notificationScreen', page: () => const NotificationScreen()),
  GetPage(name: '/homePageScreen', page: () => const HomePageScreen()),
  GetPage(name: '/thankYouScreen', page: () => const ThankYouScreen()),
  GetPage(name: '/myCartScreen', page: () => const MyCartScreen()),
  GetPage(name: '/homeDetailsScreen', page: () => const HomeDetailsScreen()),
  GetPage(name: '/checkOutScreen', page: () => const CheckOutScreen()),
  GetPage(name: '/myAddressScreen', page: () => const MyAddressScreen()),



  ];
}