import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homemady/Screens/homePageScreen.dart';
import 'package:homemady/Screens/myAddressScreen.dart';
import 'package:homemady/Screens/myOrderScreen.dart';
import 'package:homemady/controller/bottomNavbarController.dart';



class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final bottomController = Get.put(BottomNavBarController());



  final pages = [
    const
    HomePageScreen(),
    MyAddressScreen(),
    MyOrderScreen(),
    HomePageScreen(),

  ];



  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(


        body: pages.elementAt(bottomController.pageIndex.value),
        extendBody: true,
        // extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        bottomNavigationBar: buildMyNavBar(context),
      );
    });
  }

  buildMyNavBar(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.maxFinite,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: MaterialButton(
                      padding: const EdgeInsets.only(bottom: 10),
                      onPressed: () {
                        bottomController.updateIndexValue(0);

                      },

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          bottomController. pageIndex.value == 0
                              ?  Container(
                            height: 35,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF7ED957),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Image.asset('assets/images/home.png',
                            color: Colors.white,
                            height: 20,
                          ),
                                ),
                              )
                              : Image.asset('assets/images/home.png',
                            color: const Color(0xFF4E5B5F),
                            height: 20,
                          ),

                         const Center(child: Text("  Home",style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w400),))

                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: MaterialButton(
                      padding: const EdgeInsets.only(bottom: 10),
                      onPressed: () {
                        bottomController.updateIndexValue(1);

                      },
                      child: Column(
                        children: [

                          bottomController. pageIndex.value == 1
                              ? Container(
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                                child: Center(
                                  child: Image.asset('assets/images/featured_ic_video.png',
                            height: 20,
                          ),
                                ),
                              )
                              :  Image.asset('assets/images/featured_ic_video.png', height: 20,
                          ),

                          Text("  Featured",style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w400),)

                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: MaterialButton(
                        padding: const EdgeInsets.only(bottom: 10),
                        onPressed: () {

                          bottomController.updateIndexValue(2);



                        },
                        child: Column(
                          children: [

                            bottomController.pageIndex.value == 2
                                ?  Image.asset('assets/images/order_icon.png',
                             height: 20,
                            )
                                :Image.asset('assets/images/order_icon.png',
                            height: 20,
                            ),
                            Text("  Orders",style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w400),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: MaterialButton(
                      padding: EdgeInsets.only(bottom: 10),
                      onPressed: () {
                        bottomController.updateIndexValue(3);
                      },
                      child: Column(
                        children: [

                          bottomController. pageIndex.value == 3
                              ?  Image.asset('assets/images/setting.png',
                     height: 20,
                          )
                              : Image.asset('assets/images/setting.png', height: 20,
                          ),
                          Text("  Settings",style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w400),)

                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
