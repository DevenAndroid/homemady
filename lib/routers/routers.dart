import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:homemady/Screens/add_new_card.dart';
import 'package:homemady/Screens/address_select.dart';
import 'package:homemady/Screens/change_password_screen.dart';
import 'package:homemady/Screens/chat_message.dart';
import 'package:homemady/Screens/chat_screen.dart';
import 'package:homemady/Screens/checkoutScreen.dart';
import 'package:homemady/Screens/email_verification2.dart';
import 'package:homemady/Screens/email_verification_screen.dart';
import 'package:homemady/Screens/favourite_screen.dart';
import 'package:homemady/Screens/feedback_screen.dart';
import 'package:homemady/Screens/homePageScreen.dart';
import 'package:homemady/Screens/homedetails_Screen.dart';
import 'package:homemady/Screens/myAddressScreen.dart';
import 'package:homemady/Screens/myOrderScreen.dart';
import 'package:homemady/Screens/my_addresss.dart';
import 'package:homemady/Screens/mycart_Screen.dart';
import 'package:homemady/Screens/myprofileScreen.dart';
import 'package:homemady/Screens/notificationScreen.dart';
import 'package:homemady/Screens/onborading_screen.dart';
import 'package:homemady/Screens/orderDetailsScreen.dart';
import 'package:homemady/Screens/otpScreen.dart';
import 'package:homemady/Screens/otp_forgot.dart';
import 'package:homemady/Screens/privacy_policies.dart';
import 'package:homemady/Screens/refer_and_earn.dart';
import 'package:homemady/Screens/review_screen.dart';
import 'package:homemady/Screens/signupScreen.dart';
import 'package:homemady/Screens/splash_screen.dart';
import 'package:homemady/Screens/thankyou_Screen.dart';
import 'package:homemady/myorderScreens/activeScreen.dart';
import 'package:homemady/widgets/customeNavbar.dart';
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
  static var myOrderScreen = "/myOrderScreen";
  static var bottomNavbar = "/bottomNavbar";
  static var activeScreen = "/activeScreen";
  static var myProfileScreen = "/myProfileScreen";
  static var orderDetailsScreen = "/orderDetailsScreen";
  static var emailVerificationScreen = "/emailVerificationScreen";
  static var changePasswordScreen = "/changePasswordScreen";
  static var emailVerificationScreen2 = "/emailVerificationScreen2";
  static var otpForgotScreen = "/otpForgotScreen";
  static var addNewCardScreen = "/addNewCardScreen";
  static var selectAddressScreen = "/selectAddressScreen";
  static var chooseAddress = "/chooseAddress";
  static var chatScreen = "/chatScreen";
  static var chatMessageScreen = "/chatMessageScreen";
  static var reviewScreen = "/reviewScreen";
  static var favouriteScreen = "/favouriteScreen";
  static var referAndEarn = "/referAndEarn";
  static var privacyPolicy = "/privacyPolicy";
  static var feedBackScreen = "/feedBackScreen";


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
  GetPage(name: '/myOrderScreen', page: () => const MyOrderScreen()),
  GetPage(name: '/bottomNavbar', page: () => const BottomNavbar()),
  GetPage(name: '/activeScreen', page: () => const ActiveScreen()),
  GetPage(name: '/myProfileScreen', page: () => const MyProfileScreen()),
  GetPage(name: '/orderDetailsScreen', page: () => const OrderDetailsScreen()),
  GetPage(name: '/emailVerificationScreen', page: () => const EmailVerificationScreen()),
  GetPage(name: '/changePasswordScreen', page: () => const ChangePasswordScreen()),
  GetPage(name: '/emailVerificationScreen2', page: () => const EmailVerificationScreen2()),
  GetPage(name: '/otpForgotScreen', page: () => const OtpForgotScreen()),
  GetPage(name: '/addNewCardScreen', page: () => const AddNewCardScreen()),
  GetPage(name: '/selectAddressScreen', page: () => const SelectAddressScreen()),
  GetPage(name: '/chooseAddress', page: () => const ChooseAddress()),
  GetPage(name: '/chatScreen', page: () => const ChatScreen()),
  GetPage(name: '/chatMessageScreen', page: () => const ChatMessageScreen()),
  GetPage(name: '/reviewScreen', page: () => const ReviewScreen()),
  GetPage(name: '/favouriteScreen', page: () => const FavouriteScreen()),
  GetPage(name: '/referAndEarn', page: () => const ReferAndEarn()),
  GetPage(name: '/privacyPolicy', page: () => const PrivacyPolicy()),
  GetPage(name: '/feedBackScreen', page: () => const FeedBackScreen()),




  ];
}