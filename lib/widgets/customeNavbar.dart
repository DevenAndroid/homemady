// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:homemady/Screens/login_screen.dart';
// import 'package:homemady/Screens/signupScreen.dart';
//
//
// class CustomNavigationBar extends StatefulWidget {
//   const CustomNavigationBar({
//     Key? key,
//   }) : super(key: key);
//   static var customNavigationBar = "/customNavigationBar";
//
//   @override
//   CustomNavigationBarState createState() => CustomNavigationBarState();
// }
//
// class CustomNavigationBarState extends State<CustomNavigationBar> {
//   // final controller = Get.put(MainHomeController());
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     /*WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       profileController.getData();
//       locationController.checkGps(context);
//       if (goToCart == true) {
//         controller.currentIndex.value = 0;
//         goToCart = false;
//       }
//     });*/
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
//     return WillPopScope(
//       onWillPop: () async {
//         // Get.offNamed(WelcomeScreen.welcomeScreen);
//         return false;
//       },
//       child: Container(
//           color: Colors.orange,
//           child: Stack(children: [
//             Positioned.fill(
//               child: Obx(() {
//                 return Scaffold(
//                   backgroundColor: Colors.transparent,
//                   // key: controller.scaffoldKey,
//                   //   drawer: const CustomDrawer(),
//                   //    drawer: CustomDrawer(),
//                   // controller.currentIndex.value != 1
//                   //     ? buildAppBar(
//                   //     false,
//                   //     controller.currentIndex.value,
//                   //     profileController.isDataLoading.value
//                   //         ? (profileController
//                   //         .model.value.data!.profileImage ??
//                   //         "")
//                   //         .toString()
//                   //         : "")
//                   //     :
//                   /*   bottomNavigationBar: BottomAppBar(
//                       elevation: 20,
//                       color: Colors.white,
//                       shape: const CircularNotchedRectangle(),
//                       clipBehavior: Clip.hardEdge,
//                       child: Theme(
//                           data: ThemeData(
//                               splashColor: Colors.white,
//                               backgroundColor: Colors.white,
//                               bottomNavigationBarTheme:
//                               const BottomNavigationBarThemeData(
//                                   backgroundColor: Colors.white,
//                                   elevation: 0)),
//                           child: BottomNavigationBar(
//                               unselectedLabelStyle: const TextStyle(
//                                   fontSize: 12, fontWeight: FontWeight.w400),
//                               selectedLabelStyle: const TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: AppTheme.primaryColor),
//                               items: [
//                                 const BottomNavigationBarItem(
//                                     icon: CircleAvatar(
//                                       radius: 20,
//                                       backgroundColor: AppTheme.primaryColor,
//                                       child: ImageIcon(
//                                         AssetImage(AppAssets.vector),
//                                         color: Colors.white,
//                                         //size: 16,
//                                       ),
//                                     ),
//                                     label: ''),
//                                 const BottomNavigationBarItem(
//                                   icon: ImageIcon(
//                                     AssetImage(AppAssets.shopping),
//                                     color: Color(0xFF4B606A),
//                                    // size: 2,
//                                   ),
//                                   label: 'Shopping',
//                                 ),
//                                 const BottomNavigationBarItem(
//                                   icon: ImageIcon(
//                                     AssetImage(AppAssets.user),
//                                     color: Color(0xFF4B606A),
//                                    // size: 30,
//                                   ),
//                                   label: 'My Account',
//                                 ),
//                               ],
//                               type: BottomNavigationBarType.fixed,
//                               currentIndex: controller.currentIndex.value,
//                               selectedItemColor: AppTheme.primaryColor,
//                              // iconSize: 40,
//                               onTap: controller.onItemTap,
//                               elevation: 5))),*/
//                   // floatingActionButtonLocation:
//                   // FloatingActionButtonLocation.centerDocked,
//                   // floatingActionButton: Visibility(
//                   //   visible: !keyboardIsOpened,
//                   //   child: Container(
//                   //     height: 55,
//                   //     width: 55,
//                   //     decoration: BoxDecoration(
//                   //         color: AppTheme.blackcolor,
//                   //         borderRadius: BorderRadius.circular(30),
//                   //         border: Border.all(
//                   //             color: AppTheme.backgroundcolor, width: 2)),
//                   //     child: GestureDetector(
//                   //       child: const Center(
//                   //         child: Icon(
//                   //           Icons.home,
//                   //           size: 30,
//                   //           color: AppTheme.backgroundcolor,
//                   //         ),
//                   //       ),
//                   //       onTap: () {
//                   //         controller.onItemTap(1);
//                   //       },
//                   //     ),
//                   //   ),
//                   // ),
//                   bottomNavigationBar: Container(
//                     //margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.1),
//                     color: Colors.white,
//                     height: MediaQuery.of(context).size.height * .08,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Padding(
//                           padding:  EdgeInsets.symmetric(horizontal: 40,),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               GestureDetector(
//                                 onTap: (){
//                                   // controller.onItemTap(0);
//                                 },
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     // controller.currentIndex == 0 ?
//                                     // Container(
//                                     //   padding: EdgeInsets.all(10).copyWith(bottom: 15),
//                                     //   decoration: BoxDecoration(
//                                     //       shape: BoxShape.circle,
//                                     //       color: AppTheme.primaryColor
//                                     //   ),
//                                     //   child: Image.asset(
//                                     //     AppAssets.vector,
//                                     //     color: AppTheme.backgroundcolor,
//                                     //     height: 25,
//                                     //     width: 25,
//                                     //   ),
//                                     // ) :
//                                     Container(
//                                       padding: EdgeInsets.all(10).copyWith(bottom: 15),
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         //color: AppTheme.primaryColor
//                                       ),
//                                       child: Icon(Icons.home_work)
//                                     )
//                                     /* Column(
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Image.asset(
//                                           AppAssets.vector,
//                                           color: AppTheme.bottomNavTextColor,
//                                           height: 25,
//                                           width: 25,
//                                         ),
//                                        *//* SizedBox(
//                                           height: 2,
//                                         ),
//                                         Text(
//                                           "Home",
//                                           style: TextStyle(
//                                               color: AppTheme.bottomNavTextColor,
//                                               fontSize: 10,
//                                               fontWeight: FontWeight.w500),
//                                         )*//*
//                                       ],
//                                     )*/
//                                   ],
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: (){
//                                   // controller.onItemTap(1);
//                                 },
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                    Icon(Icons.add),
//                                     Text(
//                                       "Cart",
//                                       style: TextStyle(
//                                           // color: controller.currentIndex == 1 ? AppTheme.primaryColor : AppTheme.bottomNavTextColor,
//                                         color: Colors.pink,
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.w500),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: (){
//                                   // controller.onItemTap(2);
//                                 },
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                    Icon(Icons.abc),
//                                     Text(
//                                       "My Account",
//                                       style: TextStyle(
//                                           color: Colors.pink,
//                                           // color: controller.currentIndex == 2 ? AppTheme.primaryColor : AppTheme.bottomNavTextColor,
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.w500),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   body: Obx(() {
//                     return Center(
//                       child: [
//                         LoginScreen(),
//                         SignupScreen(),
//                         LoginScreen()
//                       ][controller.currentIndex.value],
//                     );
//                   }),
//                 );
//               }),
//             ),
//           ])),
//     );
//   }
// }
