import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/Screens/subscription_screen.dart';
import 'package:homemady/Screens/thankyou_screen2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/subscription_list_controller.dart';
import '../controller/user_profile_controller.dart';
import '../routers/routers.dart';
import '../widgets/app_theme.dart';
import 'myAddressScreen.dart';
import 'notification2.dart';

class CustomDrawer extends StatefulWidget {

  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final profileController = Get.put(UserProfileController());
  final controller = Get.put(SubscriptionListController());


  @override
  void initState() {
    super.initState();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Drawer(
      child: Obx(() {
        return
          Container(
            color: AppTheme.backgroundcolor,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Container(
                    height: screenSize.height * 0.28,
                    width: screenSize.width,
                decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF7ED957),
                                            Color(0xFF68C541),
                                          ],
                                        ),
                ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.05,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Get.to(navigationPage.elementAt(_currentPage))
                              // Get.to(MyProfile());
                            },
                            child: Card(
                                elevation: 3,
                                shape: const CircleBorder(),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Container(
                                    margin: const EdgeInsets.all(4),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: const ShapeDecoration(
                                      shape: CircleBorder(),
                                      color: Colors.white,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      profileController.isDataLoading.value
                                          ? (profileController.model.value.data!
                                          .profileImage ??
                                          "")
                                          .toString()
                                          : "assets/images/user_img.png",
                                      height: screenSize.height * 0.12,
                                      width: screenSize.height * 0.12,
                                      errorWidget: (_, __, ___) => Image.asset(
                                        'assets/images/user_img.png',
                                        fit: BoxFit.cover,
                                        height: 50,
                                        width: 50,
                                      ),
                                      placeholder: (_, __) => const SizedBox(),
                                      fit: BoxFit.cover,
                                    ))),
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        Text(
                            profileController.isDataLoading.value
                                ? (profileController.model.value.data!.name ?? "")
                                .toString().capitalizeFirst.toString()
                                : "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                        Text(
                            profileController.isDataLoading.value
                                ? (profileController.model.value.data!.email ??
                                "")
                                .toString()
                                : "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    // height: SizeConfig.heightMultiplier! * .5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        _drawerTile(
                            active: true,
                            title: "My Orders",
                            icon: const ImageIcon(
                              AssetImage('assets/images/note-2.png'),
                              size: 22,
                              color: Color(0xFF4F535E),
                            ),
                            onTap: () {
                              profileController.currentIndex.value = 2;
                               Get.toNamed(MyRouters.bottomNavbar);
                               Get.back();
                              // }
                            }),
                        const Divider(
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15,top: 15,bottom: 12,left: 15),
                          child: InkWell(
                            onTap: (){
                              Get.toNamed(MyRouters.favouriteScreen);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.favorite_border, color:  Color(0xFF4F535E),),
                                const SizedBox(width: 25,),
                                Text("Favorites".tr, style: GoogleFonts.ibmPlexSansArabic(
                                    color: const Color(0xFF4F535E),fontSize: 15
                                ),),
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "My Profile",
                            icon: const ImageIcon(
                              AssetImage('assets/images/personImg.png'),
                              size: 22,
                              color: Color(0xFF4F535E),
                            ),
                            onTap: () async {
                              Get.toNamed(MyRouters.myProfileScreen);
                            }),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "Notifications",
                            icon: const ImageIcon(
                              AssetImage('assets/images/notification-img.png'),
                              size: 22,
                              color: Color(0xFF4F535E),
                            ),
                            onTap: () {
                              Get.toNamed(MyRouters.notificationScreen);
                              // }
                            }),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "My Address",
                            icon: const ImageIcon(
                              AssetImage('assets/images/location-my.png'),
                              size: 22,
                              color: Color(0xFF4F535E),
                            ),
                            onTap: () {
                              Get.to(() => const MyAddressScreen());
                              // Get.back();
                              // widget.onItemTapped(1);
                            }),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "Refer and Earn",
                            icon: const ImageIcon(
                              AssetImage('assets/images/notebook_reference.png'),
                              size: 22,
                              color: Color(0xFF4F535E),
                            ),
                            onTap: () async {
                              Get.toNamed(MyRouters.referAndEarn);
                              // }
                            }),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "Subscriptions",
                            icon: const ImageIcon(
                              AssetImage('assets/images/subscription.png'),
                              size: 22,
                              color: Color(0xFF4F535E),
                            ),
                            onTap: () async {
                             if( controller.model.value.data![0].status == "Active"){
                               Get.toNamed(ThankYouScreen2.thankYouScreen2);
                             }
                             else{
                               Get.toNamed(SubscriptionScreen.subscriptionScreen);
                             }


                              // }
                            }),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "Privacy Policy",
                            icon: const ImageIcon(
                              AssetImage('assets/images/metro-security.png'),
                              size: 22,
                              color: Color(0xFF4F535E),
                            ),
                            onTap: () async {
                              Get.toNamed(MyRouters.privacyPolicy);
                              // }
                            }),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "My Chats",
                            icon: const ImageIcon(
                              AssetImage('assets/images/chatchatting.png'),
                              size: 22,
                              color: Color(0xFF4F535E),
                            ),
                            onTap: () async {
                              Get.toNamed(NotificationScreen2.notificationScreen2);
                              // }
                            }),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "Help Center",
                            icon: const ImageIcon(
                              AssetImage('assets/images/helpICon.png'),
                              size: 22,
                              color: Color(0xFF4F535E),
                            ),
                            onTap: () async {
                              Get.toNamed(MyRouters.helpCenterScreen);
                              // }
                            }),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "Logout",
                            icon: const ImageIcon(
                              AssetImage('assets/images/logout.png'),
                              size: 22,
                              color: Color(0xFF4F535E),
                            ),
                            onTap: () async {
                              setState(() async {
                                SharedPreferences pref = await SharedPreferences.getInstance();
                                pref.clear();
                                Get.toNamed(MyRouters.loginScreen);
                              });
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
      }),
    );
  }


  Widget _drawerTile(
      {required bool active,
        required String title,
        required ImageIcon icon,
        required VoidCallback onTap}) {
    return ListTile(
      selectedTileColor: AppTheme.primaryColor,
      leading: icon,
      minLeadingWidth: 30,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF4F535E),
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: active ? onTap : null,
    );
  }
}
