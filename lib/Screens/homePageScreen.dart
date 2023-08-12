import 'dart:developer';
import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart' hide Badge;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/Screens/filter_category_product_list.dart';
import 'package:homemady/Screens/search_screen_data.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:homemady/widgets/dimenestion.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/category_controller.dart';
import '../controller/fillter_product_category_controller.dart';
import '../controller/homepage_controller.dart';
import '../controller/my_address_controller.dart';
import '../controller/my_cart_controller.dart';
import '../controller/search_store_conbtroller.dart';
import '../controller/time_slot_controller.dart';
import '../controller/user_profile_controller.dart';
import '../controller/vendor_single_store_controller.dart';
import '../repository/wishlist_repo.dart';
import '../resources/add_text.dart';
import '../widgets/app_theme.dart';
import 'myAddressScreen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final categoryController = Get.put(CategoryController());
  final homeController = Get.put(HomePageController());
  final profileController = Get.put(UserProfileController());
  final myCartController = Get.put(MyCartListController());
  final searchController = Get.put(SearchStoreController());
  final timeSlotController = Get.put(TimeSlotController());
  final myAddressController = Get.put(MyAddressController());
  final controller = Get.put(VendorSingleStoreController());
  final filterProductCategoryController = Get.put(FilterProductCategoryController());

  String dateInput11 = "";
  RxBool isValue = false.obs;
  String? selectedCategory;
  int currentIndex = -1;
  List<ItemDropDown> items = <ItemDropDown>[
    const ItemDropDown('sustainable_packaging', 'Sustainable Packaging'),
    const ItemDropDown('quickest_delivery', 'Quickest Delivery'),
    const ItemDropDown('distance', 'distance'),
  ];


  final RxBool _isValue1 = false.obs;
  final RxBool _isValue2 = false.obs;
  bool? isChoosedFilterOption = false;

  final scrollController = ScrollController();
  final scrollController1 = ScrollController();
  RxBool isSelect = false.obs;
  RxBool selectIcon = false.obs;
  int currentDrawer = 0;
  RxInt count = 0.obs;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedDate = 'Available Now';

  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileController.getData();
      scrollController.addListener((_scrollListener));
      // scrollController1.addListener((_scrollListener1));
      homeController.getData();
      filterProductCategoryController.getFilterCategoryData();
      myCartController.getData();
      categoryController.getCategoryData();
      timeSlotController.getTimeSlotData();
      myAddressController.getData();
      int currnetIndex = -1;
      _decrement();
      _increment();
    });
  }

  Future<void> _showSimpleDialog3(BuildContext context) async {
    await showDialog(
        barrierDismissible: true,
        context: context,
        barrierColor: const Color(0x01000000),
        builder: (context) {
          return Dialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            insetPadding: const EdgeInsets.only(bottom: 0, top: 0),
            child: controller.isDataLoading.value
                ?
            ListView.builder(
                    itemCount: controller.model.value.data!.latestProducts!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
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
                                          color: const Color(0xFF37C666).withOpacity(0.10),
                                          offset: const Offset(
                                            .1,
                                            .1,
                                          ),
                                          blurRadius: 20.0,
                                          spreadRadius: 1.0,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: CachedNetworkImage(
                                              imageUrl: controller.model.value.data!.latestProducts![index].image.toString(),
                                              fit: BoxFit.cover,
                                              errorWidget: (_, __, ___) => Image.asset(
                                                'assets/images/error_image.png',
                                              ),
                                              placeholder: (_, __) => Center(child: CircularProgressIndicator()),
                                            ),
                                          ),
                                          addWidth(10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.model.value.data!.latestProducts![index].name.toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14,
                                                    color: const Color(0xFF21283D)),
                                              ),
                                              addHeight(3),
                                              Text(
                                                'Size: 200gm',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 11,
                                                    color: const Color(0xFF364A4F)),
                                              ),
                                              addHeight(3),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'spiciness :',
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 10,
                                                            color: const Color(0xFF1F2D30)),
                                                      ),
                                                      addWidth(4),
                                                      Text(
                                                        'Mildly Spicy',
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 10,
                                                            color: const Color(0xFF6CC844)),
                                                      ),
                                                    ],
                                                  ),
                                                  addWidth(10),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          'Allergens :',
                                                          style: GoogleFonts.poppins(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 10,
                                                              color: const Color(0xFF1F2D30)),
                                                        ),
                                                      ),
                                                      addWidth(4),
                                                      Text(
                                                        'Crustaceans',
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 10,
                                                            color: const Color(0xFF6CC844)),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              addHeight(6),
                                              IntrinsicHeight(
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(color: const Color(0xFF72CD4A)),
                                                            shape: BoxShape.circle),
                                                        alignment: Alignment.center,
                                                        child: const Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                                          child: Text(
                                                            '-',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 16,
                                                                color: Color(0xFF72CD4A)),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment: Alignment.center,
                                                      child: const Padding(
                                                        padding: EdgeInsets.only(left: 14.0, right: 14.0),
                                                        child: Text('0'),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: const Color(0xFF72CD4A),
                                                            border: Border.all(color: const Color(0xFF72CD4A)),
                                                            shape: BoxShape.circle),
                                                        alignment: Alignment.center,
                                                        child: const Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 8),
                                                          child: Text(
                                                            '+',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 16,
                                                                color: Colors.white),
                                                            textAlign: TextAlign.center,
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
                                            'assets/images/helpimg.png',
                                            height: 13,
                                          ),
                                          addWidth(4),
                                          Text(
                                            'Can cook more units by: 30th June 2023',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w300, fontSize: 11, color: const Color(0xFF364A4F)),
                                          ),
                                        ],
                                      ),
                                      addHeight(4),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          addWidth(80),
                                          Image.asset(
                                            'assets/images/helpimg.png',
                                            height: 13,
                                          ),
                                          addWidth(4),
                                          Text(
                                            'Available stock: ',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w300, fontSize: 11, color: const Color(0xFF364A4F)),
                                          ),
                                          Text(
                                            ' 3 units',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500, fontSize: 11, color: const Color(0xFF364A4F)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 14,
                                  right: 20,
                                  child: Text(
                                    '€6.99',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700, fontSize: 15, color: const Color(0xFF70CC49)),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator()),
          );
        });
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      searchController.page.value = searchController.page.value + 1;
      searchController.getSearchData();
    } else {
      if (kDebugMode) {
        print("Dont call");
      }
    }
  }

