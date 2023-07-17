
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

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int currentDrawer = 0;
  int selectedTab = 0;
  Rx<int> currentIndex = 0.obs;
  // final itemss = <Widget>[
  //   Image.asset('assets/images/home.png',height: 20,color: Colors.black,),
  //   Image.asset('assets/images/home.png',height: 20,color: Colors.black,),
  //   Image.asset('assets/images/home.png',height: 20,color: Colors.black,),
  //   Image.asset('assets/images/home.png',height: 20,color: Colors.black,),
  //
  // ];

  // List<TabItem> items = const [
  //
  //   TabItem(
  //     icon : Icons.home_filled,
  //     title: 'Home',
  //   ),
  //   TabItem(
  //     icon: Icons.featured_video,
  //     title: 'Featured',
  //   ),
  //   TabItem(
  //     icon: Icons.list_alt,
  //     title: 'Orders',
  //   ),
  //   TabItem(
  //     icon: Icons.settings,
  //     title: 'Settings',
  //   ),
  // ];

  List screens = [
    const HomePageScreen(),
    const AddNewCardScreen(),
    const MyOrderScreen(),
    const MyProfileScreen(),
  ];



  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        drawer:Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 230,
                child: DrawerHeader(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF7ED957),
                            Color(0xFF68C541),
                          ],
                        )
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/Ellipse 67.png',
                            height: 100,
                          ),
                          Text('Williams Jones',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w600,)),
                          Text('williamsjones@gmail.com',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w400,)),
                        ],
                      ),
                    )),
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                leading: Image.asset(
                  'assets/images/note-2.png',
                  height: 20,
                ),
                title:  Text('My Orders',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF4F535E),
                      fontWeight: FontWeight.w400,)),
                onTap: () {
                  setState(() {
                    currentDrawer = 0;
                    Get.toNamed(MyRouters.myOrderScreen);
                  });
                },
              ),
              const Divider(
                height: 5,
                color: Color(0xffEFEFEF),
                thickness: 1,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                leading: Image.asset(
                  'assets/images/personImg.png',
                  height: 20,
                ),
                title:  Text('My profile',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF4F535E),
                      fontWeight: FontWeight.w400,)),
                onTap: () {
                  setState(() {
                    currentDrawer = 1;
                    Get.toNamed(MyRouters.myProfileScreen);
                    // Get.to(VendorOrderList());
                  });
                },
              ),
              const Divider(
                height: 5,
                color: Color(0xffEFEFEF),
                thickness: 1,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                leading: Image.asset(
                  'assets/images/notification-img.png',
                  height: 20,
                ),
                title:  Text('Notification',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF4F535E),
                      fontWeight: FontWeight.w400,)),
                onTap: () {
                  setState(() {
                    currentDrawer = 2;
                    Get.toNamed(MyRouters.notificationScreen);
                  });
                },
              ),
              const Divider(
                height: 5,
                color: Color(0xffEFEFEF),
                thickness: 1,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                leading: Image.asset(
                  'assets/images/location-my.png',
                  height: 20,
                ),
                title:  Text('My Address',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF4F535E),
                      fontWeight: FontWeight.w400,)),
                onTap: () {
                  setState(() {
                    currentDrawer = 3;
                    Get.toNamed(MyRouters.myAddressScreen);
                  });
                },
              ),
              const Divider(
                height: 5,
                color: Color(0xffEFEFEF),
                thickness: 1,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                leading: Image.asset(
                  'assets/images/notebook_reference.png',
                  height: 20,
                ),
                title:  Text('Refer and Earn',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF4F535E),
                      fontWeight: FontWeight.w400,)),
                onTap: () {
                  setState(() {
                    currentDrawer = 4;
                    Get.toNamed(MyRouters.referAndEarn);
                  });
                },
              ),
              // const Divider(
              //   height: 5,
              //   color: Color(0xffEFEFEF),
              //   thickness: 1,
              // ),
              // ListTile(
              //   visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
              //   leading: Image.asset(
              //     'assets/images/bx_wallet.png',
              //     height: 20,
              //   ),
              //   title:  Text('My Wallet',
              //       style: GoogleFonts.poppins(
              //         fontSize: 15,
              //         color: const Color(0xFF4F535E),
              //         fontWeight: FontWeight.w400,)),
              //   onTap: () {
              //     setState(() {
              //       currentDrawer = 5;
              //       Get.toNamed(MyRouters.myCartScreen);
              //     });
              //   },
              // ),
              const Divider(
                height: 5,
                color: Color(0xffEFEFEF),
                thickness: 1,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                leading: Image.asset(
                  'assets/images/metro-security.png',
                  height: 20,
                ),
                title:  Text('Privacy Policy',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF4F535E),
                      fontWeight: FontWeight.w400,)),
                onTap: () {
                  setState(() {
                    currentDrawer = 6;
                    Get.toNamed(MyRouters.privacyPolicy);
                  });
                },
              ),
              const Divider(
                height: 5,
                color: Color(0xffEFEFEF),
                thickness: 1,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                leading: Image.asset(
                  'assets/images/chatchatting.png',
                  height: 20,
                ),
                title:  Text('Message',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF4F535E),
                      fontWeight: FontWeight.w400,)),
                onTap: () {
                  setState(() {
                    currentDrawer = 7;
                    Get.toNamed(MyRouters.chatScreen);
                  });
                },
              ),
              const Divider(
                height: 5,
                color: Color(0xffEFEFEF),
                thickness: 1,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                leading: Image.asset(
                  'assets/images/help_centerD.png',
                  height: 18,
                ),
                title:  Text('Help Center',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF4F535E),
                      fontWeight: FontWeight.w400,)),
                onTap: () {
                  setState(() {
                    Get.toNamed(MyRouters.helpCenterScreen);
                  });
                },
              ),
              const Divider(
                height: 5,
                color: Color(0xffEFEFEF),
                thickness: 1,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                leading: Image.asset(
                  'assets/images/logout.png',
                  height: 16,
                ),
                title:  Text('Logout',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF4F535E),
                      fontWeight: FontWeight.w400,)),
                onTap: () {
                  setState(() async{
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    pref.clear();
                    Get.toNamed(MyRouters.loginScreen);
                    // Get.to(SettingScreenVendor());
                  });
                },
              ),
            ],
          ),
        ),
        body: screens[currentIndex.value],
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
              TabItem(
                icon : Image.asset('assets/images/setting.png'),
                title: 'Settings',
                activeIcon: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Image.asset('assets/images/setting.png',color: Colors.white,),
                ),
              ),
            ]
      ));
    });
  }
}
