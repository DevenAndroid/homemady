import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart' hide Badge;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:homemady/widgets/dimenestion.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/homepage_controller.dart';
import '../controller/my_cart_controller.dart';
import '../controller/user_profile_controller.dart';
import '../repository/wishlist_repo.dart';
import '../resources/add_text.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  final homeController = Get.put(HomePageController());
  final profileController = Get.put(UserProfileController());
  final myCartController = Get.put(MyCartListController());
  String dateInput11 = "";




  RxBool isSelect = false.obs;
  RxBool selectIcon = false.obs;
  int currentDrawer = 0;
  RxInt count = 0.obs;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedDate = 'Delivery Now';

  void initState() {
    // TODO: implement initState
    super.initState();
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    homeController.getData();
    profileController.getData();
  });

    myCartController.getData();
    _decrement();
    _increment();
  }

  void _increment() {
    setState(() {
      count++;
    });
  }

  void _decrement() {
    setState(() {
      count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
              title: Text('My Orders',
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
              title: Text('My profile',
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
              title: Text('Notification',
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
              title: Text('My Address',
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
              title: Text('Refer and Earn',
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
              title: Text('Privacy Policy',
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
              title: Text('Message',
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
                'assets/images/helpICon.png',
                height: 20,
              ),
              title: Text('Help Center',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: const Color(0xFF4F535E),
                    fontWeight: FontWeight.w400,)),
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
                    fontWeight: FontWeight.w400,)),
              onTap: () {
                setState(() async{
                   SharedPreferences pref = await SharedPreferences.getInstance();
                   pref.clear();
                   Get.toNamed(MyRouters.loginScreen);
                });
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                child:
                Obx(() {
                 return
                   ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child:  CachedNetworkImage(
                      imageUrl:  profileController.isDataLoading.value ?
                      (profileController.model.value.data!.profileImage).toString() : '',
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                      errorWidget: (_, __, ___) => Image.asset(
                        'assets/images/Ellipse 67.png',
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      ),
                      placeholder: (_, __) =>
                      const Center(child: CircularProgressIndicator()),
                    ),
                  );
                })
               // Image.asset('assets/images/avtarImg.png', height: 45,)
            ),
            addWidth(6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Address',
                    style: GoogleFonts.poppins(
                    color: const Color(0xFF636869),
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),),
                  addHeight(3),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(MyRouters.chooseAddress);
                    },
                    child: Obx(() {
                      return Row(
                        children: [
                          Image.asset('assets/images/location.png',
                            height: 13,),
                          addWidth(4),
                          myCartController.isDataLoading.value ?
                          Expanded(
                            child: Text(myCartController.model.value.data!.orderAddress == null ?
                            'Select Address' : myCartController.model.value.data!.orderAddress!.location , style: GoogleFonts.poppins(
                              color: const Color(0xFF000000),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),),
                          ): CircularProgressIndicator(),
                          addWidth(4),
                          Image.asset('assets/images/pencilImg.png',
                            height: 13,),
                        ],
                      );
                    })
                  ),
                ],
              ),
            ),
            const Spacer(),
            Badge(
              badgeStyle: BadgeStyle(
                  padding: EdgeInsets.all(7)
              ),
              badgeContent: Obx(() {
                return Text(myCartController.isDataLoading.value ? myCartController.sum.value.toString(): '0', style: TextStyle(color: Colors.white),);
              }),
              child: GestureDetector(
                onTap: (){
                  Get.toNamed(MyRouters.myCartScreen);
                },
                child: Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF7ED957)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/shoppingImg.png',
                      height: 30,),
                  ),
                ),
              ),
            ),
      /*GestureDetector(
        onTap: (){
          Get.toNamed(MyRouters.myCartScreen);
        },
            child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF7ED957)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/images/shoppingImg.png',
                  height: 30,),
              ),
            ),
      ),*/
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
      ),
      key: _scaffoldKey,
      body: Obx(() {
        return SafeArea(
          child: homeController.isDataLoading.value && profileController.isDataLoading.value ?
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: const EdgeInsets.only(left: 14, top: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Hello',
                                style: GoogleFonts.poppins(
                                    color: const Color(0xFF676767),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16
                                ),

                              ),
                              Text(profileController.model.value.data!.name.toString(),
                                style: GoogleFonts.poppins(
                                    color: const Color(0xFF353535),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(MyRouters.favouriteScreen);
                              },
                              child: const Icon(
                                Icons.favorite_outline, color: Color(0xFF7ED957),
                                size: 30,),
                            ),
                          ),

                        ],
                      ),
                      addHeight(20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                                height: 42,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF37C666)
                                            .withOpacity(0.10),
                                        offset: const Offset(.1, .1,
                                        ),
                                        blurRadius: 20.0,
                                        spreadRadius: 1.0,
                                      ),
                                    ],
                                    color: Colors.white
                                ),
                                child: CommonTextFieldWidget1(
                                  hint: 'Search Your Food',
                                  prefix: Icon(Icons.search, size: 19,
                                    color: const Color(0xFF000000).withOpacity(
                                        0.56),),
                                  onChanged: (val) {
                                    _showSimpleDialog3(context);
                                  },
                                )
                            ),
                          ),
                          addWidth(10),
                          GestureDetector(
                            onTap: () {
                              _showSimpleDialog();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: const Color(0xFF7ED957),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF37C666).withOpacity(
                                        0.30),
                                    offset: const Offset(.1, .1,
                                    ),
                                    blurRadius: 20.0,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/images/filterImg.png', height: 18,),
                              ),
                            ),
                          ),
                          addWidth(5),
                          GestureDetector(
                            onTap: () {
                              _showSimpleDialog1();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF37C666).withOpacity(
                                          0.10),
                                      offset: const Offset(.1, .1,
                                      ),
                                      blurRadius: 20.0,
                                      spreadRadius: 1.0,
                                    ),
                                  ],
                                  border: Border.all(
                                      color: const Color(0xFF7ED957)
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/images/sort-descending.png',
                                  height: 18,),

                              ),
                            ),
                          ),
                          addWidth(10),
                        ],
                      ),
                      addHeight(26),
                      SizedBox(
                        height: 144,
                        child: ListView.builder(
                          itemCount: homeController.model.value.data!.sliderData!.length,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: homeController.model.value.data!.sliderData![index].image.toString(),
                                  fit: BoxFit.cover,
                                  errorWidget: (_, __, ___) => Image.asset(
                                  'assets/images/Ellipse 67.png',
                                ),
                                  placeholder: (_, __) =>
                                    Center(child: CircularProgressIndicator()),
                                ),
                                addWidth(20)
                              ],
                            );
                          },
                        ),
                      ),
                      addHeight(14),

                      Padding(
                        padding: const EdgeInsets.only(right: 9.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {},
                                child:
                                Container(
                                  height: 44,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: selectedDate == 'Delivery Now'
                                          ? Border.all(
                                          color: const Color(0xFF7ED957),
                                          width: 2
                                      )
                                          : Border.all(
                                          color: const Color(0xFF717171)
                                              .withOpacity(0.22),
                                          width: 1
                                      )
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      selectedDate == 'Delivery Now' ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          'assets/images/clockImg.png',
                                          height: 18,),
                                      ) : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          'assets/images/calendar_date.png',
                                          height: 18,
                                          color: const Color(0xFF262626)
                                              .withOpacity(0.62),),),
                                      selectedDate == 'Delivery Now' ?
                                      Text(selectedDate,
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF7ED957),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ) : Text(selectedDate,
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF262626)
                                              .withOpacity(0.62),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            addWidth(10),
                            Expanded(
                              child: GestureDetector(
                                onTap: ()  async {
                                  DateTime? _selectedDate = await showDatePicker(
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: const ColorScheme.light(
                                            primary: Color(0xFF7ED957),
                                            // header background color
                                            onPrimary: Colors.white,
                                            // header text color
                                            onSurface: Color(
                                                0xFF7ED957), // body text color
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor: const Color(
                                                  0xFF7ED957), // button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                    context: context,
                                    initialDate: DateTime.now().subtract(Duration()),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime.now().subtract(Duration(),
                                  ));
                                  if (_selectedDate != null) {
                                    print(_selectedDate);
                                    dateInput11 =
                                        _selectedDate.toString();
                                    print(dateInput11);
                                    String formattedDate =
                                    DateFormat('dd/MM/yyyy')
                                        .format(_selectedDate)
                                        .toString();

                                    print(formattedDate);
                                   /* setState(() {
                                      dobController.text =
                                          formattedDate; //set output date to TextField value.
                                      dobController.text =
                                          formattedDate;
                                    });*/
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                                child: Container(
                                    height: 44,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Color(0xFF7ED957),
                                    ),
                                    child: selectedDate == 'Delivery Now' ?
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            'assets/images/truckimg.png',
                                            height: 18,),
                                        ),
                                        Text('Pick a Date',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFFFFFFFF),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ) : Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            'assets/images/calendar_date.png',
                                            height: 18,),
                                        ),
                                        Text('Change Date',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFFFFFFFF),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      addHeight(20),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: homeController.model.value.data!.stores!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF37C666)
                                            .withOpacity(
                                            0.15),
                                        offset: const Offset(.3, .3,
                                        ),
                                        blurRadius: 20.0,
                                        spreadRadius: 1.0,
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.toNamed(MyRouters.homeDetailsScreen,arguments: [homeController.model.value.data!.stores![index].id.toString()]);
                                          },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: CachedNetworkImage(
                                                  imageUrl: homeController.model.value.data!.stores![index].image.toString(),
                                                  fit: BoxFit.cover,
                                                  height: 150,
                                                  width: AddSize.screenWidth,
                                                  errorWidget: (_, __, ___) => Image.asset(
                                                    'assets/images/Rectangle 23007.png',
                                                    fit: BoxFit.cover,
                                                    height: 150,
                                                    width: AddSize.screenWidth,
                                                  ),
                                                  placeholder: (_, __) =>
                                                      const Center(child: CircularProgressIndicator()),
                                                ),
                                              ),
                                              /*ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: Image.asset(
                                                  'assets/images/Rectangle 23007.png',fit: BoxFit.cover,
                                                  height: 140,width: AddSize.screenWidth,
                                                ),
                                              ),*/
                                              addHeight(6),
                                              Text(homeController.model.value.data!.stores![index].name.toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                    color: const Color(0xFF21283D)
                                                ),),
                                              addHeight(6),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/truckimg.png',
                                                    height: 22,
                                                    color: const Color(
                                                        0xFF04666E),),
                                                  addWidth(10),
                                                  Text('Delivery Only 25 mins',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight
                                                            .w400,
                                                        fontSize: 12,
                                                        color: const Color(
                                                            0xFF606573)
                                                    ),),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: 80,
                                          // bottom: 0,
                                          left: 20,
                                          right: 20,
                                          //   bottom: 0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: const [
                                              Icon(Icons.arrow_back_ios,
                                                color: Colors.white, size: 20,),
                                              Icon(Icons.arrow_forward_ios,
                                                color: Colors.white, size: 20,)
                                            ],
                                          )
                                      ),
                                      Positioned(
                                          bottom: 10,
                                          right: 20,
                                          //   bottom: 0,
                                          child: Column(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  height: 48,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(
                                                        3),
                                                    child: Image.asset(
                                                        'assets/images/avtarImg.png'),
                                                  )
                                              ),
                                              addHeight(3),
                                              Text((homeController.model.value.data!.stores![index].cookName!.isEmpty ?  'Test' : homeController.model.value.data!.stores![index].cookName).toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF21283D)
                                                ),),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .center,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                children: [
                                                  const Icon(Icons.star,
                                                    color: Color(0xFFFFC529),
                                                    size: 14,),
                                                  addWidth(3),
                                                  Text(homeController.model.value.data!.stores![index].rating.toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight
                                                            .w500,
                                                        fontSize: 11,
                                                        color: const Color(
                                                            0xFF6A7080)
                                                    ),),
                                                  Text('(${(homeController.model.value.data!.stores![index].countReviewData!.isEmpty ? '3' :'').toString()})',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight
                                                            .w500,
                                                        fontSize: 11,
                                                        color: const Color(
                                                            0xFF6A7080)
                                                    ),),
                                                ],
                                              )
                                            ],
                                          )
                                      ),
                                      Positioned(
                                          top: 16,
                                          // bottom: 0,
                                          // left: 290,
                                          right: 10,
                                          //   bottom: 0,

                                          child: Column(
                                            children: [
                                            //  Obx(() {
                                             //   return
                                                  Container(
                                                    height: 33,
                                                    decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .only(left: 10,
                                                          right: 10,
                                                          top: 3),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          isSelect.value =
                                                          !isSelect.value;
                                                          print(homeController.model.value.data!.stores![index].id.toString());
                                                          wishlistRepo(id: homeController.model.value.data!.stores![index].id.toString()).then((value) {
                                                           if(value.status == true){
                                                             if(value.message.toString() == 'global.WISHLIST_REMOVED'){
                                                               homeController.model.value.data!.stores![index].wishlist = false;
                                                             }else{
                                                               homeController.model.value.data!.stores![index].wishlist = true;
                                                             }

                                                             showToast(value.message.toString());
                                                            // homeController.getData();
                                                             setState(() {

                                                             });
                                                           }
                                                          });
                                                        },
                                                        child:
                                                        homeController.model.value.data!.stores![index].wishlist! ?
                                                        const Icon(
                                                          Icons.favorite,
                                                          color: Color(
                                                              0xFF54C523),)
                                                           :
                                                        const Icon(
                                                          Icons.favorite_outline,
                                                          color: Color(
                                                              0xFF54C523),),
                                                      ),
                                                    )
                                                ),
                                           //   }),
                                            ],
                                          )
                                      ),
                                      Positioned(
                                          top: 14,
                                          // bottom: 0,
                                          left: 10,
                                          right: 15,
                                          //   bottom: 0,
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    showGeneralDialog(
                                                        context: context,
                                                        barrierDismissible: true,
                                                        barrierColor: const Color(
                                                            0xFF000000)
                                                            .withOpacity(0.58),
                                                        barrierLabel: MaterialLocalizations
                                                            .of(context)
                                                            .modalBarrierDismissLabel,
                                                        pageBuilder: (
                                                            BuildContext context,
                                                            Animation first,
                                                            Animation second) {
                                                          return Stack(
                                                            children: [
                                                              Center(child: Image
                                                                  .asset(
                                                                  'assets/images/dialogboximg.png')),
                                                              Positioned(
                                                                right: 18,
                                                                top: 30,
                                                                child: Container(
                                                                    padding: EdgeInsets
                                                                        .all(10),
                                                                    height: 80,
                                                                    decoration: const BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        shape: BoxShape
                                                                            .circle
                                                                    ),
                                                                    child: GestureDetector(
                                                                      child: Icon(
                                                                          Icons
                                                                              .clear),
                                                                      onTap: () {
                                                                        Get
                                                                            .back();
                                                                      },)
                                                                ),)
                                                            ],
                                                          );
                                                        }
                                                    );
                                                  },
                                                  child: Image.asset(
                                                    'assets/images/topChef.png',
                                                    width: 50,)),
                                              GestureDetector(
                                                  onTap: () {
                                                    showGeneralDialog(
                                                        context: context,
                                                        barrierDismissible: true,
                                                        barrierColor: const Color(
                                                            0xFF000000)
                                                            .withOpacity(0.58),
                                                        barrierLabel: MaterialLocalizations
                                                            .of(context)
                                                            .modalBarrierDismissLabel,
                                                        pageBuilder: (
                                                            BuildContext context,
                                                            Animation first,
                                                            Animation second) {
                                                          return Stack(
                                                            children: [
                                                              Center(child: Image
                                                                  .asset(
                                                                  'assets/images/dialogboximg.png')),
                                                              Positioned(
                                                                right: 18,
                                                                top: 50,
                                                                child: Container(
                                                                    padding: EdgeInsets
                                                                        .all(10),
                                                                    height: 50,
                                                                    decoration: const BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        shape: BoxShape
                                                                            .circle
                                                                    ),
                                                                    child: GestureDetector(
                                                                      child: Icon(
                                                                          Icons
                                                                              .clear),
                                                                      onTap: () {
                                                                        Get
                                                                            .back();
                                                                      },)
                                                                ),)
                                                            ],
                                                          );
                                                        }
                                                    );
                                                  },
                                                  child: Image.asset(
                                                    'assets/images/topChef.png',
                                                    width: 50,)),
                                            ],
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15,)
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ): Center(child: CircularProgressIndicator()),
        );
      })
        //bottomNavigationBar: ,
    );
  }

  Future<void> _showSimpleDialog() async {
    await showDialog<void>(
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations
            .of(context)
            .modalBarrierDismissLabel,
        context: context,
        barrierColor: null,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero
            ),
            children: <Widget>[
              SimpleDialogOption(
                  onPressed: () {
                    _showSimpleDialog2(context);
                  },
                  child: Text('Gluten Free',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      color: const Color(0xFF425159),),
                  )),
              SimpleDialogOption(
                  onPressed: () {
                    _showSimpleDialog2(context);
                  },
                  child: Text('Halal',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      color: const Color(0xFF425159),),
                  )
              ),
              SimpleDialogOption(
                  onPressed: () {
                    _showSimpleDialog2(context);
                  },
                  child: Text('Vegan',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      color: const Color(0xFF425159),),
                  )),
              SimpleDialogOption(
                  onPressed: () {
                    _showSimpleDialog2(context);
                  },
                  child: Text('Vegetarian',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      color: const Color(0xFF425159),),
                  )
              ),
              SimpleDialogOption(
                  onPressed: () {
                    _showSimpleDialog2(context);
                  },
                  child: Text('Pescatarian',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      color: const Color(0xFF425159),),
                  )
              ),
            ],
          );
        });
  }

  Future<void> _showSimpleDialog1() async {
    await showDialog<void>(
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations
            .of(context)
            .modalBarrierDismissLabel,
        context: context,
        barrierColor: null,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero
            ),
            children: <Widget>[
              SimpleDialogOption(
                  onPressed: () {
                    _showSimpleDialog3(context);
                  },
                  child: Text('Sustainable Packaging',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      color: const Color(0xFF425159),),
                  )),
              SimpleDialogOption(
                  onPressed: () {
                    _showSimpleDialog3(context);
                  },
                  child: Text('Top Chefs',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      color: const Color(0xFF425159),),
                  )
              ),
              SimpleDialogOption(
                  onPressed: () {
                    _showSimpleDialog3(context);
                  },
                  child: Text('Rating',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      color: const Color(0xFF425159),),
                  )),
              SimpleDialogOption(
                  onPressed: () {
                    _showSimpleDialog3(context);
                  },
                  child: Text('Distance',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      color: const Color(0xFF425159),),
                  )
              ),
              SimpleDialogOption(
                  onPressed: () {
                    _showSimpleDialog3(context);
                  },
                  child: Text('Quickest Delivery',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      color: const Color(0xFF425159),),
                  )
              ),
              SimpleDialogOption(
                  onPressed: () {
                    _showSimpleDialog3(context);
                  },
                  child: Text('Recommended',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      color: const Color(0xFF425159),),
                  )
              ),
            ],
          );
        });
  }

  Future<void> _showSimpleDialog2(BuildContext context) async {
    await showDialog(
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations
            .of(context)
            .modalBarrierDismissLabel,
        context: context,
        barrierColor: null,
        builder: (context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero
            ),
            insetPadding: const EdgeInsets.only(bottom: 0, top: 220),
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF37C666).withOpacity(
                                      0.15),
                                  offset: const Offset(.3, .3,
                                  ),
                                  blurRadius: 20.0,
                                  spreadRadius: 1.0,
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(MyRouters.homeDetailsScreen);
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Image.asset(
                                            'assets/images/Rectangle 2171.png'),
                                        addHeight(6),
                                        Text('Burger King with Pizza',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color: const Color(0xFF21283D)
                                          ),),
                                        addHeight(6),
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/truckimg.png',
                                              height: 22,
                                              color: const Color(0xFF04666E),),
                                            addWidth(10),
                                            Text('Delivery Only 25 mins',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: const Color(0xFF606573)
                                              ),),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 80,
                                    // bottom: 0,
                                    left: 20,
                                    right: 20,
                                    //   bottom: 0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: const [
                                        Icon(Icons.arrow_back_ios,
                                          color: Colors.white, size: 20,),
                                        Icon(Icons.arrow_forward_ios,
                                          color: Colors.white, size: 20,)
                                      ],
                                    )
                                ),
                                Positioned(
                                    bottom: 10,
                                    right: 20,
                                    //   bottom: 0,
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            height: 48,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(3),
                                              child: Image.asset(
                                                  'assets/images/avtarImg.png'),
                                            )
                                        ),
                                        addHeight(3),
                                        Text('Jack Smith',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: const Color(0xFF21283D)
                                          ),),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            const Icon(Icons.star,
                                              color: Color(0xFFFFC529),
                                              size: 14,),
                                            addWidth(3),
                                            Text('4.95 (35)',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 11,
                                                  color: const Color(0xFF6A7080)
                                              ),),
                                          ],
                                        )
                                      ],
                                    )
                                ),
                                Positioned(
                                    top: 16,
                                    // bottom: 0,
                                    // left: 290,
                                    right: 10,
                                    //   bottom: 0,

                                    child: Column(
                                      children: [
                                        Obx(() {
                                          return Container(
                                              height: 33,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .only(left: 10,
                                                    right: 10,
                                                    top: 3),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    isSelect.value =
                                                    !isSelect.value;
                                                  },
                                                  child: isSelect.value ==
                                                      true
                                                      ? const Icon(
                                                    Icons.favorite,
                                                    color: Color(0xFF54C523),)
                                                      :
                                                  const Icon(
                                                    Icons.favorite_outline,
                                                    color: Color(
                                                        0xFF54C523),),
                                                ),
                                              )
                                          );
                                        }),
                                      ],
                                    )
                                ),
                                Positioned(
                                    top: 14,
                                    // bottom: 0,
                                    left: 10,
                                    right: 15,
                                    //   bottom: 0,
                                    child: Row(
                                      children: [

                                        GestureDetector(
                                            onTap: () {
                                              showGeneralDialog(
                                                  context: context,
                                                  barrierDismissible: true,
                                                  barrierColor: const Color(
                                                      0xFF000000).withOpacity(
                                                      0.58),
                                                  barrierLabel: MaterialLocalizations
                                                      .of(context)
                                                      .modalBarrierDismissLabel,
                                                  pageBuilder: (
                                                      BuildContext context,
                                                      Animation first,
                                                      Animation second) {
                                                    return Stack(
                                                      children: [
                                                        Center(
                                                            child: Image.asset(
                                                                'assets/images/dialogboximg.png')),
                                                        Positioned(
                                                          right: 18,
                                                          top: 30,
                                                          child: Container(
                                                              padding: EdgeInsets
                                                                  .all(10),
                                                              height: 80,
                                                              decoration: const BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  shape: BoxShape
                                                                      .circle
                                                              ),
                                                              child: GestureDetector(
                                                                child: Icon(
                                                                    Icons
                                                                        .clear),
                                                                onTap: () {
                                                                  Get.back();
                                                                },)
                                                          ),)
                                                      ],
                                                    );
                                                  }
                                              );
                                            },
                                            child: Image.asset(
                                              'assets/images/topChef.png',
                                              width: 50,)),
                                        GestureDetector(
                                            onTap: () {
                                              showGeneralDialog(
                                                  context: context,
                                                  barrierDismissible: true,
                                                  barrierColor: const Color(
                                                      0xFF000000).withOpacity(
                                                      0.58),
                                                  barrierLabel: MaterialLocalizations
                                                      .of(context)
                                                      .modalBarrierDismissLabel,
                                                  pageBuilder: (
                                                      BuildContext context,
                                                      Animation first,
                                                      Animation second) {
                                                    return Stack(
                                                      children: [
                                                        Center(
                                                            child: Image.asset(
                                                                'assets/images/dialogboximg.png')),
                                                        Positioned(
                                                          right: 18,
                                                          top: 50,
                                                          child: Container(
                                                              padding: EdgeInsets
                                                                  .all(10),
                                                              height: 50,
                                                              decoration: const BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  shape: BoxShape
                                                                      .circle
                                                              ),
                                                              child: GestureDetector(
                                                                child: Icon(
                                                                    Icons
                                                                        .clear),
                                                                onTap: () {
                                                                  Get.back();
                                                                },)
                                                          ),)
                                                      ],
                                                    );
                                                  }
                                              );
                                            },
                                            child: Image.asset(
                                              'assets/images/topChef.png',
                                              width: 50,)),
                                      ],
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,)
                      ],
                    );
                  },
                )
            ),
          );
        }
    );
  }

  Future<void> _showSimpleDialog3(BuildContext context) async {
    await showDialog(
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations
            .of(context)
            .modalBarrierDismissLabel,
        context: context,
        barrierColor: const Color(0x01000000),
        builder: (context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero
            ),
            insetPadding: const EdgeInsets.only(bottom: 0, top: 220),
            child: ListView.builder(
              itemCount: 6,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(MyRouters.homeDetailsScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF37C666).withOpacity(
                                          0.10),
                                      offset: const Offset(.1, .1,
                                      ),
                                      blurRadius: 20.0,
                                      spreadRadius: 1.0,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(child: Image.asset(
                                        'assets/images/Rectangle 39762.png',
                                        height: 80, width: 70,)),
                                      addWidth(10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text('Special Burger',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                color: const Color(0xFF21283D)
                                            ),),
                                          addHeight(3),
                                          Text('Size: 200gm',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 11,
                                                color: const Color(0xFF364A4F)
                                            ),),
                                          addHeight(3),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Text('spiciness :',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight
                                                            .w500,
                                                        fontSize: 10,
                                                        color: const Color(
                                                            0xFF1F2D30)
                                                    ),),
                                                  addWidth(4),
                                                  Text('Mildly Spicy',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight
                                                            .w500,
                                                        fontSize: 10,
                                                        color: const Color(
                                                            0xFF6CC844)
                                                    ),),
                                                ],
                                              ),
                                              addWidth(10),
                                              Row(
                                                children: [
                                                  Text('Allergens :',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight
                                                            .w500,
                                                        fontSize: 10,
                                                        color: const Color(
                                                            0xFF1F2D30)
                                                    ),),
                                                  addWidth(4),
                                                  Text('Crustaceans',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight
                                                            .w500,
                                                        fontSize: 10,
                                                        color: const Color(
                                                            0xFF6CC844)
                                                    ),),
                                                ],
                                              ),
                                            ],
                                          ),
                                          addHeight(6),
                                          IntrinsicHeight(
                                            child:
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap:
                                                      () {
                                                    _decrement();
                                                  },
                                                  child:
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: const Color(
                                                                0xFF72CD4A)),
                                                        shape: BoxShape.circle),
                                                    alignment: Alignment.center,
                                                    child: const Padding(
                                                      padding: EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8,
                                                          vertical: 3),
                                                      child: Text(
                                                        '-',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight
                                                                .w600,
                                                            fontSize: 16,
                                                            color: Color(
                                                                0xFF72CD4A)),
                                                        textAlign: TextAlign
                                                            .center,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Obx(() {
                                                  return Container(
                                                    alignment:
                                                    Alignment.center,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .only(left: 14.0,
                                                          right: 14.0),
                                                      child: Text(
                                                          '${count}'
                                                      ),
                                                    ),
                                                  );
                                                }),
                                                GestureDetector(
                                                  onTap:
                                                      () {
                                                    _increment();
                                                  },
                                                  child:
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFF72CD4A),
                                                        border: Border.all(
                                                            color: const Color(
                                                                0xFF72CD4A)),
                                                        shape: BoxShape.circle),
                                                    alignment: Alignment.center,
                                                    child: const Padding(
                                                      padding: EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8),
                                                      child: Text(
                                                        '+',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight
                                                                .w600,
                                                            fontSize: 16,
                                                            color: Colors.white),
                                                        textAlign: TextAlign
                                                            .center,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  addHeight(5),
                                  Container(
                                    margin: EdgeInsets.only(left: 75),
                                    color: Color(0xFFE9E9E9),
                                    width: AddSize.screenWidth,
                                    height: 1,
                                  ),
                                  addHeight(7),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      addWidth(80),
                                      Image.asset(
                                        'assets/images/helpimg.png', height: 13,),
                                      addWidth(4),
                                      Text(
                                        'Can cook more units by: 30th June 2023',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 11,
                                            color: const Color(0xFF364A4F)
                                        ),),
                                    ],
                                  ),
                                  addHeight(4),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      addWidth(80),
                                      Image.asset('assets/images/helpimg.png',height: 13,),
                                      addWidth(4),
                                      Text('Available stock: ',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 11,
                                            color: const Color(0xFF364A4F)
                                        ),),
                                      Text(' 3 units',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11,
                                            color: const Color(0xFF364A4F)
                                        ),),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            Positioned(
                              top: 14,
                              right: 20,
                              child: Text('€6.99',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: const Color(0xFF70CC49)
                                ),),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },),
          );
        }
    );
  }
}