// filter product category wise
  void _scrollListener1() {
    if (scrollController1.position.pixels == scrollController1.position.maxScrollExtent) {
      // filterProductCategoryController.page.value = filterProductCategoryController.page.value + 1;
      filterProductCategoryController.getFilterCategoryData();
    } else {
      if (kDebugMode) {
        print("Not calling");
      }
    }
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

  showChooseDate(index) {
    RxInt refreshInt = 0.obs;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16,
              ),
              child: Obx(() {
                if (refreshInt.value > 0) {}
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AddSize.size10),
                    const Text("Time Slot",
                        style: TextStyle(color: Color(0xff333848), fontWeight: FontWeight.w600, fontSize: 17)),
                    SizedBox(height: AddSize.size10),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: timeSlotController.timeSlotModel.value.data!.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisExtent: 44, mainAxisSpacing: 8.0),
                        itemBuilder: (context, index) {
                          var itemdata = timeSlotController.timeSlotModel.value.data![index];
                          return GestureDetector(
                            onTap: () {
                              currentIndex = index;
                              refreshInt.value = DateTime.now().millisecondsSinceEpoch;
                            },
                            child: Container(
                                //height: 100,
                                decoration: BoxDecoration(
                                    color: currentIndex != index ? Colors.white : Color(0xFF7ED957),
                                    borderRadius: BorderRadius.circular(4),
                                    border: currentIndex == index
                                        ? Border.all(color: const Color(0xff7ED957), width: 2)
                                        : Border.all(color: const Color(0xFF717171).withOpacity(0.22), width: 1)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      itemdata.startTime.toString() + "-" + itemdata.endTime.toString().capitalizeFirst!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: currentIndex != index ? AppTheme.subText : Colors.white,
                                          fontSize: AddSize.font14,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                )),
                          );
                        }),
                    SizedBox(height: AddSize.size10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff7ED957),
                            ),
                            child: const Text(
                              "OK",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                            ))
                      ],
                    ),
                    addHeight(20),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
        appBar: AppBar(
          title: Row(
            children: [
              GestureDetector(onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              }, child: Obx(() {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl: profileController.isDataLoading.value
                        ? (profileController.model.value.data!.profileImage).toString()
                        : '',
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                    errorWidget: (_, __, ___) => Image.asset(
                      'assets/images/dummyPerson.png',
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                    ),
                    placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
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
                    Text(
                      'Address',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF636869),
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    addHeight(3),
                    GestureDetector(onTap: () {
                      Get.to(() => const MyAddressScreen(), arguments: 'home');
                    }, child: Obx(() {
                      return Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/location.png',
                            height: 13,
                          ),
                          addWidth(4),
                          Flexible(
                            child: Text(
                              profileController.address.value.toString(),
                              // profileController.model.value.data!.defaultAddress == null
                              //     ? 'Select Address'
                              // : profileController.model.value.data!.defaultAddress![0].addressType.toString(),
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          addWidth(5),
                          Image.asset(
                            'assets/images/pencilImg.png',
                            height: 15,
                          ),
                        ],
                      );
                    })),
                  ],
                ),
              ),
              Badge(
                badgeStyle: BadgeStyle(padding: EdgeInsets.all(7)),
                badgeContent: Obx(() {
                  return Text(
                    myCartController.isDataLoading.value ? myCartController.sum.value.toString() : '0',
                    style: TextStyle(color: Colors.white),
                  );
                }),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(MyRouters.myCartScreen);
                  },
                  child: Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xFF7ED957)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/shoppingImg.png',
                        height: 30,
                      ),
                    ),
                  ),
                ),
              ),
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
            child: homeController.isDataLoading.value && profileController.isDataLoading.value
                ? RefreshIndicator(
                    onRefresh: () {
                      return homeController.getData();
                    },
                    child: SingleChildScrollView(
                        // physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 14, top: 18),
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
                                      Text(
                                        'Hello',
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xFF676767), fontWeight: FontWeight.w300, fontSize: 16),
                                      ),
                                      Text(
                                        profileController.model.value.data!.name.toString(),
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xFF353535), fontWeight: FontWeight.w600, fontSize: 22),
                                      ),
                                    ],
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
                                                color: const Color(0xFF37C666).withOpacity(0.10),
                                                offset: const Offset(
                                                  .1,
                                                  .1,
                                                ),
                                                blurRadius: 20.0,
                                                spreadRadius: 1.0,
                                              ),
                                            ],
                                            color: Colors.white),
                                        child: CommonTextFieldWidget1(
                                          hint: 'Search Your Food',
                                          controller: searchController.searchController1,
                                          prefix: InkWell(
                                            onTap: () {
                                              if (selectedDate != "Available Now") {
                                                Get.toNamed(SearchScreenData.searchScreen, arguments: [selectedDate]);
                                              } else {
                                                showToast("Please pick a date");
                                              }
                                              print("Date is ${selectedDate}");
                                              print(searchController.searchController1.text);
                                            },
                                            child: Icon(
                                              Icons.search,
                                              size: 19,
                                              color: const Color(0xFF000000).withOpacity(0.56),
                                            ),
                                          ),
                                          onChanged: (val) {
                                            isValue.value = true;
                                            searchController.getSearchData();
                                            // Get.toNamed(SearchScreenData.searchScreen);
                                          },
                                        )),
                                  ),
                                  addWidth(10),
                                  GestureDetector(
                                    onTap: () {
                                      //_showDialogCategory();
                                      showUploadWindow(categoryController.categoryModel.value.data!.category!);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: const Color(0xFF7ED957),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF37C666).withOpacity(0.30),
                                            offset: const Offset(
                                              .1,
                                              .1,
                                            ),
                                            blurRadius: 20.0,
                                            spreadRadius: 1.0,
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          'assets/images/filterImg.png',
                                          height: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  addWidth(5),
                                  GestureDetector(
                                    onTap: () {
                                      print("AAAAAA");
                                      _showSimpleDialog1();
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFF37C666).withOpacity(0.10),
                                              offset: const Offset(
                                                .1,
                                                .1,
                                              ),
                                              blurRadius: 20.0,
                                              spreadRadius: 1.0,
                                            ),
                                          ],
                                          border: Border.all(color: const Color(0xFF7ED957))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          'assets/images/sort-descending.png',
                                          height: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  addWidth(10),
                                ],
                              ),
                              // addHeight(26),

                                Column(
                                  children: [
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
                                                imageUrl:
                                                    homeController.model.value.data!.sliderData![index].image.toString(),
                                                fit: BoxFit.cover,
                                                errorWidget: (_, __, ___) => Image.asset(
                                                  'assets/images/Ellipse 67.png',
                                                ),
                                                placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
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
                                            child: InkWell(
                                              onTap: () {},
                                              child: Container(
                                                height: 44,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(4),
                                                    border: selectedDate == 'Available Now'
                                                        ? Border.all(color: const Color(0xff7ED957), width: 2)
                                                        : Border.all(
                                                            color: const Color(0xFF717171).withOpacity(0.22), width: 1)),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    selectedDate == 'Available Now'
                                                        ? Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Image.asset(
                                                              'assets/images/clockImg.png',
                                                              height: 18,
                                                            ),
                                                          )
                                                        : Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Image.asset(
                                                              'assets/images/calendar_date.png',
                                                              height: 18,
                                                              color: const Color(0xFF262626).withOpacity(0.62),
                                                            ),
                                                          ),
                                                    selectedDate == 'Available Now'
                                                        ? Text(
                                                            selectedDate,
                                                            style: GoogleFonts.poppins(
                                                              color: const Color(0xFF7ED957),
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          )
                                                        : Text(
                                                            selectedDate,
                                                            style: GoogleFonts.poppins(
                                                              color: const Color(0xFF262626).withOpacity(0.62),
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
                                            child: InkWell(
                                              onTap: () async {
                                                showChooseDate(context);
                                                DateTime? pickedDate = await showDatePicker(
                                                  builder: (context, child) {
                                                    return Theme(
                                                      data: Theme.of(context).copyWith(
                                                        colorScheme: const ColorScheme.light(
                                                          primary: Color(0xFF7ED957),
                                                          // header background color
                                                          onPrimary: Colors.white,
                                                          // header text color
                                                          onSurface: Color(0xFF7ED957), // body text color
                                                        ),
                                                        textButtonTheme: TextButtonThemeData(
                                                          style: TextButton.styleFrom(
                                                            foregroundColor: const Color(0xFF7ED957), // button text color
                                                          ),
                                                        ),
                                                      ),
                                                      child: child!,
                                                    );
                                                  },

                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now().subtract(Duration(days: 0)),
                                                  // firstDate: DateTime(1950),
                                                  //DateTime.now() - not to allow to choose before today.
                                                  lastDate: DateTime(2025),
                                                ).then((value) {
                                                  // setState(() {
                                                  //   _dateTime = value!;
                                                  // });

                                                  if (value != null) {
                                                    String formattedDate = DateFormat('yyyy/MM/dd').format(value);
                                                    setState(() {
                                                      // var selectedDate=formattedDate;
                                                      selectedDate = formattedDate; //set output date to TextField value.
                                                      log("Seleted Date     $selectedDate");
                                                    });
                                                  }
                                                });

                                                if (pickedDate != null) {
                                                  // showChooseDate(context);
                                                  String formattedDate = DateFormat('yyyy/MM/dd').format(pickedDate);
                                                  setState(() {
                                                    selectedDate = formattedDate;
                                                    log("Seleted Date     $selectedDate");
                                                  });
                                                }
                                              },
                                              child: Container(
                                                  height: 44,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(4),
                                                    color: const Color(0xFF7ED957),
                                                  ),
                                                  child: selectedDate == 'Available Now'
                                                      ? Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Image.asset(
                                                                'assets/images/truckimg.png',
                                                                height: 18,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Pick a Date',
                                                              style: GoogleFonts.poppins(
                                                                color: const Color(0xFFFFFFFF),
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      : Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Image.asset(
                                                                'assets/images/calendar_date.png',
                                                                height: 18,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Change Date',
                                                              style: GoogleFonts.poppins(
                                                                color: const Color(0xFFFFFFFF),
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            )
                                                          ],
                                                        )),
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
                                                      color: const Color(0xFF37C666).withOpacity(0.15),
                                                      offset: const Offset(
                                                        .3,
                                                        .3,
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
                                                          Get.toNamed(MyRouters.homeDetailsScreen, arguments: [
                                                            homeController.model.value.data!.stores![index].id.toString()
                                                          ]);
                                                        },
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius: BorderRadius.circular(8),
                                                              child: CachedNetworkImage(
                                                                imageUrl: homeController
                                                                    .model.value.data!.stores![index].image
                                                                    .toString(),
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
                                                            Text(
                                                              homeController.model.value.data!.stores![index].name
                                                                  .toString(),
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight: FontWeight.w700,
                                                                  fontSize: 16,
                                                                  color: const Color(0xFF21283D)),
                                                            ),
                                                            addHeight(6),
                                                            Row(
                                                              children: [
                                                                Image.asset(
                                                                  'assets/images/truckimg.png',
                                                                  height: 22,
                                                                  color: const Color(0xFF04666E),
                                                                ),
                                                                addWidth(10),
                                                                Text(
                                                                  'Delivery Only 25 mins',
                                                                  style: GoogleFonts.poppins(
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: 12,
                                                                      color: const Color(0xFF606573)),
                                                                ),
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
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Icon(
                                                              Icons.arrow_back_ios,
                                                              color: Colors.white,
                                                              size: 20,
                                                            ),
                                                            Icon(
                                                              Icons.arrow_forward_ios,
                                                              color: Colors.white,
                                                              size: 20,
                                                            )
                                                          ],
                                                        )),
                                                    Positioned(
                                                        bottom: 10,
                                                        right: 20,
                                                        //   bottom: 0,
                                                        child: Column(
                                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Container(
                                                                height: 55,
                                                                // width: 30,
                                                                decoration: const BoxDecoration(
                                                                    shape: BoxShape.circle, color: Colors.white),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(4),
                                                                  child:
                                                                      // Image.asset('assets/images/avtarImg.png'),

                                                                      SizedBox(
                                                                    height: 50,
                                                                    width: 50,
                                                                    child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(50),
                                                                      child: CachedNetworkImage(
                                                                        imageUrl: homeController.isDataLoading.value
                                                                            ? homeController.model.value.data!.stores![index]
                                                                                .profileImage
                                                                                .toString()
                                                                            : 'assets/images/avtarImg.png',
                                                                        // height: 40,
                                                                        fit: BoxFit.cover,
                                                                        errorWidget: (_, __, ___) => Image.asset(
                                                                          'assets/images/dummyPerson.png',
                                                                          fit: BoxFit.cover,
                                                                          // height: 20,
                                                                          // width: 20,
                                                                        ),
                                                                        placeholder: (_, __) =>
                                                                            const Center(child: CircularProgressIndicator()),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )),
                                                            addHeight(3),
                                                            Text(
                                                              (homeController
                                                                          .model.value.data!.stores![index].cookName!.isEmpty
                                                                      ? 'Test'
                                                                      : homeController
                                                                          .model.value.data!.stores![index].cookName)
                                                                  .toString(),
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 12,
                                                                  color: const Color(0xFF21283D)),
                                                            ),
                                                            Row(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                const Icon(
                                                                  Icons.star,
                                                                  color: Color(0xFFFFC529),
                                                                  size: 14,
                                                                ),
                                                                addWidth(3),
                                                                Text(
                                                                  homeController.model.value.data!.stores![index].rating
                                                                      .toString(),
                                                                  style: GoogleFonts.poppins(
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 11,
                                                                      color: const Color(0xFF6A7080)),
                                                                ),
                                                                Text(
                                                                  '(${(homeController.model.value.data!.stores![index].countReviewData!.isEmpty ? '3' : '').toString()})',
                                                                  style: GoogleFonts.poppins(
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 11,
                                                                      color: const Color(0xFF6A7080)),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        )),
                                                    Positioned(
                                                        top: 16,
                                                        right: 10,
                                                        child: InkWell(
                                                            onTap: () {
                                                              print(
                                                                  "store  id..${homeController.model.value.data!.stores![index].id.toString()}");

                                                              wishlistRepo(
                                                                      id: homeController.model.value.data!.stores![index].id
                                                                          .toString(),
                                                                      productId: '')
                                                                  .then((value) {
                                                                if (value.status == true) {
                                                                  showToast(value.message);
                                                                  homeController.getData();
                                                                }
                                                              });
                                                            },
                                                            child: homeController.model.value.data!.stores![index].wishlist!
                                                                ? Container(
                                                                    height: 33,
                                                                    decoration: const BoxDecoration(
                                                                        shape: BoxShape.circle, color: Colors.white),
                                                                    child: const Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: 10, right: 10, top: 3),
                                                                        child: Icon(
                                                                          Icons.favorite,
                                                                          color: Color(0xFF7ED957),
                                                                        )))
                                                                : Container(
                                                                    height: 33,
                                                                    decoration: const BoxDecoration(
                                                                        shape: BoxShape.circle, color: Colors.white),
                                                                    child: const Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: 10, right: 10, top: 3),
                                                                        child: Icon(
                                                                          Icons.favorite_outline,
                                                                          color: Color(0xFF7ED957),
                                                                        ))))),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              // SizedBox(
                              //    height: 120,
                              //    child: ListView.builder(
                              //        shrinkWrap: true,
                              //        scrollDirection: Axis.horizontal,
                              //        itemCount: categoryController.categoryModel.value.data!.categories!.length,
                              //        itemBuilder: (context, index) {
                              //          return Padding(
                              //            padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 7),
                              //            child:
                              //            Row(
                              //                children:[
                              //
                              //                  InkWell(
                              //                    onTap: () {
                              //                      currentIndex = index;
                              //                      setState(() {
                              //
                              //                      });
                              //                    },
                              //                    child: Container(
                              //                      // margin: EdgeInsets.symmetric(vertical: 5),
                              //                      height: 42,
                              //                      // width: 110,
                              //                      decoration: BoxDecoration(
                              //                          color: currentIndex != index ? Color(0xffF2F2F2): Color(0xff7ED957),
                              //                          borderRadius: BorderRadius.circular(
                              //                              5)
                              //
                              //                      ),
                              //                      child: Padding(
                              //                        padding: const EdgeInsets.all(8.0),
                              //                        child: Center(
                              //                          child: Text(categoryController.categoryModel.value.data!.categories![index].name.toString(), textAlign:TextAlign.center,style: GoogleFonts.ibmPlexSansArabic(fontSize: 15,
                              //                              fontWeight: FontWeight.w600,
                              //                              color: currentIndex != index ? Color(0xff000000):Color(0xffFFFFFF)),),
                              //                        ),
                              //                      ),
                              //                    ),
                              //                  ),
                              //                ]
                              //            ),
                              //          );
                              //        }),
                              //  ),
                              // addHeight(20),

                            ],
                          ),
                        ),
                      ],
                    )),
                  )
                : Center(child: CircularProgressIndicator()),
          );
        })
        //bottomNavigationBar: ,
        );
  }

  showUploadWindow(List category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              right: 35,
              top: 37,
              child: Container(
                  padding: EdgeInsets.all(10),
                  height: 80,
                  decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
                  child: GestureDetector(
                    child: const Icon(Icons.clear),
                    onTap: () {
                      Get.back();
                    },
                  )),
            ),
            Dialog(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AddSize.padding16,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: SingleChildScrollView(
                      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(
                          "Cuisine:",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 19,
                            color: const Color(0xFF425159),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Chinese',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                                color: const Color(0xFF425159),
                              ),
                            ),
                            Obx(() {
                              return Checkbox(
                                  side: const BorderSide(color: Colors.black, width: 2),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                                  value: _isValue1.value,
                                  onChanged: (value) {
                                    setState(() {
                                      _isValue1.value = value!;
                                    });
                                  });
                            })
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Vegetarian',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                                color: const Color(0xFF425159),
                              ),
                            ),
                            Obx(() {
                              return Checkbox(
                                  side: BorderSide(color: Colors.black, width: 2),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                                  value: _isValue2.value,
                                  onChanged: (value) {
                                    setState(() {
                                      _isValue2.value = value!;
                                    });
                                  });
                            })
                          ],
                        ),
                        Text(
                          "Dietary:",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 19,
                            color: const Color(0xFF425159),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: category.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext, index) {
                              return InkWell(
                                onTap: () {
                                  // homeController.filterCategoryId.value =
                                  //     categoryController.categoryModel.value.data!.category![index].id.toString();
                                  print("Filter Category Id is.  ${homeController.filterCategoryId}");
                                  // Get.toNamed(MyRouters.homeDetailsScreen);
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          category[index].name.toString(),
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                            color: const Color(0xFF425159),
                                          ),
                                        ),
                                        Obx(() {
                                          return Checkbox(
                                              side: const BorderSide(color: Colors.black, width: 2),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                                              value: categoryController
                                                  .categoryModel.value.data!.category![index].isChecked.value,
                                              onChanged: (value) {
                                                setState(() {
                                                  categoryController
                                                          .categoryModel.value.data!.category![index].isChecked.value =
                                                      !categoryController
                                                          .categoryModel.value.data!.category![index].isChecked.value;
                                                  if (categoryController
                                                          .categoryModel.value.data!.category![index].isChecked.value ==
                                                      true) {
                                                    categoryController.categoryModel.value.data!.selectedContacts!.add(
                                                        categoryController.categoryModel.value.data!.category![index]);
                                                    // kk.value = index;
                                                    print(index);
                                                  } else if (categoryController
                                                          .categoryModel.value.data!.category![index].isChecked.value ==
                                                      false) {
                                                    categoryController.categoryModel.value.data!.selectedContacts!
                                                        .removeWhere((element) =>
                                                            element.id ==
                                                            categoryController
                                                                .categoryModel.value.data!.category![index].id);
                                                  }
                                                });
                                              });
                                        })
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),

                        Center(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: SizedBox(
                                width: 100,
                                child: ElevatedButton(
                                  child: const Text("Filter"),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              )),
                        )

                        // SizedBox(height: 15,),
                      ]),
                    ),
                  )),
            ),
          ],
        );
      },
    );
  }

