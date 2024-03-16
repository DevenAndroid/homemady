import 'dart:developer';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/Screens/search_screen_data.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:homemady/widgets/dimenestion.dart';
import 'package:intl/intl.dart';
import 'package:salesiq_mobilisten/launcher.dart';
import 'dart:io' as io;
import 'package:salesiq_mobilisten/salesiq_mobilisten.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../controller/category_controller.dart';
import '../controller/fillter_product_category_controller.dart';
import '../controller/filter_controller.dart';
import '../controller/homepage_controller.dart';
import '../controller/location_controller.dart';
import '../controller/my_address_controller.dart';
import '../controller/my_cart_controller.dart';
import '../controller/search_store_conbtroller.dart';
import '../controller/time_slot_controller.dart';
import '../controller/user_profile_controller.dart';
import '../controller/vendor_single_store_controller.dart';
import '../repository/update_location_repo.dart';
import '../repository/wishlist_repo.dart';
import '../resources/add_text.dart';
import '../widgets/app_theme.dart';
import 'homedetails_Screen.dart';
import 'login_screen.dart';
import 'myAddressScreen.dart';
import 'mycart_Screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

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
  final filterDataController = Get.put(FilterController());
  final locationController = Get.put(LocationController());

  bool? sortedFilter = false;
  String? selectedCategory;
  bool? isAvailableSelected = false;
  int currentIndex = 0;
  List categoryItemList = ['A\' la Carte', 'Catering', 'Meal Prep'];

  bool isUserlogin = false;

  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user_info') != null) {
      isUserlogin = true;
    } else {
      isUserlogin = false;
    }
    return isUserlogin;
  }

  List<ItemDropDown> items = <ItemDropDown>[
    const ItemDropDown('sustainable_packaging', 'Sustainable Packaging'),
    const ItemDropDown('distance', 'Distance'),
    const ItemDropDown('top_chef', 'Top Chefs'),
    const ItemDropDown('rating', 'Rating'),
    const ItemDropDown('collection_only', 'Collection Only'),
    const ItemDropDown('quickest_delivery', 'Quickest Delivery'),
  ];

  bool? isChoosedFilterOption = false;
  bool? isFilterOff = false;

  final scrollController = ScrollController();

  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    homeController.selectedDate = 'Available Now';
    // log("Longitude1234: ${locationController.long.value}");

    FocusManager.instance.primaryFocus!.unfocus();
    locationController.checkGps(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      isUserLoggedIn();
      if (isUserlogin == true) {
        homeController.getData(
            filter: (currentIndex + 2).toString(),
            latitude: profileController.model.value.data!.latitude,
            longitude: profileController.model.value.data!.longitude);
      } else {
        homeController.getData(
            filter: (currentIndex + 2).toString(),
            latitude: locationController.lat.value,
            longitude: locationController.long.value);
      }
      filterDataController.getFilterData();
      profileController.getData();
      scrollController.addListener((_scrollListener));
      // scrollController1.addListener((_scrollListener1));
       if(isUserlogin) {
         filterProductCategoryController.getFilterCategoryData(
             filter: "",
             context: context,
             categoryId: (currentIndex + 2).toString(),
             latitude: profileController.model.value.data!.latitude,
             longitude: profileController.model.value.data!.longitude);
       }else {
         filterProductCategoryController.getFilterCategoryData(
             filter: "",
             context: context,
             categoryId: (currentIndex + 2).toString(),
             latitude: locationController.lat.value,
             longitude: locationController.long.value);
       }

      myCartController.getData();
      categoryController.getCategoryData();
      categoryController.getDietaryData();
      timeSlotController.getTimeSlotData();
      myAddressController.getData();
      locationController.getLocation();
      controller.getStoreKeywordListData();
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

  DateTime? pickedDate;

  showDate() async {
    return pickedDate = await showDatePicker(
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
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      // firstDate: DateTime(1950),
      //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(2025),
    ).then((value) {
      if (pickedDate != null) {
        // showChooseDate(context);
        String formattedDate = DateFormat('yyyy/MM/dd').format(pickedDate!);
        setState(() {
          homeController.selectedDate = formattedDate;
          setState(() {});
        });
      }
      return null;
    });
  }

  showChooseDate(index) {
    RxInt refreshInt = 0.obs;
    // DateTime now = DateTime.now();
    // String formattedTime = "${now.hour}:${now.minute}:${now.second}";
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
                              homeController.timeSlot = "${itemdata.startTime}-${itemdata.endTime}";
                              refreshInt.value = DateTime.now().millisecondsSinceEpoch;
                              // timeSlotController.giveTime.value = formattedTime;
                              timeSlotController.getTimeSlotData();
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: currentIndex != index ? Colors.white : const Color(0xFF7ED957),
                                    borderRadius: BorderRadius.circular(4),
                                    border: currentIndex == index
                                        ? Border.all(color: const Color(0xff7ED957), width: 2)
                                        : Border.all(color: const Color(0xFF717171).withOpacity(0.22), width: 1)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${itemdata.startTime}-${itemdata.endTime}",
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
                              timeSlotController.sendDate.value = homeController.selectedDate;
                              timeSlotController.getTimeSlotData();
                              // setState(() {});
                               print("Seleted Date"+ timeSlotController.getTimeSlotData().toString());
                              Get.back();
                              FocusManager.instance.primaryFocus!.unfocus();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff7ED957),
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

  Future onRefresh() async {
    homeController.selectedDate = 'Available Now';
    sortedFilter = false;
    currentIndex = 0;
    categoryController.dietiaryModel.value.data!.selectedIds.clear();
    categoryController.categoryModel.value.data!.selectedIds.clear();
    filterProductCategoryController
        .getFilterCategoryData(
            filter: filterProductCategoryController.filterId,
            categoryId: (currentIndex + 2).toString(),
            context: context)
        .then((value) {
      setState(() {});
    });
    await profileController.getData().then((value) {
      profileController.address.value = profileController.model.value.data!.defaultAddress![0].addressType.toString();
    });
    // await homeController.getData(filter: (currentIndex + 2).toString());
    if (isUserlogin == true) {
      homeController.getData(
          filter: (currentIndex + 2).toString(),
          latitude: profileController.model.value.data!.latitude,
          longitude: profileController.model.value.data!.longitude);
    } else {
      homeController.getData(
          filter: (currentIndex + 2).toString(),
          latitude: locationController.lat.value,
          longitude: locationController.long.value);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // if(isUserlogin == true){
    //   homeController.getData(
    //       filter: (currentIndex + 2).toString(),
    //       latitude: profileController.model.value.data!.latitude,
    //       longitude: profileController.model.value.data!.longitude);
    // }

    log("fgfhgfhhghgh");
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    profileController.scaffoldKey.currentState!.openDrawer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Image.asset(
                      'assets/images/BurgerIcon.png',
                      height: 35,
                    ),
                  ),
                  // Obx(() {
                  //   return ClipRRect(
                  //     borderRadius: BorderRadius.circular(50),
                  //     child: CachedNetworkImage(
                  //       imageUrl: profileController.isDataLoading.value
                  //           ? (profileController.model.value.data!.profileImage).toString()
                  //           : '',
                  //       fit: BoxFit.cover,
                  //       height: 50,
                  //       width: 50,
                  //       errorWidget: (_, __, ___) => Image.asset(
                  //         'assets/images/dummyPerson.png',
                  //         fit: BoxFit.cover,
                  //         height: 50,
                  //         width: 50,
                  //       ),
                  //       placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                  //     ),
                  //   );
                  // })
                  // Image.asset('assets/images/avtarImg.png', height: 45,)
                ),
                addWidth(10),
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
                        if (isUserlogin == true) {
                          Get.to(() => const MyAddressScreen(), arguments: 'home');
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        }
                      }, child: Obx(() {
                        if (profileController.refreshInt.value > 0) {}
                        if (homeController.isDataLoading.value && profileController.isDataLoading.value) {}
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
                                homeController.isDataLoading.value && profileController.isDataLoading.value
                                    ? profileController.model.value.data!.defaultAddress!.isNotEmpty
                                        ? profileController.model.value.data!.defaultAddress![0].addressType.toString()
                                        : profileController.address.value.toString()
                                    : "",
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
                  badgeStyle: const BadgeStyle(padding: EdgeInsets.all(7)),
                  badgeContent: Obx(() {
                    return Text(
                      myCartController.isDataLoading.value ? myCartController.sum.value.toString() : '0',
                      style: const TextStyle(color: Colors.white),
                    );
                  }),
                  child: GestureDetector(
                    onTap: () {
                      // Get.toNamed(MyRouters.myCartScreen);
                      Get.to(() => const MyCartScreen());
                    },
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xFF7ED957)),
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
            //toolbarHeight: 70,
            //toolbarHeight: 70,
          ),
          body: Obx(() {
            return RefreshIndicator(
                onRefresh: onRefresh,
                child: SafeArea(
                  child: homeController.isDataLoading.value
                      ? SingleChildScrollView(
                          padding: const EdgeInsets.only(left: 14, top: 6),
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      print("tttttttt" + locationController.lat.value.toString());
                                    },
                                    child: Text(
                                      'Hello',
                                      style: GoogleFonts.poppins(
                                          color: const Color(0xFF676767), fontWeight: FontWeight.w300, fontSize: 16),
                                    ),
                                  ),
                                  // Text(
                                  //   profileController.model.value.data!.name.toString().capitalizeFirst.toString(),
                                  //   style: GoogleFonts.poppins(
                                  //       color: const Color(0xFF353535), fontWeight: FontWeight.w600, fontSize: 22),
                                  // ),
                                ],
                              ),
                              addHeight(16),
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
                                          controller: filterDataController.storeSearchController,
                                          prefix: InkWell(
                                            onTap: () {
                                              FocusManager.instance.primaryFocus!.unfocus();
                                              filterDataController.getFilterData();
                                              if (filterDataController.storeSearchController.text.isNotEmpty) {
                                                Get.toNamed(
                                                  SearchScreenData.searchScreen,
                                                );
                                              }
                                            },
                                            child: Icon(
                                              Icons.search,
                                              size: 19,
                                              color: const Color(0xFF000000).withOpacity(0.56),
                                            ),
                                          ),
                                          onSubmited: (val1) {
                                            Get.toNamed(
                                              SearchScreenData.searchScreen,
                                            );
                                          },
                                          onChanged: (val) {
                                            searchController.getSearchData();
                                          },
                                        )),
                                  ),
                                  addWidth(8),
                                  GestureDetector(
                                    onTap: () {
                                      if (homeController.selectedDate != "Available Now" ||
                                          isAvailableSelected == true) {
                                        showUploadWindow();
                                        // Get.toNamed(SearchScreenData.searchScreen, arguments: [selectedDate]);
                                      } else {
                                        showToast("Please pick a date");
                                        FocusManager.instance.primaryFocus!.unfocus();
                                      }
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
                                  addWidth(8),
                                  GestureDetector(
                                    onTap: _showSimpleDialog1,
                                    behavior: HitTestBehavior.translucent,
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
                              addHeight(26),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      itemCount: homeController.model.value.data!.sliderData!.length,
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                // Get.toNamed(MyRouters.homeDetailsScreen, arguments: [
                                                //   homeController.model.value.data!.sliderData![index].storeId.toString()
                                                // ]);

                                                Get.to(() => HomeDetailsScreen(
                                                    storeId: homeController.model.value.data!.sliderData![index].storeId
                                                        .toString()));
                                              },
                                              child: Container(
                                                width: width * .55,
                                                margin: EdgeInsets.symmetric(horizontal: width * .01),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color: AppTheme.backgroundcolor),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: CachedNetworkImage(
                                                    imageUrl: homeController.model.value.data!.sliderData![index].image
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                    errorWidget: (_, __, ___) => Image.asset(
                                                      'assets/images/Ellipse 67.png',
                                                    ),
                                                    // placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                                                  ),
                                                ),
                                              ),
                                            )
                                            // addWidth(20)
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
                                            onTap: () {
                                              if (homeController.selectedDate == 'Available Now') {
                                                filterDataController.sendDate = DateTime.now();
                                                filterDataController.getFilterData();
                                              } else {
                                                showToast("Please pick a date");
                                              }
                                            },
                                            child: Container(
                                              height: 44,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4),
                                                  border: homeController.selectedDate == 'Available Now' &&
                                                          isAvailableSelected == false
                                                      ? Border.all(color: const Color(0xff7ED957), width: 2)
                                                      : Border.all(
                                                          color: const Color(0xFF717171).withOpacity(0.22), width: 1)),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  homeController.selectedDate == 'Available Now' &&
                                                          isAvailableSelected == false
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            isAvailableSelected = !isAvailableSelected!;
                                                            setState(() {});
                                                          },
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Image.asset(
                                                              'assets/images/clockImg.png',
                                                              height: 18,
                                                            ),
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
                                                  homeController.selectedDate == 'Available Now' &&
                                                          isAvailableSelected == false
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            isAvailableSelected = !isAvailableSelected!;
                                                            setState(() {});
                                                          },
                                                          child: Text(
                                                            "Available Now",
                                                            style: GoogleFonts.poppins(
                                                              color: const Color(0xFF7ED957),
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                        )
                                                      : Text(
                                                          homeController.selectedDate,
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
                                              if(isUserlogin){
                                                FocusManager.instance.primaryFocus!.unfocus();

                                                showChooseDate(context);
                                                // showDate();
                                                pickedDate = await showDatePicker(
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
                                                  initialDate: filterDataController.sendDate,
                                                  firstDate: DateTime.now().subtract(const Duration(days: 0)),
                                                  // firstDate: DateTime(1950),
                                                  //DateTime.now() - not to allow to choose before today.
                                                  lastDate: DateTime(2025),
                                                ).then((value) {
                                                  if (value != null) {
                                                    filterDataController.sendDate = value;
                                                    String formattedDate = DateFormat('yyyy/MM/dd').format(value);
                                                    setState(() {
                                                      // var selectedDate=formattedDate;
                                                      homeController.selectedDate =
                                                          formattedDate;

                                                      timeSlotController.sendDate.value = homeController.selectedDate;
                                                      timeSlotController.getTimeSlotData();
                                                      //set output date to TextField value.
                                                      print("Seleted Date" + homeController.selectedDate);
                                                    });
                                                  }
                                                  return null;
                                                });

                                                if (pickedDate != null) {
                                                  // showChooseDate(context);
                                                  String formattedDate = DateFormat('yyyy/MM/dd').format(pickedDate!);
                                                  setState(() {
                                                    homeController.selectedDate = formattedDate;
                                                    print("Seleted Date" + homeController.selectedDate);
                                                  });
                                                }
                                              }else{
                                                Get.to(const LoginScreen());
                                              }

                                            },
                                            child: Container(
                                                height: 44,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4),
                                                  color: const Color(0xFF7ED957),
                                                ),
                                                child: homeController.selectedDate == 'Available Now'
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
                                  addHeight(10),
                                  SizedBox(
                                    height: 80,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: categoryItemList.length,
                                        itemBuilder: (context, index) {
                                          return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                            InkWell(
                                              onTap: () {
                                                FocusManager.instance.primaryFocus!.unfocus();
                                                currentIndex = index;
                                                if (sortedFilter == true) {
                                                  filterProductCategoryController
                                                      .getFilterCategoryData(
                                                          filter: filterProductCategoryController.filterId,
                                                          categoryId: (currentIndex + 2).toString(),
                                                          context: context)
                                                      .then((value) {
                                                    setState(() {});
                                                  });
                                                } else {
                                                  if (isUserlogin == true) {
                                                    homeController.getData(
                                                        filter: (currentIndex + 2).toString(),
                                                        latitude: profileController.model.value.data!.latitude,
                                                        longitude: profileController.model.value.data!.longitude);
                                                  } else {
                                                    homeController.getData(
                                                        filter: (currentIndex + 2).toString(),
                                                        latitude: locationController.lat.value,
                                                        longitude: locationController.long.value);
                                                  }
                                                }
                                                setState(() {});
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 3),
                                                child: Container(
                                                  // margin: const EdgeInsets.symmetric(vertical: 5),
                                                  height: 52,
                                                  width: 110,
                                                  decoration: BoxDecoration(
                                                      color: currentIndex != index
                                                          ? const Color(0xffF2F2F2).withOpacity(.10)
                                                          : const Color(0xff7ED957),
                                                      borderRadius: BorderRadius.circular(30)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Center(
                                                      child: Text(
                                                        categoryItemList[index].toString(),
                                                        textAlign: TextAlign.center,
                                                        style: GoogleFonts.ibmPlexSansArabic(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w600,
                                                            color: currentIndex != index
                                                                ? const Color(0xff000000)
                                                                : const Color(0xffFFFFFF)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]);
                                        }),
                                  ),
                                  addHeight(10),
                                  sortedFilter == false
                                      ? Obx(() {
                                          return normalList(height, width);
                                        })
                                      : Obx(() {
                                          return filteredList(height, width);
                                        }),
                                ],
                              ),

                              // addWidth(30),
                              // sort

                              addHeight(20),
                            ],
                          ))
                      : const Center(child: CircularProgressIndicator()),
                ));
          })
          //bottomNavigationBar: ,
          ),
    );
  }

  Padding filteredList(double height, double width) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          SizedBox(
              child: filterProductCategoryController.filterDataModel.value.data != null
                  ? filterProductCategoryController.filterDataModel.value.data!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: filterProductCategoryController.filterDataModel.value.data!.length,
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
                                              Get.to(() => HomeDetailsScreen(
                                                  storeId: filterProductCategoryController
                                                      .filterDataModel.value.data![index].id
                                                      .toString()));
                                              // Get.toNamed(MyRouters.homeDetailsScreen, arguments: [
                                              //   filterProductCategoryController
                                              //       .filterDataModel.value.data![index].id
                                              //       .toString()
                                              // ]);
                                            },
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(8),
                                                  child: CachedNetworkImage(
                                                    imageUrl: filterProductCategoryController
                                                        .filterDataModel.value.data![index].image
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
                                                addHeight(6),
                                                Text(
                                                  filterProductCategoryController
                                                      .filterDataModel.value.data![index].name
                                                      .toString()
                                                      .capitalizeFirst
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
                                                    Expanded(
                                                      child: buildTextFilter(index),
                                                    ),
                                                    addWidth(110),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (filterProductCategoryController.filterDataModel.value.data![index].award !=
                                            null)
                                          filterProductCategoryController
                                                      .filterDataModel.value.data![index].award!.isNotEmpty ||
                                                  filterProductCategoryController.filterDataModel.value.data![index]
                                                          .sustainablePackagingStatus ==
                                                      true
                                              ? Positioned(
                                                  top: 14,
                                                  // bottom: 0,
                                                  left: 10,
                                                  right: 15,
                                                  //   bottom: 0,
                                                  child: Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          ...List.generate(
                                                              filterProductCategoryController.filterDataModel.value
                                                                  .data![index].award!.length, (index1) {
                                                            return InkWell(
                                                              onTap: () {
                                                                showGeneralDialog(
                                                                    context: context,
                                                                    barrierDismissible: true,
                                                                    barrierColor:
                                                                        const Color(0xFF000000).withOpacity(0.58),
                                                                    barrierLabel: MaterialLocalizations.of(context)
                                                                        .modalBarrierDismissLabel,
                                                                    pageBuilder: (BuildContext context, Animation first,
                                                                        Animation second) {
                                                                      return Stack(
                                                                        children: [
                                                                          Center(
                                                                              child: CachedNetworkImage(
                                                                            imageUrl: filterProductCategoryController
                                                                                .filterDataModel
                                                                                .value
                                                                                .data![index]
                                                                                .award![index1]
                                                                                .image
                                                                                .toString(),
                                                                            //fit: BoxFit.cover,
                                                                            height: height * .7,
                                                                            width: width * .7,
                                                                            errorWidget: (_, __, ___) => Image.asset(
                                                                              'assets/images/topChef.png',
                                                                              // fit: BoxFit.cover,
                                                                              height: 40,
                                                                              width: 40,
                                                                            ),
                                                                            placeholder: (_, __) => const Center(
                                                                                child: CircularProgressIndicator()),
                                                                          )),
                                                                          Positioned(
                                                                            right: 22,
                                                                            top: 100,
                                                                            child: GestureDetector(
                                                                              onTap: () {
                                                                                Get.back();
                                                                              },
                                                                              child: Container(
                                                                                  padding: const EdgeInsets.all(10),
                                                                                  height: 50,
                                                                                  decoration: const BoxDecoration(
                                                                                      color: Colors.white,
                                                                                      shape: BoxShape.circle),
                                                                                  child: const Icon(Icons.clear)),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      );
                                                                    });
                                                              },
                                                              child: CachedNetworkImage(
                                                                imageUrl: filterProductCategoryController
                                                                    .filterDataModel
                                                                    .value
                                                                    .data![index]
                                                                    .award![index1]
                                                                    .image
                                                                    .toString(),
                                                                //fit: BoxFit.cover,
                                                                height: 70,
                                                                width: 70,
                                                                errorWidget: (_, __, ___) => Image.asset(
                                                                  'assets/images/topChef.png',
                                                                  // fit: BoxFit.cover,
                                                                  height: 40,
                                                                  width: 40,
                                                                ),
                                                                placeholder: (_, __) =>
                                                                    const Center(child: CircularProgressIndicator()),
                                                              ),
                                                            );
                                                          })
                                                        ],
                                                      ),
                                                      if (filterProductCategoryController.filterDataModel.value
                                                              .data![index].sustainablePackagingStatus ==
                                                          true)
                                                        InkWell(
                                                          onTap: () {
                                                            showGeneralDialog(
                                                                context: context,
                                                                barrierDismissible: true,
                                                                barrierColor: const Color(0xFF000000).withOpacity(0.58),
                                                                barrierLabel: MaterialLocalizations.of(context)
                                                                    .modalBarrierDismissLabel,
                                                                pageBuilder: (BuildContext context, Animation first,
                                                                    Animation second) {
                                                                  return Stack(
                                                                    children: [
                                                                      Center(
                                                                        child: Image.asset(
                                                                          'assets/images/leavesIcon.png',
                                                                          // fit: BoxFit.cover,
                                                                          height: height * .3,
                                                                          // width: width * .4,
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        right: 20,
                                                                        top: 100,
                                                                        child: GestureDetector(
                                                                          onTap: () {
                                                                            Get.back();
                                                                          },
                                                                          child: Container(
                                                                              padding: const EdgeInsets.all(10),
                                                                              height: 50,
                                                                              decoration: const BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  shape: BoxShape.circle),
                                                                              child: const Icon(Icons.clear)),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  );
                                                                });
                                                          },
                                                          child: Image.asset(
                                                            'assets/images/leavesIcon.png',
                                                            // fit: BoxFit.cover,
                                                            height: 65,
                                                            width: 65,
                                                          ),
                                                        )
                                                    ],
                                                  ))
                                              : const SizedBox(),
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
                                                            imageUrl:
                                                                filterProductCategoryController.isDataLoading.value
                                                                    ? filterProductCategoryController
                                                                        .filterDataModel.value.data![index].profileImage
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
                                                if (filterProductCategoryController
                                                        .filterDataModel.value.data![index].cookName !=
                                                    null)
                                                  Text(
                                                    (filterProductCategoryController
                                                                .filterDataModel.value.data![index].cookName!.isEmpty
                                                            ? 'Test'
                                                            : filterProductCategoryController
                                                                .filterDataModel.value.data![index].cookName)
                                                        .toString()
                                                        .capitalizeFirst
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 12,
                                                        color: const Color(0xFF21283D)),
                                                  ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      color: Color(0xFFFFC529),
                                                      size: 14,
                                                    ),
                                                    addWidth(3),
                                                    Text(
                                                      filterProductCategoryController
                                                          .filterDataModel.value.data![index].rating
                                                          .toString(),
                                                      style: GoogleFonts.poppins(
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 11,
                                                          color: const Color(0xFF6A7080)),
                                                    ),
                                                    Text(
                                                      '(${(filterProductCategoryController.filterDataModel.value.data![index].countReviewData).toString()})',
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
                                                  wishlistRepo(
                                                          id: filterProductCategoryController
                                                              .filterDataModel.value.data![index].id
                                                              .toString(),
                                                          productId: '')
                                                      .then((value) {
                                                    if (value.status == true) {
                                                      showToast(value.message);
                                                      filterProductCategoryController.getFilterCategoryData(
                                                          filter: "",
                                                          categoryId: (currentIndex + 2).toString(),
                                                          context: context,
                                                          latitude: profileController.model.value.data!.latitude,
                                                          longitude: profileController.model.value.data!.longitude
                                                      );
                                                      filterProductCategoryController.getFilterCategoryData(
                                                          filter: "",
                                                          categoryId: (currentIndex + 2).toString(),
                                                          context: context,
                                                          latitude: locationController.lat.value,
                                                          longitude: locationController.long.value
                                                      );
                                                    }
                                                  });
                                                },
                                                child: filterProductCategoryController
                                                        .filterDataModel.value.data![index].wishlist!
                                                    ? Container(
                                                        height: 33,
                                                        decoration: const BoxDecoration(
                                                            shape: BoxShape.circle, color: Colors.white),
                                                        child: const Padding(
                                                            padding: EdgeInsets.only(left: 10, right: 10, top: 3),
                                                            child: Icon(
                                                              Icons.favorite,
                                                              color: Color(0xFF7ED957),
                                                            )))
                                                    : Container(
                                                        height: 33,
                                                        decoration: const BoxDecoration(
                                                            shape: BoxShape.circle, color: Colors.white),
                                                        child: const Padding(
                                                            padding: EdgeInsets.only(left: 10, right: 10, top: 3),
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
                        )
                      : const Padding(
                          padding: EdgeInsets.only(top: 80),
                          child: Center(
                              child: Text(
                            'No Cooks available',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                          )),
                        )
                  : const Padding(
                      padding: EdgeInsets.only(top: 80),
                      child: Center(
                          child: Text(
                        'No Cooks available',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black),
                      )),
                    )),
        ],
      ),
    );
  }

  Column normalList(double height, double width) {
    return Column(
      children: [
        homeController.model.value.data!.stores!.isNotEmpty
            ? ListView.builder(
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
                                    Get.to(() => HomeDetailsScreen(
                                        storeId: homeController.model.value.data!.stores![index].id.toString()));
                                    // Get.toNamed(MyRouters.homeDetailsScreen, arguments: [
                                    //   homeController.model.value.data!.stores![index].id
                                    //       .toString()
                                    // ]);
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 150,
                                        child: ClipRRect(
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
                                            placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                                          ),
                                        ),
                                      ),
                                      addHeight(6),
                                      Text(
                                        homeController.model.value.data!.stores![index].name
                                            .toString()
                                            .capitalizeFirst
                                            .toString(),
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700, fontSize: 16, color: const Color(0xFF21283D)),
                                      ),
                                      addHeight(6),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'assets/images/truckimg.png',
                                            height: 22,
                                            color: const Color(0xFF04666E),
                                          ),
                                          addWidth(10),
                                          Expanded(
                                            child: buildText(index),
                                          ),
                                          addWidth(110),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              homeController.model.value.data!.stores![index].award!.isNotEmpty ||
                                      homeController.model.value.data!.stores![index].sustainablePackagingStatus == true
                                  ? Positioned(
                                      top: 14,
                                      // bottom: 0,
                                      left: 10,
                                      right: 15,
                                      //   bottom: 0,
                                      child: Row(
                                        children: [
                                          Row(
                                            children: [
                                              ...List.generate(
                                                  homeController.model.value.data!.stores![index].award!.length,
                                                  (index1) {
                                                return InkWell(
                                                  onTap: () {
                                                    showGeneralDialog(
                                                        context: context,
                                                        barrierDismissible: true,
                                                        barrierColor: const Color(0xFF000000).withOpacity(0.58),
                                                        barrierLabel:
                                                            MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                                        pageBuilder:
                                                            (BuildContext context, Animation first, Animation second) {
                                                          return Stack(
                                                            children: [
                                                              Center(
                                                                  child: CachedNetworkImage(
                                                                imageUrl: homeController.model.value.data!
                                                                    .stores![index].award![index1].image
                                                                    .toString(),
                                                                //fit: BoxFit.cover,
                                                                height: height * .7,
                                                                width: width * .7,
                                                                errorWidget: (_, __, ___) => Image.asset(
                                                                  'assets/images/topChef.png',
                                                                  // fit: BoxFit.cover,
                                                                  height: 40,
                                                                  width: 40,
                                                                ),
                                                                placeholder: (_, __) =>
                                                                    const Center(child: CircularProgressIndicator()),
                                                              )),
                                                              Positioned(
                                                                right: 22,
                                                                top: 100,
                                                                child: GestureDetector(
                                                                  onTap: () {
                                                                    Get.back();
                                                                  },
                                                                  child: Container(
                                                                      padding: const EdgeInsets.all(10),
                                                                      height: 50,
                                                                      decoration: const BoxDecoration(
                                                                          color: Colors.white, shape: BoxShape.circle),
                                                                      child: const Icon(Icons.clear)),
                                                                ),
                                                              )
                                                            ],
                                                          );
                                                        });
                                                  },
                                                  child: CachedNetworkImage(
                                                    imageUrl: homeController
                                                        .model.value.data!.stores![index].award![index1].image
                                                        .toString(),
                                                    //fit: BoxFit.cover,
                                                    height: 70,
                                                    width: 70,
                                                    errorWidget: (_, __, ___) => Image.asset(
                                                      'assets/images/topChef.png',
                                                      // fit: BoxFit.cover,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    placeholder: (_, __) =>
                                                        const Center(child: CircularProgressIndicator()),
                                                  ),
                                                );
                                              })
                                              // InkWell(
                                              //     onTap: (){
                                              //       showGeneralDialog(
                                              //           context: context,
                                              //           barrierDismissible: true,
                                              //           barrierColor: const Color(0xFF000000).withOpacity(0.58),
                                              //           barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                              //           pageBuilder: (BuildContext context,Animation first, Animation second){
                                              //             return  Stack(
                                              //               children: [
                                              //                 Center(child: CachedNetworkImage(
                                              //                   imageUrl:     homeController.model.value.data!.stores![index].award![index].image.toString(),
                                              //                   //fit: BoxFit.cover,
                                              //                   height: height * .7,
                                              //                   width: width * .7,
                                              //                   errorWidget: (_, __, ___) => Image.asset(
                                              //                     'assets/images/topChef.png',
                                              //                     // fit: BoxFit.cover,
                                              //                     height: height * .3,
                                              //                     width: width * .4,
                                              //                   ),
                                              //                   placeholder: (_, __) =>
                                              //                   const Center(child: CircularProgressIndicator()),
                                              //                 )),
                                              //                 Positioned(
                                              //                   right: 20,
                                              //                   top: 100,
                                              //                   child: GestureDetector(
                                              //                     onTap: (){
                                              //                       Get.back();
                                              //                     },
                                              //                     child: Container(
                                              //                         padding: const EdgeInsets.all(10),
                                              //                         height: 80,
                                              //                         decoration: const BoxDecoration(
                                              //                             color: Colors.white,
                                              //                             shape: BoxShape.circle
                                              //                         ),
                                              //                         child:  const Icon(Icons.clear)
                                              //                     ),
                                              //                   ),)
                                              //               ],
                                              //             );
                                              //           }
                                              //       );
                                              //     },
                                              //     child:    CachedNetworkImage(
                                              //       imageUrl:     homeController.model.value.data!.stores![index].award![0].image.toString(),
                                              //       //fit: BoxFit.cover,
                                              //       height: 40,
                                              //       width: 40,
                                              //       errorWidget: (_, __, ___) => Image.asset(
                                              //         'assets/images/topChef.png',
                                              //         // fit: BoxFit.cover,
                                              //         height: 40,
                                              //         width: 40,
                                              //       ),
                                              //       placeholder: (_, __) =>
                                              //       const Center(child: CircularProgressIndicator()),
                                              //     ),
                                              // ),
                                            ],
                                          ),
                                          if (homeController
                                                  .model.value.data!.stores![index].sustainablePackagingStatus ==
                                              true)
                                            InkWell(
                                              onTap: () {
                                                showGeneralDialog(
                                                    context: context,
                                                    barrierDismissible: true,
                                                    barrierColor: const Color(0xFF000000).withOpacity(0.58),
                                                    barrierLabel:
                                                        MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                                    pageBuilder:
                                                        (BuildContext context, Animation first, Animation second) {
                                                      return Stack(
                                                        children: [
                                                          Center(
                                                            child: Image.asset(
                                                              'assets/images/leavesIcon.png',
                                                              // fit: BoxFit.cover,
                                                              height: height * .3,
                                                              // width: width * .4,
                                                            ),
                                                          ),
                                                          Positioned(
                                                            right: 20,
                                                            top: 100,
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                Get.back();
                                                              },
                                                              child: Container(
                                                                  padding: const EdgeInsets.all(10),
                                                                  height: 50,
                                                                  decoration: const BoxDecoration(
                                                                      color: Colors.white, shape: BoxShape.circle),
                                                                  child: const Icon(Icons.clear)),
                                                            ),
                                                          )
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: Image.asset(
                                                'assets/images/leavesIcon.png',
                                                // fit: BoxFit.cover,
                                                height: 65,
                                                width: 65,
                                              ),
                                            )
                                        ],
                                      ))
                                  : const SizedBox(),

                              Positioned(
                                  right: 20,
                                  top: 150 - 20,
                                  //   bottom: 0,
                                  child: SizedBox(
                                    width: 100,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                            height: 55,
                                            decoration:
                                                const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(50),
                                                  child: CachedNetworkImage(
                                                    imageUrl: homeController.isDataLoading.value
                                                        ? homeController.model.value.data!.stores![index].profileImage
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
                                          (homeController.model.value.data!.stores![index].cookName!.isEmpty
                                                  ? 'Test'
                                                  : homeController.model.value.data!.stores![index].cookName)
                                              .toString()
                                              .capitalizeFirst
                                              .toString(),
                                          maxLines: 1,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11,
                                              color: const Color(0xFF21283D)),
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Color(0xFFFFC529),
                                              size: 14,
                                            ),
                                            addWidth(3),
                                            Text(
                                              homeController.model.value.data!.stores![index].rating.toString(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 11,
                                                  color: const Color(0xFF6A7080)),
                                            ),
                                            Text(
                                              '(${(homeController.model.value.data!.stores![index].countReviewData).toString()})',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 11,
                                                  color: const Color(0xFF6A7080)),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                              Positioned(
                                  top: 16,
                                  right: 10,
                                  child: InkWell(
                                      onTap: () {
                                        if(isUserlogin){
                                          wishlistRepo(
                                              id: homeController.model.value.data!.stores![index].id.toString(),
                                              productId: '')
                                              .then((value) {
                                            if (value.status == true) {
                                              showToast(value.message);
                                              // homeController.getData(filter: (currentIndex + 2).toString());
                                              if (isUserlogin == true) {
                                                homeController.getData(
                                                    filter: (currentIndex + 2).toString(),
                                                    latitude: profileController.model.value.data!.latitude,
                                                    longitude: profileController.model.value.data!.longitude);
                                              } else {
                                                homeController.getData(
                                                    filter: (currentIndex + 2).toString(),
                                                    latitude: locationController.lat.value,
                                                    longitude: locationController.long.value);
                                              }
                                            }
                                          });
                                        }else{
                                          Get.to(const LoginScreen());
                                        }

                                      },
                                      child: homeController.model.value.data!.stores![index].wishlist!
                                          ? Container(
                                              height: 33,
                                              decoration:
                                                  const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                              child: const Padding(
                                                  padding: EdgeInsets.only(left: 10, right: 10, top: 3),
                                                  child: Icon(
                                                    Icons.favorite,
                                                    color: Color(0xFF7ED957),
                                                  )))
                                          : Container(
                                              height: 33,
                                              decoration:
                                                  const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                              child: const Padding(
                                                  padding: EdgeInsets.only(left: 10, right: 10, top: 3),
                                                  child: Icon(
                                                    Icons.favorite_outline,
                                                    color: Color(0xFF7ED957),
                                                  ))))),
                              // homeController.model.value.data!.stores![index].award!.isNotEmpty ?
                              // Positioned(
                              //     top: 14,
                              //     // bottom: 0,
                              //     left: 10,
                              //     right: 15,
                              //     //   bottom: 0,
                              //     child: Row(
                              //       children:  [
                              //         ...List.generate(homeController.model.value.data!.stores![index].award!.length, (index1){
                              //           return  InkWell(
                              //             onTap: (){
                              //               showGeneralDialog(
                              //                   context: context,
                              //                   barrierDismissible: true,
                              //                   barrierColor: const Color(0xFF000000).withOpacity(0.58),
                              //                   barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                              //                   pageBuilder: (BuildContext context,Animation first, Animation second){
                              //                     return  Stack(
                              //                       children: [
                              //                         Center(child: CachedNetworkImage(
                              //                           imageUrl:     homeController.model.value.data!.stores![index].award![index1].image.toString(),
                              //                           //fit: BoxFit.cover,
                              //                           height: height * .7,
                              //                           width: width * .7,
                              //                           errorWidget: (_, __, ___) => Image.asset(
                              //                             'assets/images/topChef.png',
                              //                             // fit: BoxFit.cover,
                              //                             height: 40,
                              //                             width: 40,
                              //                           ),
                              //                           placeholder: (_, __) =>
                              //                           const Center(child: CircularProgressIndicator()),
                              //                         )),
                              //                         Positioned(
                              //                           right: 22,
                              //                           top: 100,
                              //                           child: GestureDetector(
                              //                             onTap:(){
                              //                               Get.back();
                              //                             },
                              //                             child: Container(
                              //                                 padding: const EdgeInsets.all(10),
                              //                                 height: 50,
                              //                                 decoration: const BoxDecoration(
                              //                                     color: Colors.white,
                              //                                     shape: BoxShape.circle
                              //                                 ),
                              //                                 child:  const Icon(Icons.clear)
                              //                             ),
                              //                           ),)
                              //                       ],
                              //                     );
                              //                   }
                              //               );
                              //             },
                              //             child:    CachedNetworkImage(
                              //               imageUrl:     homeController.model.value.data!.stores![index].award![index1].image.toString(),
                              //               //fit: BoxFit.cover,
                              //               height: 40,
                              //               width: 40,
                              //               errorWidget: (_, __, ___) => Image.asset(
                              //                 'assets/images/topChef.png',
                              //                 // fit: BoxFit.cover,
                              //                 height: 40,
                              //                 width: 40,
                              //               ),
                              //               placeholder: (_, __) =>
                              //               const Center(child: CircularProgressIndicator()),
                              //             ),);
                              //         })
                              //         // InkWell(
                              //         //     onTap: (){
                              //         //       showGeneralDialog(
                              //         //           context: context,
                              //         //           barrierDismissible: true,
                              //         //           barrierColor: const Color(0xFF000000).withOpacity(0.58),
                              //         //           barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                              //         //           pageBuilder: (BuildContext context,Animation first, Animation second){
                              //         //             return  Stack(
                              //         //               children: [
                              //         //                 Center(child: CachedNetworkImage(
                              //         //                   imageUrl:     homeController.model.value.data!.stores![index].award![index].image.toString(),
                              //         //                   //fit: BoxFit.cover,
                              //         //                   height: height * .7,
                              //         //                   width: width * .7,
                              //         //                   errorWidget: (_, __, ___) => Image.asset(
                              //         //                     'assets/images/topChef.png',
                              //         //                     // fit: BoxFit.cover,
                              //         //                     height: height * .3,
                              //         //                     width: width * .4,
                              //         //                   ),
                              //         //                   placeholder: (_, __) =>
                              //         //                   const Center(child: CircularProgressIndicator()),
                              //         //                 )),
                              //         //                 Positioned(
                              //         //                   right: 20,
                              //         //                   top: 100,
                              //         //                   child: GestureDetector(
                              //         //                     onTap: (){
                              //         //                       Get.back();
                              //         //                     },
                              //         //                     child: Container(
                              //         //                         padding: const EdgeInsets.all(10),
                              //         //                         height: 80,
                              //         //                         decoration: const BoxDecoration(
                              //         //                             color: Colors.white,
                              //         //                             shape: BoxShape.circle
                              //         //                         ),
                              //         //                         child:  const Icon(Icons.clear)
                              //         //                     ),
                              //         //                   ),)
                              //         //               ],
                              //         //             );
                              //         //           }
                              //         //       );
                              //         //     },
                              //         //     child:    CachedNetworkImage(
                              //         //       imageUrl:     homeController.model.value.data!.stores![index].award![0].image.toString(),
                              //         //       //fit: BoxFit.cover,
                              //         //       height: 40,
                              //         //       width: 40,
                              //         //       errorWidget: (_, __, ___) => Image.asset(
                              //         //         'assets/images/topChef.png',
                              //         //         // fit: BoxFit.cover,
                              //         //         height: 40,
                              //         //         width: 40,
                              //         //       ),
                              //         //       placeholder: (_, __) =>
                              //         //       const Center(child: CircularProgressIndicator()),
                              //         //     ),
                              //         // ),
                              //
                              //
                              //       ],
                              //     )
                              // ) : const SizedBox(),
                              //
                              // homeController.model.value.data!.stores![index].sustainablePackagingStatus!  ?
                              // Positioned(
                              //   top: 14,
                              //   // bottom: 0,
                              //   left:   homeController.model.value.data!.stores![index].award!.isNotEmpty  ? 100 : 15,
                              //   //right: 15,
                              //   child: InkWell(
                              //     onTap: (){
                              //       showGeneralDialog(
                              //           context: context,
                              //           barrierDismissible: true,
                              //           barrierColor: const Color(0xFF000000).withOpacity(0.58),
                              //           barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                              //           pageBuilder: (BuildContext context,Animation first, Animation second){
                              //             return  Stack(
                              //               children: [
                              //                 Center(
                              //                   child: Image.asset(
                              //                   'assets/images/leavesIcon.png',
                              //                   // fit: BoxFit.cover,
                              //                   height: height * .3,
                              //                   // width: width * .4,
                              //                 ),),
                              //                 Positioned(
                              //                   right: 20,
                              //                   top: 100,
                              //                   child: GestureDetector(
                              //                     onTap: (){
                              //                       Get.back();
                              //                     },
                              //                     child: Container(
                              //                         padding: const EdgeInsets.all(10),
                              //                         height: 50,
                              //                         decoration: const BoxDecoration(
                              //                             color: Colors.white,
                              //                             shape: BoxShape.circle
                              //                         ),
                              //                         child:  const Icon(Icons.clear)
                              //                     ),
                              //                   ),)
                              //               ],
                              //             );
                              //           }
                              //       );
                              //     },
                              //     child: Image.asset(
                              //     'assets/images/leavesIcon.png',
                              //     // fit: BoxFit.cover,
                              //     height: 35,
                              //     width: 35,
                              //      ),
                              //   ),
                              // ) : const SizedBox()
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
              )
            : const Padding(
                padding: EdgeInsets.only(top: 80),
                child: Center(
                    child: Text(
                  'No Cooks available',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black),
                )),
              )
      ],
    );
  }

  Text buildTextFilter(int index) {
    final item = filterProductCategoryController.filterDataModel.value.data![index];
    return Text(
      '${item.collection.toString()} '
      '${item.collection != 'Collection Only' ? "(${item.time ?? ''.toString()} - ${item.time1 ?? ''.toString()} min)\nDistance: ${"${item.distance.toString()} km"}" : ""}',
      style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 12, color: const Color(0xFF606573)),
    );
  }

  Text buildText(int index) {
    final item = homeController.model.value.data!.stores![index];
    return Text(
      '${item.collection.toString()} '
      '${item.collection != 'Collection Only' ? "(${item.time ?? ''.toString()} - ${item.time1 ?? ''.toString()} min)\nDistance: ${"${item.distance.toString()} km"}" : ""}',
      style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 12, color: const Color(0xFF606573)),
    );
  }

  showUploadWindow() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var height = MediaQuery.of(context).size.height;
        return Stack(
          children: [
            Positioned(
              right: 35,
              top: 60,
              child: Container(
                  padding: const EdgeInsets.all(10),
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
              child: StatefulBuilder(builder: (context, newState) {
                return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AddSize.padding16,
                    ),
                    child: SizedBox(
                      height: height * .6,
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Cuisine:",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 19,
                                          color: const Color(0xFF425159),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      categoryController.categoryModel.value.data != null
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: categoryController.categoryModel.value.data!.category!.length,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                final category =
                                                    categoryController.categoryModel.value.data!.category![index];
                                                return InkWell(
                                                  onTap: () {
                                                    if (categoryController.categoryModel.value.data!.selectedIds.value
                                                        .contains(category.id.toString())) {
                                                      categoryController.categoryModel.value.data!.selectedIds.value
                                                          .remove(category.id.toString());
                                                    } else {
                                                      categoryController.categoryModel.value.data!.selectedIds.value
                                                          .add(category.id.toString());
                                                    }
                                                    newState(() {});
                                                    // if (categoryController.categoryModel.value.data!.selectedID.value !=
                                                    //     category.id.toString()) {
                                                    //   categoryController.categoryModel.value.data!.selectedID.value = category.id.toString();
                                                    // } else {
                                                    //   categoryController.categoryModel.value.data!.selectedID.value = "";
                                                    // }
                                                  },
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              category.name.toString(),
                                                              style: GoogleFonts.poppins(
                                                                fontWeight: FontWeight.w300,
                                                                fontSize: 18,
                                                                color: const Color(0xFF425159),
                                                              ),
                                                            ),
                                                          ),
                                                          Obx(() {
                                                            return Checkbox(
                                                                side: const BorderSide(color: Colors.black, width: 2),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(0)),
                                                                value: categoryController
                                                                    .categoryModel.value.data!.selectedIds.value
                                                                    .contains(category.id.toString()),
                                                                onChanged: (value) {
                                                                  if (categoryController
                                                                      .categoryModel.value.data!.selectedIds.value
                                                                      .contains(category.id.toString())) {
                                                                    categoryController
                                                                        .categoryModel.value.data!.selectedIds.value
                                                                        .remove(category.id.toString());
                                                                  } else {
                                                                    categoryController
                                                                        .categoryModel.value.data!.selectedIds.value
                                                                        .add(category.id.toString());
                                                                  }
                                                                  newState(() {});
                                                                });
                                                          })
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              })
                                          : const Padding(
                                              padding: EdgeInsets.only(top: 80),
                                              child: Center(
                                                  child: Text(
                                                'No Cooks available',
                                                style: TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black),
                                              )),
                                            ),
                                      categoryController.categoryModel.value.data != null
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: categoryController
                                                  .categoryModel.value.data!.secondaryCategory!.length,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                final item = categoryController
                                                    .categoryModel.value.data!.secondaryCategory![index];
                                                return InkWell(
                                                  onTap: () {
                                                    if (categoryController.categoryModel.value.data!.selectedIds.value
                                                        .contains(item.id.toString())) {
                                                      categoryController.categoryModel.value.data!.selectedIds.value
                                                          .remove(item.id.toString());
                                                    } else {
                                                      categoryController.categoryModel.value.data!.selectedIds.value
                                                          .add(item.id.toString());
                                                    }
                                                    newState(() {});
                                                    // if (categoryController.categoryModel.value.data!.selectedID.value !=
                                                    //     item.id.toString()) {
                                                    //   categoryController.categoryModel.value.data!.selectedID.value = item.id.toString();
                                                    // } else {
                                                    //   categoryController.categoryModel.value.data!.selectedID.value = "";
                                                    // }
                                                  },
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              item.name.toString(),
                                                              style: GoogleFonts.poppins(
                                                                fontWeight: FontWeight.w300,
                                                                fontSize: 18,
                                                                color: const Color(0xFF425159),
                                                              ),
                                                            ),
                                                          ),
                                                          Obx(() {
                                                            return Checkbox(
                                                                side: const BorderSide(color: Colors.black, width: 2),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(0)),
                                                                value: categoryController
                                                                    .categoryModel.value.data!.selectedIds.value
                                                                    .contains(item.id.toString()),
                                                                onChanged: (value) {
                                                                  if (categoryController
                                                                      .categoryModel.value.data!.selectedIds.value
                                                                      .contains(item.id.toString())) {
                                                                    categoryController
                                                                        .categoryModel.value.data!.selectedIds.value
                                                                        .remove(item.id.toString());
                                                                  } else {
                                                                    categoryController
                                                                        .categoryModel.value.data!.selectedIds.value
                                                                        .add(item.id.toString());
                                                                  }
                                                                  newState(() {});
                                                                });
                                                          })
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              })
                                          : const Padding(
                                              padding: EdgeInsets.only(top: 80),
                                              child: Center(
                                                  child: Text(
                                                'No Cooks available',
                                                style: TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black),
                                              )),
                                            ),
                                      categoryController.categoryModel.value.data != null
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  categoryController.categoryModel.value.data!.tertiaryCategory!.length,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                final item = categoryController
                                                    .categoryModel.value.data!.tertiaryCategory![index];
                                                return InkWell(
                                                  onTap: () {
                                                    if (categoryController.categoryModel.value.data!.selectedIds.value
                                                        .contains(item.id.toString())) {
                                                      categoryController.categoryModel.value.data!.selectedIds.value
                                                          .remove(item.id.toString());
                                                    } else {
                                                      categoryController.categoryModel.value.data!.selectedIds.value
                                                          .add(item.id.toString());
                                                    }
                                                    newState(() {});
                                                    // if (categoryController.categoryModel.value.data!.selectedID.value != item.id.toString()) {
                                                    //   categoryController.categoryModel.value.data!.selectedID.value = item.id.toString();
                                                    // } else {
                                                    //   categoryController.categoryModel.value.data!.selectedID.value = "";
                                                    // }
                                                  },
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              item.name.toString(),
                                                              style: GoogleFonts.poppins(
                                                                fontWeight: FontWeight.w300,
                                                                fontSize: 18,
                                                                color: const Color(0xFF425159),
                                                              ),
                                                            ),
                                                          ),
                                                          Obx(() {
                                                            return Checkbox(
                                                                side: const BorderSide(color: Colors.black, width: 2),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(0)),
                                                                value: categoryController
                                                                    .categoryModel.value.data!.selectedIds.value
                                                                    .contains(item.id.toString()),
                                                                onChanged: (value) {
                                                                  if (categoryController
                                                                      .categoryModel.value.data!.selectedIds.value
                                                                      .contains(item.id.toString())) {
                                                                    categoryController
                                                                        .categoryModel.value.data!.selectedIds.value
                                                                        .remove(item.id.toString());
                                                                  } else {
                                                                    categoryController
                                                                        .categoryModel.value.data!.selectedIds.value
                                                                        .add(item.id.toString());
                                                                  }
                                                                  newState(() {});
                                                                });
                                                          })
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              })
                                          : const Padding(
                                              padding: EdgeInsets.only(top: 80),
                                              child: Center(
                                                  child: Text(
                                                'No Cooks available',
                                                style: TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black),
                                              )),
                                            ),

                                      Text(
                                        "Dietary:",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 19,
                                          color: const Color(0xFF425159),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      categoryController.dietiaryModel.value.data != null
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: categoryController.dietiaryModel.value.data!.dietary!.length,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                final item =
                                                    categoryController.dietiaryModel.value.data!.dietary![index];
                                                return InkWell(
                                                  onTap: () {
                                                    if (categoryController.dietiaryModel.value.data!.selectedIds
                                                        .contains(item.id.toString())) {
                                                      categoryController.dietiaryModel.value.data!.selectedIds
                                                          .remove(item.id.toString());
                                                    } else {
                                                      categoryController.dietiaryModel.value.data!.selectedIds
                                                          .add(item.id.toString());
                                                    }
                                                    newState(() {});

                                                    //  homeController.chooseDietaries.value = categoryController.dietiaryModel.value.data!.dietary![index].id.toString();
                                                    //  // homeController.categoryType.value = categoryController.dietiaryModel.value.data!.dietary![index].categoryType.toString();
                                                    //  print("Filter  Dietiary category id is ${homeController.filterCategoryId.value}");
                                                    // // print("Filter category type is ${homeController.categoryType.value }");
                                                    //  homeController.getData();
                                                    //  setState(() {});
                                                  },
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              item.title.toString(),
                                                              style: GoogleFonts.poppins(
                                                                fontWeight: FontWeight.w300,
                                                                fontSize: 18,
                                                                color: const Color(0xFF425159),
                                                              ),
                                                            ),
                                                          ),
                                                          Obx(() {
                                                            return Checkbox(
                                                                side: const BorderSide(color: Colors.black, width: 2),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(0)),
                                                                value: categoryController
                                                                    .dietiaryModel.value.data!.selectedIds
                                                                    .contains(item.id.toString()),
                                                                onChanged: (value) {
                                                                  if (categoryController
                                                                      .dietiaryModel.value.data!.selectedIds
                                                                      .contains(item.id.toString())) {
                                                                    categoryController
                                                                        .dietiaryModel.value.data!.selectedIds
                                                                        .remove(item.id.toString());
                                                                  } else {
                                                                    categoryController
                                                                        .dietiaryModel.value.data!.selectedIds
                                                                        .add(item.id.toString());
                                                                  }
                                                                  newState(() {});
                                                                });
                                                          })
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              })
                                          : const Padding(
                                              padding: EdgeInsets.only(top: 80),
                                              child: Center(
                                                  child: Text(
                                                'No Cooks available',
                                                style: TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black),
                                              )),
                                            ),

                                      // SizedBox(height: 15,),
                                    ]),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                // width: 160,
                                height: 40,
                                child: ElevatedButton(
                                  child: const Text(
                                    "Clear All",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                  ),
                                  onPressed: () {
                                    categoryController.dietiaryModel.value.data!.selectedIds.clear();
                                    categoryController.categoryModel.value.data!.selectedIds.clear();
                                    newState(() {});
                                    setState(() {});
                                  },
                                ),
                              ),
                              SizedBox(
                                // width: 160,
                                height: 40,
                                child: ElevatedButton(
                                  child: const Text(
                                    "Submit",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                  ),
                                  onPressed: () {
                                    sortedFilter = false;
                                    // String filterCategory = "";
                                    // String categoryType = "";
                                    // for (var element in categoryController.categoryModel.value.data!.allCategory) {
                                    //   if (categoryController.categoryModel.value.data!.selectedID.value == element.id.toString()) {
                                    //     filterCategory = element.id.toString();
                                    //     categoryType = element.categoryType.toString();
                                    //     break;
                                    //   }
                                    // }
                                    homeController
                                        .getData(
                                            // filterCategory: categoryController
                                            //     .categoryModel.value.data!.selectedIds.value
                                            //     .toList()
                                            //     .join(","),
                                            // // categoryType: ,
                                            // chooseDietaries: categoryController.dietiaryModel.value.data!.selectedIds
                                            //     .toList()
                                            //     .join(","),
                                            context: context,
                                            filter: (currentIndex + 2).toString())
                                        .then((value) {
                                      //if() {
                                      // Get.toNamed(HomeFilterScreen.homeFilterScreen);
                                      //Get.back();
                                      //}
                                    });
                                    Get.back();

                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ));
              }),
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
                    padding: const EdgeInsets.all(10),
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
                    child:
                        Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sort By:",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.black87,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  sortedFilter = false;
                                  Get.back();
                                });
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
                                child: const Icon(
                                  Icons.replay_sharp,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: items.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  sortedFilter = true;
                                });
                                filterProductCategoryController.getFilterCategoryData(
                                    filter: items[index].id,
                                    categoryId: (currentIndex + 2).toString(),
                                    context: context,
                                    latitude: profileController.model.value.data!.latitude,
                                    longitude: profileController.model.value.data!.longitude
                                );
                                filterProductCategoryController.getFilterCategoryData(
                                    filter: items[index].id,
                                    categoryId: (currentIndex + 2).toString(),
                                    context: context,
                                    latitude: locationController.lat.value,
                                    longitude: locationController.long.value
                                );
                                Get.back();
                                // Get.off(()=> FilterProductScreen(filterId: items[index].id,));
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
                      const SizedBox(
                        height: 7,
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          );
        });
  }
}

class ItemDropDown {
  final String id;
  final String name;

  const ItemDropDown(this.id, this.name);
}
