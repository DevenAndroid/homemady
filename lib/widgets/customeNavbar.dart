import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/Screens/homePageScreen.dart';
import 'package:homemady/Screens/myOrderScreen.dart';
import 'package:homemady/Screens/myprofileScreen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:homemady/controller/my_order_controller.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import '../Screens/custom_drawer.dart';
import '../Screens/featured_store_list.dart';
import '../Screens/homedetails_Screen.dart';
import '../controller/user_profile_controller.dart';
import '../service/custome_notification_headers.dart';
import 'custome_size.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});
  static var bottomNavbar = "/bottomNavbar";

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final profileController = Get.put(UserProfileController());

  updateInt() {
    profileController.currentIndex.value = 0;
    setState(() {});
  }

  late StreamSubscription<RemoteMessage> streamSubscription;
  late StreamSubscription<RemoteMessage> streamSubscriptionOnOpen;
  final controller = Get.put(MyOrderController());

  onMessage(RemoteMessage event) {
    controller.getData();
    log("Notification received..........   onMessage        ${event.toMap()}");
    // NotificationService()
    //     .showNotificationWithRemoteMessage(remoteMessage: event);
    showNotificationDialog(event);
  }

  onMessageOpenApp(RemoteMessage event) {
    controller.getData();
    log("Notification received..........   onMessageOpenApp        ${event.toMap()}");
    Map<dynamic, dynamic> map = event.data;
    if (map["order_id"] != null) {
      // final orderController = Get.put(MyOrderDetailsController());
      // // orderController.id.value = map["order_id"].toString();
      // Get.to(()=> DriverDeliveryOrderDetails(orderId: map["order_id"].toString(),));
    }
  }

  onBackground(RemoteMessage? event) {
    if (event == null) return;
    Map<dynamic, dynamic> map = event.data;
    if (map["order_id"] != null) {
      // final orderController = Get.put(MyOrderDetailsController());
      // // orderController.id.value = map["order_id"].toString();
      // Get.to(()=> DriverDeliveryOrderDetails(orderId: map["order_id"].toString(),));
    }
    log("Notification received..........   getInitialMessage        ${event.toMap()}");
  }

  notificationHandler() {
    streamSubscription = FirebaseMessaging.onMessage.listen(onMessage);
    streamSubscriptionOnOpen = FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenApp);
    FirebaseMessaging.instance.getInitialMessage().then(onBackground);
  }

  showNotificationDialog(RemoteMessage remoteMessage) {
    showSimpleNotification(
        GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.translucent,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: const Color(0xFF04666E).withOpacity(0.14),
                    spreadRadius: 1.0,
                    blurRadius: 20.0,
                    offset: const Offset(3.0, 3.0))
              ],
            ),
            margin: const EdgeInsets.all(5),
            width: Get.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                addWidth(8),
                Container(
                  height: 60,
                  width: 3,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color(0xff7ED957),
                  ),
                  // child: VerticalDivider(
                  //   color: Color(0xffFF6100),
                  //   thickness: 2.5,
                  // ),
                ),
                const SizedBox(
                  width: 13,
                ),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircleAvatar(
                    backgroundColor: const Color(0xff7ED957),
                    child: Text(
                      remoteMessage.notification!.title == null
                          ? 'B'
                          : remoteMessage.notification!.title.toString().substring(0, 1),
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Text(
                          DateFormat("EEEE, dd MMMM yyyy hh:mm a").format(DateTime.now()),
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff7ED957),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          remoteMessage.notification!.body ?? "",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          remoteMessage.notification!.title ?? "",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        slideDismiss: true,
        duration: const Duration(seconds: 15),
        background: Colors.transparent,
        elevation: 50,
        contentPadding: EdgeInsets.zero);
  }

  StreamSubscription<Map<dynamic, dynamic>>? branchStream;

  void listenDynamicLinks() async {
    branchStream ??= FlutterBranchSdk.listSession().listen((data) async {
      log("branch response.....     $data");
      if (data["shared_store_id"] != null) {
        Get.to(() => HomeDetailsScreen(storeId: data["shared_store_id"].toString()));
      }
    }, onError: (error) {
      if (kDebugMode) {
        print('InitSession error: ${error.toString()}');
      }
    });
  }

  CustomNotificationHeaders customNotificationHeaders = CustomNotificationHeaders();

  @override
  void initState() {
    super.initState();
    notificationHandler();
    listenDynamicLinks();
    controller.getData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileController.getData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription.cancel();
    streamSubscriptionOnOpen.cancel();
    if (branchStream != null) {
      branchStream!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      log("main context available....    $snackBarKey");
      FirebaseMessaging.instance.getToken().then((value) {
        // showLoaderAndHideIt(const RemoteMessage(
        //   notification: RemoteNotification(
        //     title: "kartik",
        //     body: "Ghosh"
        //   )
        // ));
        if (kDebugMode) {
          print("My Token....      $value");
        }
      });
    }
    return WillPopScope(
      onWillPop: () async {
        if (profileController.currentIndex.value != 0) {
          profileController.currentIndex.value = 0;
          return false;
        }
        return true;
      },
      child: Obx(() {
        return Scaffold(
            key: profileController.scaffoldKey,
            drawer: const CustomDrawer(),
            body: [
              const HomePageScreen(),
              StoreListScreen(performAction: (fds) {
                updateInt();
              }),
              MyOrderScreen(performAction: (fds) {
                updateInt();
              }),
              const MyProfileScreen(),
            ][profileController.currentIndex.value].manageNotification(),
            extendBody: true,
            backgroundColor: Colors.white,
            bottomNavigationBar: ConvexAppBar(
                backgroundColor: Colors.white,
                color: const Color(0xFF4E5B5F),
                height: 52,
                top: -18,
                activeColor: const Color(0xFF68C541),
                onTap: (int index) => profileController.currentIndex.value = index,
                items: [
                  TabItem(
                    icon: Image.asset(
                      'assets/images/navbarhome.png',
                      color: const Color(0xFF4E5B5F).withOpacity(0.60),
                    ),
                    title: 'Home',
                    activeIcon: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Image.asset(
                        'assets/images/navbarhome.png',
                      ),
                    ),
                  ),
                  TabItem(
                    icon: Image.asset('assets/images/featured_ic_video_icon.png'),
                    title: 'Featured',
                    activeIcon: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Image.asset(
                        'assets/images/featured_ic_video_icon.png',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TabItem(
                    icon: Image.asset('assets/images/order_icon1.png'),
                    title: 'Orders',
                    activeIcon: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Image.asset(
                        'assets/images/order_icon1.png',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]));
      }),
    );
  }
}