// filter category product
  Future<void> _showSimpleDialog1() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Stack(
            children: [
              Positioned(
                right: 35,
                top: 170,
                child: Container(
                    padding: EdgeInsets.all(10),
                    height: 80,
                    decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
                    child: GestureDetector(
                      child: const Icon(Icons.clear),
                      onTap: () {
                        Get.back();
                      },
                    )),
              ),
              Dialog(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "Sort By:",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: items.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext, index) {
                            return InkWell(
                              onTap: () {
                                // print("Id is ${items[index].id}");
                                //  filterProductCategoryRepo(distance:items[index].id ).then((value){
                                //    if(value.status==true){
                                //      Get.toNamed(FilterProductScreen.filterProductScreen);
                                //    }
                                //    else{
                                //      showToast(value.message);
                                //    }
                                //  });

                                Get.toNamed(FilterProductScreen.filterProductScreen,arguments: [items[index].id].toString());
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      items[index].name,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18,
                                        color: const Color(0xFF425159),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        height: 7,
                      ),
                      Center(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                child: const Text("Filter"),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            )),
                      )

                      // SizedBox(height: 15,),
                    ]),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> _showSimpleDialog2(BuildContext context) async {
    await showDialog(
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        context: context,
        barrierColor: const Color(0x01000000),
        builder: (context) {
          return Obx(() {
            return Dialog(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              insetPadding: const EdgeInsets.only(bottom: 0, top: 220),
              child: searchController.isDataLoading.value
                  ? searchController.searchDataModel.value.data!.isNotEmpty
                      ? ListView.builder(
                          itemCount: searchController.searchDataModel.value.data!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
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
                                                  color: const Color(0xFF37C666).withOpacity(0.10),
                                                  offset: const Offset(
                                                    .1,
                                                    .1,
                                                  ),
                                                  blurRadius: 20.0,
                                                  spreadRadius: 1.0,
                                                ),
                                              ],
                                              borderRadius: BorderRadius.circular(12)),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      child: Image.asset(
                                                    'assets/images/Rectangle 39762.png',
                                                    height: 80,
                                                    width: 70,
                                                  )),
                                                  addWidth(10),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        searchController.searchDataModel.value.data![index].name.toString(),
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 14,
                                                            color: const Color(0xFF21283D)),
                                                      ),
                                                      addHeight(3),
                                                      Text(
                                                        searchController.searchDataModel.value.data![index].size.toString(),
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 11,
                                                            color: const Color(0xFF364A4F)),
                                                      ),
                                                      addHeight(3),
                                                      Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'spiciness :',
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 10,
                                                                    color: const Color(0xFF1F2D30)),
                                                              ),
                                                              addWidth(4),
                                                              Text(
                                                                'Mildly Spicy',
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 10,
                                                                    color: const Color(0xFF6CC844)),
                                                              ),
                                                            ],
                                                          ),
                                                          addWidth(10),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'Allergens :',
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 10,
                                                                    color: const Color(0xFF1F2D30)),
                                                              ),
                                                              addWidth(4),
                                                              Text(
                                                                'Crustaceans',
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 10,
                                                                    color: const Color(0xFF6CC844)),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      addHeight(6),
                                                      IntrinsicHeight(
                                                        child: Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                _decrement();
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(color: const Color(0xFF72CD4A)),
                                                                    shape: BoxShape.circle),
                                                                alignment: Alignment.center,
                                                                child: const Padding(
                                                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                                                  child: Text(
                                                                    '-',
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 16,
                                                                        color: Color(0xFF72CD4A)),
                                                                    textAlign: TextAlign.center,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Obx(() {
                                                              return Container(
                                                                alignment: Alignment.center,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                                                                  child: Text('${count}'),
                                                                ),
                                                              );
                                                            }),
                                                            GestureDetector(
                                                              onTap: () {
                                                                _increment();
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: const Color(0xFF72CD4A),
                                                                    border: Border.all(color: const Color(0xFF72CD4A)),
                                                                    shape: BoxShape.circle),
                                                                alignment: Alignment.center,
                                                                child: const Padding(
                                                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                                                  child: Text(
                                                                    '+',
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 16,
                                                                        color: Colors.white),
                                                                    textAlign: TextAlign.center,
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
                                                    'assets/images/helpimg.png',
                                                    height: 13,
                                                  ),
                                                  addWidth(4),
                                                  Text(
                                                    'Can cook more units by: 30th June 2023',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 11,
                                                        color: const Color(0xFF364A4F)),
                                                  ),
                                                ],
                                              ),
                                              addHeight(4),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  addWidth(80),
                                                  Image.asset(
                                                    'assets/images/helpimg.png',
                                                    height: 13,
                                                  ),
                                                  addWidth(4),
                                                  Text(
                                                    'Available stock: ',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 11,
                                                        color: const Color(0xFF364A4F)),
                                                  ),
                                                  Text(
                                                    ' 3 units',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 11,
                                                        color: const Color(0xFF364A4F)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: 14,
                                          right: 20,
                                          child: Text(
                                            searchController.searchDataModel.value.data![index].price.toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w700, fontSize: 15, color: const Color(0xFF70CC49)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Center(child: Text('No Search'))
                  : Center(child: const CircularProgressIndicator()),
            );
          });
        });
  }

  Future<void> _showSimpleDialog4(BuildContext context) async {
    await showDialog(
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        context: context,
        barrierColor: const Color(0x01000000),
        builder: (context) {
          return Obx(() {
            return Dialog(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              insetPadding: const EdgeInsets.only(bottom: 0, top: 220),
              child: searchController.isDataLoading.value
                  ? searchController.searchDataModel.value.data!.isNotEmpty
                      ? ListView.builder(
                          itemCount: searchController.searchDataModel.value.data!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
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
                                                  color: const Color(0xFF37C666).withOpacity(0.10),
                                                  offset: const Offset(
                                                    .1,
                                                    .1,
                                                  ),
                                                  blurRadius: 20.0,
                                                  spreadRadius: 1.0,
                                                ),
                                              ],
                                              borderRadius: BorderRadius.circular(12)),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      child: Image.asset(
                                                    'assets/images/Rectangle 39762.png',
                                                    height: 80,
                                                    width: 70,
                                                  )),
                                                  addWidth(10),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        searchController.searchDataModel.value.data![index].name.toString(),
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 14,
                                                            color: const Color(0xFF21283D)),
                                                      ),
                                                      addHeight(3),
                                                      Text(
                                                        searchController.searchDataModel.value.data![index].size.toString(),
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 11,
                                                            color: const Color(0xFF364A4F)),
                                                      ),
                                                      addHeight(3),
                                                      Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'spiciness :',
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 10,
                                                                    color: const Color(0xFF1F2D30)),
                                                              ),
                                                              addWidth(4),
                                                              Text(
                                                                'Mildly Spicy',
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 10,
                                                                    color: const Color(0xFF6CC844)),
                                                              ),
                                                            ],
                                                          ),
                                                          addWidth(10),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'Allergens :',
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 10,
                                                                    color: const Color(0xFF1F2D30)),
                                                              ),
                                                              addWidth(4),
                                                              Text(
                                                                'Crustaceans',
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 10,
                                                                    color: const Color(0xFF6CC844)),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      addHeight(6),
                                                      IntrinsicHeight(
                                                        child: Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                _decrement();
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(color: const Color(0xFF72CD4A)),
                                                                    shape: BoxShape.circle),
                                                                alignment: Alignment.center,
                                                                child: const Padding(
                                                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                                                  child: Text(
                                                                    '-',
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 16,
                                                                        color: Color(0xFF72CD4A)),
                                                                    textAlign: TextAlign.center,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Obx(() {
                                                              return Container(
                                                                alignment: Alignment.center,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                                                                  child: Text('${count}'),
                                                                ),
                                                              );
                                                            }),
                                                            GestureDetector(
                                                              onTap: () {
                                                                _increment();
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: const Color(0xFF72CD4A),
                                                                    border: Border.all(color: const Color(0xFF72CD4A)),
                                                                    shape: BoxShape.circle),
                                                                alignment: Alignment.center,
                                                                child: const Padding(
                                                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                                                  child: Text(
                                                                    '+',
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 16,
                                                                        color: Colors.white),
                                                                    textAlign: TextAlign.center,
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
                                                    'assets/images/helpimg.png',
                                                    height: 13,
                                                  ),
                                                  addWidth(4),
                                                  Text(
                                                    'Can cook more units by: 30th June 2023',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 11,
                                                        color: const Color(0xFF364A4F)),
                                                  ),
                                                ],
                                              ),
                                              addHeight(4),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  addWidth(80),
                                                  Image.asset(
                                                    'assets/images/helpimg.png',
                                                    height: 13,
                                                  ),
                                                  addWidth(4),
                                                  Text(
                                                    'Available stock: ',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 11,
                                                        color: const Color(0xFF364A4F)),
                                                  ),
                                                  Text(
                                                    ' 3 units',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 11,
                                                        color: const Color(0xFF364A4F)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: 14,
                                          right: 20,
                                          child: Text(
                                            searchController.searchDataModel.value.data![index].price.toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w700, fontSize: 15, color: const Color(0xFF70CC49)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Center(child: Text('No Data Found'))
                  : Center(child: const CircularProgressIndicator()),
            );
          });
        });
  }
}
class ItemDropDown {
  final String id;
  final String name;
  const ItemDropDown(this.id, this.name);
}
