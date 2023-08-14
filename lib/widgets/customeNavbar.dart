
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
      return Scaffold(
          drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 240,
              child: DrawerHeader(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF7ED957),
                          Color(0xFF68C541),
                        ],
                      )),
                  child: Align(
                      alignment: Alignment.center,
                      child: Obx(() {
                        return Column(
                          children: [
                            Obx(() {
                              return Container(
                                margin: const EdgeInsets.all(4),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: const ShapeDecoration(
                                  shape: CircleBorder(),
                                  color: Colors.white,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: profileController.isDataLoading.value
                                      ? (profileController.model.value.data!.profileImage ?? "").toString()
                                      : "assets/images/dummyPerson.png"
                                      "",
                                  height: screenSize.height * 0.12,
                                  width: screenSize.height * 0.12,
                                  errorWidget: (_, __, ___) => const SizedBox(),
                                  placeholder: (_, __) => const SizedBox(),
                                  fit: BoxFit.cover,
                                ),
                              );
                            }),
                            FittedBox(
                              child: Text(
                                  profileController.isDataLoading.value
                                      ? profileController.model.value.data!.email.toString()
                                      : 'williamsjones@gmail.com',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: const Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                            FittedBox(
                              child: Text(
                                  profileController.isDataLoading.value
                                      ? profileController.model.value.data!.name.toString()
                                      : 'Williams Jones',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: const Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                          ],
                        );
                      }))),
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
              leading: Image.asset(
                'assets/images/note-2.png',
                height: 20,
              ),
              title: Text('My Orders',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: const Color(0xFF4F535E),
                    fontWeight: FontWeight.w400,
                  )),
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
              leading: Icon(Icons.favorite_border_outlined),
              title: Text('Favorite',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: const Color(0xFF4F535E),
                    fontWeight: FontWeight.w400,
                  )),
              onTap: () {
                setState(() {
                  currentDrawer = 0;
                  Get.toNamed(MyRouters.favouriteScreen);
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
              title: Text('My profile',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: const Color(0xFF4F535E),
                    fontWeight: FontWeight.w400,
                  )),
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
              title: Text('Notification',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: const Color(0xFF4F535E),
                    fontWeight: FontWeight.w400,
                  )),
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
              title: Text('My Address',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: const Color(0xFF4F535E),
                    fontWeight: FontWeight.w400,
                  )),
              onTap: () {
                setState(() {
                  currentDrawer = 3;
                  Get.to(() => const MyAddressScreen());
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
              title: Text('Refer and Earn',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: const Color(0xFF4F535E),
                    fontWeight: FontWeight.w400,
                  )),
              onTap: () {
                setState(() {
                  currentDrawer = 4;
                  Get.toNamed(MyRouters.referAndEarn);
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
                'assets/images/metro-security.png',
                height: 20,
              ),
              title: Text('Privacy Policy',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: const Color(0xFF4F535E),
                    fontWeight: FontWeight.w400,
                  )),
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
              title: Text('My Chats',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: const Color(0xFF4F535E),
                    fontWeight: FontWeight.w400,
                  )),
              onTap: () {
                setState(() {
                  currentDrawer = 7;
                  Get.toNamed(NotificationScreen2.notificationScreen2);
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
                'assets/images/helpICon.png',
                height: 20,
              ),
              title: Text('Help Center',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: const Color(0xFF4F535E),
                    fontWeight: FontWeight.w400,
                  )),
              onTap: () {
                setState(() {
                  currentDrawer = 8;
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
              title: Text('Logout',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: const Color(0xFF4F535E),
                    fontWeight: FontWeight.w400,
                  )),
              onTap: () {
                setState(() async {
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  pref.clear();
                  Get.toNamed(MyRouters.loginScreen);
                });
              },
            ),
          ],
        ),
      ),
        // drawer:Drawer(
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     children: [
        //       SizedBox(
        //         height: 230,
        //         child: DrawerHeader(
        //             decoration: const BoxDecoration(
        //                 gradient: LinearGradient(
        //                   colors: [
        //                     Color(0xFF7ED957),
        //                     Color(0xFF68C541),
        //                   ],
        //                 )
        //             ),
        //             child: Align(
        //               alignment: Alignment.center,
        //               child: Column(
        //                 children: [
        //                  profileController.isDataLoading.value ?
        //                  ClipRRect(
        //                    borderRadius: BorderRadius.circular(50),
        //                    child: CachedNetworkImage(
        //                       imageUrl: profileController.model.value.data!.profileImage.toString(),
        //                       fit: BoxFit.cover,
        //                       height: 75,
        //                       width: 75,
        //                       errorWidget: (_, __, ___) => Image.asset(
        //                         'assets/images/Ellipse 67.png',
        //                         fit: BoxFit.cover,
        //                         height: 75,
        //                         width: 75,
        //                       ),
        //                       placeholder: (_, __) =>
        //                       const Center(child: CircularProgressIndicator()),
        //                     ),
        //                  ) :  const Center(child: CircularProgressIndicator()),
        //                   profileController.isDataLoading.value ?
        //                   Text(profileController.model.value.data!.name.toString(),
        //                       style: GoogleFonts.poppins(
        //                         fontSize: 18,
        //                         color: const Color(0xFFFFFFFF),
        //                         fontWeight: FontWeight.w600,)): const SizedBox(),
        //                   profileController.isDataLoading.value ?
        //                   Text(profileController.model.value.data!.email.toString(),
        //                       style: GoogleFonts.poppins(
        //                         fontSize: 15,
        //                         color: const Color(0xFFFFFFFF),
        //                         fontWeight: FontWeight.w400,)): const SizedBox(),
        //                 ],
        //               ),
        //             )),
        //       ),
        //       ListTile(
        //         visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
        //         leading: Image.asset(
        //           'assets/images/note-2.png',
        //           height: 20,
        //         ),
        //         title:  Text('My Orders',
        //             style: GoogleFonts.poppins(
        //               fontSize: 15,
        //               color: const Color(0xFF4F535E),
        //               fontWeight: FontWeight.w400,)),
        //         onTap: () {
        //           setState(() {
        //             currentDrawer = 0;
        //             Get.toNamed(MyRouters.myOrderScreen);
        //           });
        //         },
        //       ),
        //       const Divider(
        //         height: 5,
        //         color: Color(0xffEFEFEF),
        //         thickness: 1,
        //       ),
        //       ListTile(
        //         visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
        //         leading: Image.asset(
        //           'assets/images/personImg.png',
        //           height: 20,
        //         ),
        //         title:  Text('My profile',
        //             style: GoogleFonts.poppins(
        //               fontSize: 15,
        //               color: const Color(0xFF4F535E),
        //               fontWeight: FontWeight.w400,)),
        //         onTap: () {
        //           setState(() {
        //             currentDrawer = 1;
        //             Get.toNamed(MyRouters.myProfileScreen);
        //             // Get.to(VendorOrderList());
        //           });
        //         },
        //       ),
        //       const Divider(
        //         height: 5,
        //         color: Color(0xffEFEFEF),
        //         thickness: 1,
        //       ),
        //       ListTile(
        //         visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
        //         leading: Image.asset(
        //           'assets/images/notification-img.png',
        //           height: 20,
        //         ),
        //         title:  Text('Notification',
        //             style: GoogleFonts.poppins(
        //               fontSize: 15,
        //               color: const Color(0xFF4F535E),
        //               fontWeight: FontWeight.w400,)),
        //         onTap: () {
        //           setState(() {
        //             currentDrawer = 2;
        //             Get.toNamed(MyRouters.notificationScreen);
        //           });
        //         },
        //       ),
        //       const Divider(
        //         height: 5,
        //         color: Color(0xffEFEFEF),
        //         thickness: 1,
        //       ),
        //       ListTile(
        //         visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
        //         leading: Image.asset(
        //           'assets/images/location-my.png',
        //           height: 20,
        //         ),
        //         title:  Text('My Address',
        //             style: GoogleFonts.poppins(
        //               fontSize: 15,
        //               color: const Color(0xFF4F535E),
        //               fontWeight: FontWeight.w400,)),
        //         onTap: () {
        //           setState(() {
        //             currentDrawer = 3;
        //             Get.toNamed(MyRouters.myAddressScreen);
        //           });
        //         },
        //       ),
        //       const Divider(
        //         height: 5,
        //         color: Color(0xffEFEFEF),
        //         thickness: 1,
        //       ),
        //       ListTile(
        //         visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
        //         leading: Image.asset(
        //           'assets/images/notebook_reference.png',
        //           height: 20,
        //         ),
        //         title:  Text('Refer and Earn',
        //             style: GoogleFonts.poppins(
        //               fontSize: 15,
        //               color: const Color(0xFF4F535E),
        //               fontWeight: FontWeight.w400,)),
        //         onTap: () {
        //           setState(() {
        //             currentDrawer = 4;
        //             Get.toNamed(MyRouters.referAndEarn);
        //           });
        //         },
        //       ),
        //       // const Divider(
        //       //   height: 5,
        //       //   color: Color(0xffEFEFEF),
        //       //   thickness: 1,
        //       // ),
        //       // ListTile(
        //       //   visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
        //       //   leading: Image.asset(
        //       //     'assets/images/bx_wallet.png',
        //       //     height: 20,
        //       //   ),
        //       //   title:  Text('My Wallet',
        //       //       style: GoogleFonts.poppins(
        //       //         fontSize: 15,
        //       //         color: const Color(0xFF4F535E),
        //       //         fontWeight: FontWeight.w400,)),
        //       //   onTap: () {
        //       //     setState(() {
        //       //       currentDrawer = 5;
        //       //       Get.toNamed(MyRouters.myCartScreen);
        //       //     });
        //       //   },
        //       // ),
        //       const Divider(
        //         height: 5,
        //         color: Color(0xffEFEFEF),
        //         thickness: 1,
        //       ),
        //       ListTile(
        //         visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
        //         leading: Image.asset(
        //           'assets/images/metro-security.png',
        //           height: 20,
        //         ),
        //         title:  Text('Privacy Policy',
        //             style: GoogleFonts.poppins(
        //               fontSize: 15,
        //               color: const Color(0xFF4F535E),
        //               fontWeight: FontWeight.w400,)),
        //         onTap: () {
        //           setState(() {
        //             currentDrawer = 6;
        //             Get.toNamed(MyRouters.privacyPolicy);
        //           });
        //         },
        //       ),
        //       const Divider(
        //         height: 5,
        //         color: Color(0xffEFEFEF),
        //         thickness: 1,
        //       ),
        //       ListTile(
        //         visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
        //         leading: Image.asset(
        //           'assets/images/chatchatting.png',
        //           height: 20,
        //         ),
        //         title:  Text('Message',
        //             style: GoogleFonts.poppins(
        //               fontSize: 15,
        //               color: const Color(0xFF4F535E),
        //               fontWeight: FontWeight.w400,)),
        //         onTap: () {
        //           setState(() {
        //             currentDrawer = 7;
        //             Get.toNamed(MyRouters.chatScreen);
        //           });
        //         },
        //       ),
        //       const Divider(
        //         height: 5,
        //         color: Color(0xffEFEFEF),
        //         thickness: 1,
        //       ),
        //       ListTile(
        //         visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
        //         leading: Image.asset(
        //           'assets/images/help_centerD.png',
        //           height: 18,
        //         ),
        //         title:  Text('Help Center',
        //             style: GoogleFonts.poppins(
        //               fontSize: 15,
        //               color: const Color(0xFF4F535E),
        //               fontWeight: FontWeight.w400,)),
        //         onTap: () {
        //           setState(() {
        //             Get.toNamed(MyRouters.helpCenterScreen);
        //           });
        //         },
        //       ),
        //       const Divider(
        //         height: 5,
        //         color: Color(0xffEFEFEF),
        //         thickness: 1,
        //       ),
        //       ListTile(
        //         visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
        //         leading: Image.asset(
        //           'assets/images/logout.png',
        //           height: 16,
        //         ),
        //         title:  Text('Logout',
        //             style: GoogleFonts.poppins(
        //               fontSize: 15,
        //               color: const Color(0xFF4F535E),
        //               fontWeight: FontWeight.w400,)),
        //         onTap: () {
        //           setState(() async{
        //             SharedPreferences pref = await SharedPreferences.getInstance();
        //             pref.clear();
        //             Get.toNamed(MyRouters.loginScreen);
        //             // Get.to(SettingScreenVendor());
        //           });
        //         },
        //       ),
        //     ],
        //   ),
        // ),
       // key: ,
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
              // TabItem(
              //   icon : Image.asset('assets/images/setting.png'),
              //   title: 'Settings',
              //   activeIcon: Padding(
              //     padding: const EdgeInsets.all(13.0),
              //     child: Image.asset('assets/images/setting.png',color: Colors.white,),
              //   ),
              // ),
            ]
      ));
    });
  }
}
