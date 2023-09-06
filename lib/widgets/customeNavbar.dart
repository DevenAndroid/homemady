
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/Screens/add_new_card.dart';
import 'package:homemady/Screens/homePageScreen.dart';
import 'package:homemady/Screens/myOrderScreen.dart';
import 'package:homemady/Screens/myprofileScreen.dart';
import 'package:homemady/controller/bottomNavbarController.dart';
import 'package:homemady/routers/routers.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/custom_drawer.dart';
import '../Screens/featured_store_list.dart';
import '../Screens/myAddressScreen.dart';
import '../Screens/notification2.dart';
import '../controller/user_profile_controller.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final profileController = Get.put(UserProfileController());

  int currentDrawer = 0;
  int selectedTab = 0;
  RxInt currentIndex = 0.obs;

  updateInt(){
    currentIndex.value = 0;
    setState(() {});
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileController.getData();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final screenSize = MediaQuery.of(context).size;
      return Scaffold(key: profileController.scaffoldKey,
          drawer: const CustomDrawer(),
        body: [
          const HomePageScreen(),
          StoreListScreen(performAction: (fds){
            updateInt();
          }),
          const MyOrderScreen(),
          const MyProfileScreen(),
        ][currentIndex.value],
        extendBody: true,
        backgroundColor: Colors.white,
        bottomNavigationBar:  ConvexAppBar(
          backgroundColor: Colors.white,
            color: const Color(0xFF4E5B5F),
            height: 52,
            top: -18,
            activeColor: const Color(0xFF68C541),
            onTap: (int index) => currentIndex.value = index,
            items: [
            TabItem(
                icon : Image.asset('assets/images/navbarhome.png',color: const Color(0xFF4E5B5F).withOpacity(0.60),),
                title: 'Home',
              activeIcon: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Image.asset('assets/images/navbarhome.png',),
              ),
              ),
              TabItem(
                icon:  Image.asset('assets/images/featured_ic_video_icon.png'),
                title: 'Featured',
                activeIcon: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Image.asset('assets/images/featured_ic_video_icon.png',color: Colors.white,),
                ),
              ),
              TabItem(
                icon : Image.asset('assets/images/order_icon1.png'),
                title: 'Orders',
                activeIcon: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Image.asset('assets/images/order_icon1.png',color: Colors.white,),
                ),
              ),
            ]
      ));
    });
  }
}
