import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart' hide Badge;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/dimenestion.dart';
import 'package:intl/intl.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../controller/category_controller.dart';
import '../controller/featured_filter_controller.dart';
import '../controller/filter_controller.dart';
import '../controller/vendor_single_store_controller.dart';
import '../repository/wishlist_repo.dart';
import '../resources/add_text.dart';
import '../widgets/app_theme.dart';
import '../widgets/custome_textfiled.dart';

class StoreListScreen extends StatefulWidget {
  final Function(bool gg) performAction;
  const StoreListScreen({Key? key, required this.performAction}) : super(key: key);
  static var storeListScreen = "/storeListScreen";

  @override
  State<StoreListScreen> createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> with TickerProviderStateMixin {
  final featuredFilterController = Get.put(FeaturedFilterController());
  final categoryController = Get.put(CategoryController());
  final controller = Get.put(VendorSingleStoreController());
  final filterDataController = Get.put(FilterController());
  // bool? dateOptionPicked=false;

  final scrollController = ScrollController();
  RxBool isSelect = false.obs;
  RxBool selectIcon = false.obs;
  int currentDrawer = 0;
  RxInt count = 0.obs;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String?  selectedDate = "";
  // DateFormat('yyyy/MM/dd').format(DateTime.now());
  late TabController tabController;
  final autoController = AutoScrollController();
  bool isClicked = false;
  bool isClicked1 = false;
  bool? isAvailableSelected = false;
  DateTime? pickedDate;
  String? chooseUnit;
  final List<String> choosedOption = ["Stock", "Out of Stock", "Select Date"];

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      featuredFilterController.getData();
      controller.getStoreKeywordListData();
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: backAppBar(
            title: 'Featured Today',
            context: context,
            performAction: (bool sd) {
              widget.performAction(sd);
            }),
        body:
            // featuredFilterController.isDataLoading.value ?
            NestedScrollView(headerSliverBuilder: (_, __) {
          return [
            Obx(() {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding10),
                  child: featuredFilterController.isDataLoading.value
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 9.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
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
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now().subtract(const Duration(days: 0)),
                                          // firstDate: DateTime(1950),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2025),
                                        ).then((value) {
                                          if (value != null) {
                                            // featuredFilterController.sendDate.value = value;
                                            String formattedDate = DateFormat('yyyy/MM/dd').format(value);
                                            setState(() {
                                              // var selectedDate=formattedDate;
                                              selectedDate = formattedDate; //set output date to TextField value.
                                              log("Seleted Date     $selectedDate");
                                              featuredFilterController.sendDate.value = selectedDate!;
                                              featuredFilterController.getData();
                                            });
                                          }
                                        });

                                        if (pickedDate != null) {
                                          // showChooseDate(context);
                                          String formattedDate = DateFormat('yyyy/MM/dd').format(pickedDate!);
                                          setState(() {
                                            selectedDate = formattedDate;
                                            log("Seleted Date     $selectedDate");
                                            featuredFilterController.sendDate.value = selectedDate!;
                                            featuredFilterController.getData();
                                          });
                                        }
                                      },
                                      child: Container(
                                          height: 44,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color:  selectedDate == "" ?  Color(0xFF7ED957): Colors.white70,
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              selectedDate == "" ?
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  'assets/images/truckimg.png',
                                                  height: 18,
                                                ),
                                              ):Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  'assets/images/calendar_date.png',
                                                  height: 18,
                                                  color: const Color(0xFF262626).withOpacity(0.62),
                                                ),
                                              ),
                                              selectedDate == "" ?
                                              Text(
                                                'Pick a Date',
                                                style: GoogleFonts.poppins(
                                                  color: const Color(0xFFFFFFFF),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ) : Text(
                                                selectedDate!,
                                                style: GoogleFonts.poppins(
                                                  color: const Color(0xFF262626).withOpacity(0.62),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            ],
                                          )),
                                    ),
                                  ),

                                  addWidth(10),
                                  GestureDetector(
                                    onTap: () {
                                      print("hello");
                                      _showSimpleDialog1();
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
                                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                        child: Image.asset(
                                          'assets/images/filterImg.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                  addWidth(10),
                                  GestureDetector(
                                    onTap: () {
                                      featuredFilterController.sendDate.value = "";
                                      featuredFilterController.status.value = "";
                                      featuredFilterController.filterId.value = "";
                                      featuredFilterController.getData();
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
                                      child: const Icon(Icons.replay_sharp,color: Colors.white,size: 30,),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            addHeight(10),
                            Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AddSize.screenWidth * 0.02, vertical: AddSize.screenHeight * .007),
                                  child: TabBar(
                                    // indicatorColor: Color(0xff7ED957),
                                    physics: const BouncingScrollPhysics(),
                                    tabs: [
                                      Tab(
                                        child: Text(
                                          "A' La Carte",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Tab(
                                        child: Text(
                                          "Catering",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Tab(
                                        child: Text(
                                          "Meal Prep",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    ],
                                    onTap: (value) {
                                      print(value);
                                      if (value == 0) {
                                        featuredFilterController.filterId.value = "2";
                                        featuredFilterController.sendDate.value = selectedDate!;
                                        featuredFilterController.getData();
                                      }
                                      if (value == 1) {
                                        featuredFilterController.filterId.value = "3";
                                        featuredFilterController.sendDate.value = selectedDate!;
                                        featuredFilterController.getData();
                                      }
                                      if (value == 2) {
                                        featuredFilterController.filterId.value = "4";
                                        featuredFilterController.sendDate.value = selectedDate!;
                                        featuredFilterController.getData();
                                      }

                                      //
                                      // autoController.scrollToIndex(value, preferPosition: AutoScrollPosition.begin);
                                    },
                                    unselectedLabelColor: const Color(0xFF262626),
                                    labelColor: Colors.white,

                                    labelStyle:
                                        const TextStyle(color: Color(0xFF1A2E33), fontSize: 16, fontWeight: FontWeight.w500),
                                    unselectedLabelStyle:
                                        const TextStyle(color: Color(0xFF909090), fontSize: 16, fontWeight: FontWeight.w500),
                                    controller: tabController,
                                    indicatorPadding: const EdgeInsets.symmetric(horizontal: -5, vertical: -2),
                                    indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: const Color(0xff7ED957),
                                    ),
                                  ),
                                )),
                          ],
                        )
                      : const SizedBox(),
                ),
              );
            })
          ];
        }, body: Obx(() {
          return featuredFilterController.isDataLoading.value
              ? featuredFilterController.model.value.data!.isNotEmpty
                  ? TabBarView(
                      physics: const BouncingScrollPhysics(),
                      controller: tabController,
                      children: [
                        Obx(() {
                          return SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AddSize.padding16,
                                  ),
                                  child: featuredFilterController.isDataLoading.value
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: featuredFilterController.model.value.data!.length,
                                          physics: const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return SingleChildScrollView(
                                              child: Column(
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
                                                            child: InkWell(
                                                              onTap: () {
                                                                Get.toNamed(MyRouters.homeDetailsScreen, arguments: [
                                                                  featuredFilterController.model.value.data![index].id
                                                                      .toString()
                                                                ]);
                                                              },
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius: BorderRadius.circular(10),
                                                                    child: CachedNetworkImage(
                                                                      imageUrl: featuredFilterController
                                                                          .model.value.data![index].image
                                                                          .toString(),
                                                                      fit: BoxFit.cover,
                                                                      height: 150,
                                                                      width: AddSize.screenWidth,
                                                                      errorWidget: (_, __, ___) => Image.asset(
                                                                        'assets/images/dummyPerson.png',
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
                                                                    featuredFilterController.model.value.data![index].name
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
                                                          // Positioned(
                                                          //     top: 80,
                                                          //     // bottom: 0,
                                                          //     left: 20,
                                                          //     right: 20,
                                                          //     //   bottom: 0,
                                                          //     child: Row(
                                                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          //       children: [
                                                          //         Icon(
                                                          //           Icons.arrow_back_ios,
                                                          //           color: Colors.white,
                                                          //           size: 20,
                                                          //         ),
                                                          //         Icon(
                                                          //           Icons.arrow_forward_ios,
                                                          //           color: Colors.white,
                                                          //           size: 20,
                                                          //         )
                                                          //       ],
                                                          //     )),
                                                          Positioned(
                                                              bottom: 10,
                                                              right: 20,
                                                              //   bottom: 0,
                                                              child: Column(
                                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Container(
                                                                      height: 55,
                                                                      decoration: const BoxDecoration(
                                                                          shape: BoxShape.circle, color: Colors.white),
                                                                      child: Padding(
                                                                          padding: const EdgeInsets.all(3),
                                                                          child: SizedBox(
                                                                            height: 50,
                                                                            width: 50,
                                                                            child: ClipRRect(
                                                                              borderRadius: BorderRadius.circular(50),
                                                                              child: CachedNetworkImage(
                                                                                imageUrl: featuredFilterController
                                                                                        .isDataLoading.value
                                                                                    ? featuredFilterController.model.value
                                                                                        .data![index].profileImage
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
                                                                                placeholder: (_, __) => const Center(
                                                                                    child: CircularProgressIndicator()),
                                                                              ),
                                                                            ),
                                                                          )
                                                                          // Image.asset(
                                                                          //     'assets/images/avtarImg.png'),
                                                                          )),
                                                                  addHeight(3),
                                                                  Text(
                                                                    featuredFilterController
                                                                        .model.value.data![index].cookName
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
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      const Icon(
                                                                        Icons.star,
                                                                        color: Color(0xFFFFC529),
                                                                        size: 14,
                                                                      ),
                                                                      addWidth(3),
                                                                      Text(
                                                                        (featuredFilterController
                                                                                    .model.value.data![index].rating ??
                                                                                '3')
                                                                            .toString(),
                                                                        style: GoogleFonts.poppins(
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 11,
                                                                            color: const Color(0xFF6A7080)),
                                                                      ),
                                                                      addWidth(3),
                                                                      Text(
                                                                        '(${featuredFilterController.model.value.data![index].countReviewData ?? '10'})'
                                                                            .toString(),
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
                                                                        "store  id..${featuredFilterController.model.value.data![index].id.toString()}");

                                                                    wishlistRepo(
                                                                            id: featuredFilterController
                                                                                .model.value.data![index].id
                                                                                .toString(),
                                                                            productId: '')
                                                                        .then((value) {
                                                                      if (value.status == true) {
                                                                        showToast(value.message);
                                                                        featuredFilterController.getData();
                                                                      }
                                                                    });
                                                                  },
                                                                  child: featuredFilterController
                                                                          .model.value.data![index].wishlist!
                                                                      ? Container(
                                                                          height: 33,
                                                                          decoration: const BoxDecoration(
                                                                              shape: BoxShape.circle, color: Colors.white),
                                                                          child: const Padding(
                                                                              padding: EdgeInsets.only(
                                                                                  left: 10, right: 10, top: 3),
                                                                              child: Icon(
                                                                                Icons.favorite,
                                                                                color: Color(0xFF7ED957),
                                                                              )))
                                                                      : Container(
                                                                          height: 33,
                                                                          decoration: const BoxDecoration(
                                                                              shape: BoxShape.circle, color: Colors.white),
                                                                          child: const Padding(
                                                                              padding: EdgeInsets.only(
                                                                                  left: 10, right: 10, top: 3),
                                                                              child: Icon(
                                                                                Icons.favorite_outline,
                                                                                color: Color(0xFF7ED957),
                                                                              ))))),
                                                          featuredFilterController.model.value.data![index].award!.isNotEmpty || featuredFilterController.model.value.data![index].sustainablePackagingStatus == true?
                                                          Positioned(
                                                              top: 14,
                                                              // bottom: 0,
                                                              left: 10,
                                                              right: 15,
                                                              //   bottom: 0,
                                                              child: Row(
                                                                children: [
                                                                  Row(
                                                                    children:  [
                                                                      ...List.generate(featuredFilterController.model.value.data![index].award!.length, (index1){
                                                                        return  InkWell(
                                                                          onTap: (){
                                                                            showGeneralDialog(
                                                                                context: context,
                                                                                barrierDismissible: true,
                                                                                barrierColor: const Color(0xFF000000).withOpacity(0.58),
                                                                                barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                                                                pageBuilder: (BuildContext context,Animation first, Animation second){
                                                                                  return  Stack(
                                                                                    children: [
                                                                                      Center(child: CachedNetworkImage(
                                                                                        imageUrl:     featuredFilterController.model.value.data![index].award![index1].image.toString(),
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
                                                                                          onTap:(){
                                                                                            Get.back();
                                                                                          },
                                                                                          child: Container(
                                                                                              padding: const EdgeInsets.all(10),
                                                                                              height: 50,
                                                                                              decoration: const BoxDecoration(
                                                                                                  color: Colors.white,
                                                                                                  shape: BoxShape.circle
                                                                                              ),
                                                                                              child:  const Icon(Icons.clear)
                                                                                          ),
                                                                                        ),)
                                                                                    ],
                                                                                  );
                                                                                }
                                                                            );
                                                                          },
                                                                          child:    CachedNetworkImage(
                                                                            imageUrl:     featuredFilterController.model.value.data![index].award![index1].image.toString(),
                                                                            //fit: BoxFit.cover,
                                                                            height: 40,
                                                                            width: 40,
                                                                            errorWidget: (_, __, ___) => Image.asset(
                                                                              'assets/images/topChef.png',
                                                                              // fit: BoxFit.cover,
                                                                              height: 40,
                                                                              width: 40,
                                                                            ),
                                                                            placeholder: (_, __) =>
                                                                            const Center(child: CircularProgressIndicator()),
                                                                          ),);
                                                                      })



                                                                    ],
                                                                  ),
                                                                  if(featuredFilterController.model.value.data![index].sustainablePackagingStatus == true)
                                                                  InkWell(
                                                                    onTap: (){
                                                                      showGeneralDialog(
                                                                          context: context,
                                                                          barrierDismissible: true,
                                                                          barrierColor: const Color(0xFF000000).withOpacity(0.58),
                                                                          barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                                                          pageBuilder: (BuildContext context,Animation first, Animation second){
                                                                            return  Stack(
                                                                              children: [
                                                                                Center(
                                                                                  child: Image.asset(
                                                                                    'assets/images/leavesIcon.png',
                                                                                    // fit: BoxFit.cover,
                                                                                    height: height * .3,
                                                                                    // width: width * .4,
                                                                                  ),),
                                                                                Positioned(
                                                                                  right: 20,
                                                                                  top: 100,
                                                                                  child: GestureDetector(
                                                                                    onTap: (){
                                                                                      Get.back();
                                                                                    },
                                                                                    child: Container(
                                                                                        padding: const EdgeInsets.all(10),
                                                                                        height: 50,
                                                                                        decoration: const BoxDecoration(
                                                                                            color: Colors.white,
                                                                                            shape: BoxShape.circle
                                                                                        ),
                                                                                        child:  const Icon(Icons.clear)
                                                                                    ),
                                                                                  ),)
                                                                              ],
                                                                            );
                                                                          }
                                                                      );
                                                                    },
                                                                    child: Image.asset(
                                                                      'assets/images/leavesIcon.png',
                                                                      // fit: BoxFit.cover,
                                                                      height: 35,
                                                                      width: 35,
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                          ) : const SizedBox(),
                                                          //
                                                          // featuredFilterController.model.value.data![index].sustainablePackagingStatus!  ?
                                                          // Positioned(
                                                          //   top: 14,
                                                          //   // bottom: 0,
                                                          //   left:   featuredFilterController.model.value.data![index].award!.isNotEmpty  ? 100 : 15,
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
                                                          //                     'assets/images/leavesIcon.png',
                                                          //                     // fit: BoxFit.cover,
                                                          //                     height: height * .3,
                                                          //                     // width: width * .4,
                                                          //                   ),),
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
                                                          //       'assets/images/leavesIcon.png',
                                                          //       // fit: BoxFit.cover,
                                                          //       height: 35,
                                                          //       width: 35,
                                                          //     ),
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
                                              ),
                                            );
                                          },
                                        )
                                      : const Padding(
                                          padding: EdgeInsets.only(top: 80),
                                          child: Center(
                                              child: CircularProgressIndicator(
                                            color: Color(0xff7ED957),
                                          )),
                                        )));
                        }),
                        Obx(() {
                          return SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AddSize.padding16,
                                  ),
                                  child: featuredFilterController.isDataLoading.value
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: featuredFilterController.model.value.data!.length,
                                          physics: const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return SingleChildScrollView(
                                              child: Column(
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
                                                            child: InkWell(
                                                              onTap: () {
                                                                Get.toNamed(MyRouters.homeDetailsScreen, arguments: [
                                                                  featuredFilterController.model.value.data![index].id
                                                                      .toString()
                                                                ]);
                                                              },
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius: BorderRadius.circular(10),
                                                                    child: CachedNetworkImage(
                                                                      imageUrl: featuredFilterController
                                                                          .model.value.data![index].image
                                                                          .toString(),
                                                                      fit: BoxFit.cover,
                                                                      height: 150,
                                                                      width: AddSize.screenWidth,
                                                                      errorWidget: (_, __, ___) => Image.asset(
                                                                        'assets/images/dummyPerson.png',
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
                                                                    featuredFilterController.model.value.data![index].name
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
                                                              bottom: 10,
                                                              right: 20,
                                                              //   bottom: 0,
                                                              child: Column(
                                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Container(
                                                                      height: 55,
                                                                      decoration: const BoxDecoration(
                                                                          shape: BoxShape.circle, color: Colors.white),
                                                                      child: Padding(
                                                                          padding: const EdgeInsets.all(3),
                                                                          child: SizedBox(
                                                                            height: 50,
                                                                            width: 50,
                                                                            child: ClipRRect(
                                                                              borderRadius: BorderRadius.circular(50),
                                                                              child: CachedNetworkImage(
                                                                                imageUrl: featuredFilterController
                                                                                        .isDataLoading.value
                                                                                    ? featuredFilterController.model.value
                                                                                        .data![index].profileImage
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
                                                                                placeholder: (_, __) => const Center(
                                                                                    child: CircularProgressIndicator()),
                                                                              ),
                                                                            ),
                                                                          )
                                                                          // Image.asset(
                                                                          //     'assets/images/avtarImg.png'),
                                                                          )),
                                                                  addHeight(3),
                                                                  Text(
                                                                    featuredFilterController
                                                                        .model.value.data![index].cookName
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
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      const Icon(
                                                                        Icons.star,
                                                                        color: Color(0xFFFFC529),
                                                                        size: 14,
                                                                      ),
                                                                      addWidth(3),
                                                                      Text(
                                                                        (featuredFilterController
                                                                                    .model.value.data![index].rating ??
                                                                                '3')
                                                                            .toString(),
                                                                        style: GoogleFonts.poppins(
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 11,
                                                                            color: const Color(0xFF6A7080)),
                                                                      ),
                                                                      addWidth(3),
                                                                      Text(
                                                                        '(${featuredFilterController.model.value.data![index].countReviewData ?? '10'})'
                                                                            .toString(),
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
                                                                        "store  id..${featuredFilterController.model.value.data![index].id.toString()}");

                                                                    wishlistRepo(
                                                                            id: featuredFilterController
                                                                                .model.value.data![index].id
                                                                                .toString(),
                                                                            productId: '')
                                                                        .then((value) {
                                                                      if (value.status == true) {
                                                                        showToast(value.message);
                                                                        featuredFilterController.getData();
                                                                      }
                                                                    });
                                                                  },
                                                                  child: featuredFilterController
                                                                          .model.value.data![index].wishlist!
                                                                      ? Container(
                                                                          height: 33,
                                                                          decoration: const BoxDecoration(
                                                                              shape: BoxShape.circle, color: Colors.white),
                                                                          child: const Padding(
                                                                              padding: EdgeInsets.only(
                                                                                  left: 10, right: 10, top: 3),
                                                                              child: Icon(
                                                                                Icons.favorite,
                                                                                color: Color(0xFF7ED957),
                                                                              )))
                                                                      : Container(
                                                                          height: 33,
                                                                          decoration: const BoxDecoration(
                                                                              shape: BoxShape.circle, color: Colors.white),
                                                                          child: const Padding(
                                                                              padding: EdgeInsets.only(
                                                                                  left: 10, right: 10, top: 3),
                                                                              child: Icon(
                                                                                Icons.favorite_outline,
                                                                                color: Color(0xFF7ED957),
                                                                              ))))),
                                                          featuredFilterController.model.value.data![index].award!.isNotEmpty || featuredFilterController.model.value.data![index].sustainablePackagingStatus == true?
                                                          Positioned(
                                                              top: 14,
                                                              // bottom: 0,
                                                              left: 10,
                                                              right: 15,
                                                              //   bottom: 0,
                                                              child: Row(
                                                                children: [
                                                                  Row(
                                                                    children:  [
                                                                      ...List.generate(featuredFilterController.model.value.data![index].award!.length, (index1){
                                                                        return  InkWell(
                                                                          onTap: (){
                                                                            showGeneralDialog(
                                                                                context: context,
                                                                                barrierDismissible: true,
                                                                                barrierColor: const Color(0xFF000000).withOpacity(0.58),
                                                                                barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                                                                pageBuilder: (BuildContext context,Animation first, Animation second){
                                                                                  return  Stack(
                                                                                    children: [
                                                                                      Center(child: CachedNetworkImage(
                                                                                        imageUrl:     featuredFilterController.model.value.data![index].award![index1].image.toString(),
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
                                                                                          onTap:(){
                                                                                            Get.back();
                                                                                          },
                                                                                          child: Container(
                                                                                              padding: const EdgeInsets.all(10),
                                                                                              height: 50,
                                                                                              decoration: const BoxDecoration(
                                                                                                  color: Colors.white,
                                                                                                  shape: BoxShape.circle
                                                                                              ),
                                                                                              child:  const Icon(Icons.clear)
                                                                                          ),
                                                                                        ),)
                                                                                    ],
                                                                                  );
                                                                                }
                                                                            );
                                                                          },
                                                                          child:    CachedNetworkImage(
                                                                            imageUrl:     featuredFilterController.model.value.data![index].award![index1].image.toString(),
                                                                            //fit: BoxFit.cover,
                                                                            height: 40,
                                                                            width: 40,
                                                                            errorWidget: (_, __, ___) => Image.asset(
                                                                              'assets/images/topChef.png',
                                                                              // fit: BoxFit.cover,
                                                                              height: 40,
                                                                              width: 40,
                                                                            ),
                                                                            placeholder: (_, __) =>
                                                                            const Center(child: CircularProgressIndicator()),
                                                                          ),);
                                                                      })



                                                                    ],
                                                                  ),
                                                                  if(featuredFilterController.model.value.data![index].sustainablePackagingStatus == true)
                                                                    InkWell(
                                                                      onTap: (){
                                                                        showGeneralDialog(
                                                                            context: context,
                                                                            barrierDismissible: true,
                                                                            barrierColor: const Color(0xFF000000).withOpacity(0.58),
                                                                            barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                                                            pageBuilder: (BuildContext context,Animation first, Animation second){
                                                                              return  Stack(
                                                                                children: [
                                                                                  Center(
                                                                                    child: Image.asset(
                                                                                      'assets/images/leavesIcon.png',
                                                                                      // fit: BoxFit.cover,
                                                                                      height: height * .3,
                                                                                      // width: width * .4,
                                                                                    ),),
                                                                                  Positioned(
                                                                                    right: 20,
                                                                                    top: 100,
                                                                                    child: GestureDetector(
                                                                                      onTap: (){
                                                                                        Get.back();
                                                                                      },
                                                                                      child: Container(
                                                                                          padding: const EdgeInsets.all(10),
                                                                                          height: 50,
                                                                                          decoration: const BoxDecoration(
                                                                                              color: Colors.white,
                                                                                              shape: BoxShape.circle
                                                                                          ),
                                                                                          child:  const Icon(Icons.clear)
                                                                                      ),
                                                                                    ),)
                                                                                ],
                                                                              );
                                                                            }
                                                                        );
                                                                      },
                                                                      child: Image.asset(
                                                                        'assets/images/leavesIcon.png',
                                                                        // fit: BoxFit.cover,
                                                                        height: 35,
                                                                        width: 35,
                                                                      ),
                                                                    )
                                                                ],
                                                              )
                                                          ) : const SizedBox(),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                      : const Padding(
                                          padding: EdgeInsets.only(top: 80),
                                          child: Center(
                                              child: CircularProgressIndicator(
                                            color: Color(0xff7ED957),
                                          )),
                                        )));
                        }),
                        Obx(() {
                          return SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AddSize.padding16,
                                  ),
                                  child: featuredFilterController.isDataLoading.value
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: featuredFilterController.model.value.data!.length,
                                          physics: const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return SingleChildScrollView(
                                              child: Column(
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
                                                            child: InkWell(
                                                              onTap: () {
                                                                Get.toNamed(MyRouters.homeDetailsScreen, arguments: [
                                                                  featuredFilterController.model.value.data![index].id
                                                                      .toString()
                                                                ]);
                                                              },
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius: BorderRadius.circular(10),
                                                                    child: CachedNetworkImage(
                                                                      imageUrl: featuredFilterController
                                                                          .model.value.data![index].image
                                                                          .toString(),
                                                                      fit: BoxFit.cover,
                                                                      height: 150,
                                                                      width: AddSize.screenWidth,
                                                                      errorWidget: (_, __, ___) => Image.asset(
                                                                        'assets/images/dummyPerson.png',
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
                                                                    featuredFilterController.model.value.data![index].name
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
                                                              bottom: 10,
                                                              right: 20,
                                                              //   bottom: 0,
                                                              child: Column(
                                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Container(
                                                                      height: 55,
                                                                      decoration: const BoxDecoration(
                                                                          shape: BoxShape.circle, color: Colors.white),
                                                                      child: Padding(
                                                                          padding: const EdgeInsets.all(3),
                                                                          child: SizedBox(
                                                                            height: 50,
                                                                            width: 50,
                                                                            child: ClipRRect(
                                                                              borderRadius: BorderRadius.circular(50),
                                                                              child: CachedNetworkImage(
                                                                                imageUrl: featuredFilterController
                                                                                        .isDataLoading.value
                                                                                    ? featuredFilterController.model.value
                                                                                        .data![index].profileImage
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
                                                                                placeholder: (_, __) => const Center(
                                                                                    child: CircularProgressIndicator()),
                                                                              ),
                                                                            ),
                                                                          )
                                                                          // Image.asset(
                                                                          //     'assets/images/avtarImg.png'),
                                                                          )),
                                                                  addHeight(3),
                                                                  Text(
                                                                    featuredFilterController
                                                                        .model.value.data![index].cookName
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
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      const Icon(
                                                                        Icons.star,
                                                                        color: Color(0xFFFFC529),
                                                                        size: 14,
                                                                      ),
                                                                      addWidth(3),
                                                                      Text(
                                                                        (featuredFilterController
                                                                                    .model.value.data![index].rating ??
                                                                                '3')
                                                                            .toString(),
                                                                        style: GoogleFonts.poppins(
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 11,
                                                                            color: const Color(0xFF6A7080)),
                                                                      ),
                                                                      addWidth(3),
                                                                      Text(
                                                                        '(${featuredFilterController.model.value.data![index].countReviewData ?? '0'})'
                                                                            .toString(),
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
                                                                        "store  id..${featuredFilterController.model.value.data![index].id.toString()}");

                                                                    wishlistRepo(
                                                                            id: featuredFilterController
                                                                                .model.value.data![index].id
                                                                                .toString(),
                                                                            productId: '')
                                                                        .then((value) {
                                                                      if (value.status == true) {
                                                                        showToast(value.message);
                                                                        featuredFilterController.getData();
                                                                      }
                                                                    });
                                                                  },
                                                                  child: featuredFilterController
                                                                          .model.value.data![index].wishlist!
                                                                      ? Container(
                                                                          height: 33,
                                                                          decoration: const BoxDecoration(
                                                                              shape: BoxShape.circle, color: Colors.white),
                                                                          child: const Padding(
                                                                              padding: EdgeInsets.only(
                                                                                  left: 10, right: 10, top: 3),
                                                                              child: Icon(
                                                                                Icons.favorite,
                                                                                color: Color(0xFF7ED957),
                                                                              )))
                                                                      : Container(
                                                                          height: 33,
                                                                          decoration: const BoxDecoration(
                                                                              shape: BoxShape.circle, color: Colors.white),
                                                                          child: const Padding(
                                                                              padding: EdgeInsets.only(
                                                                                  left: 10, right: 10, top: 3),
                                                                              child: Icon(
                                                                                Icons.favorite_outline,
                                                                                color: Color(0xFF7ED957),
                                                                              ))))),
                                                          featuredFilterController.model.value.data![index].award!.isNotEmpty || featuredFilterController.model.value.data![index].sustainablePackagingStatus == true?
                                                          Positioned(
                                                              top: 14,
                                                              // bottom: 0,
                                                              left: 10,
                                                              right: 15,
                                                              //   bottom: 0,
                                                              child: Row(
                                                                children: [
                                                                  Row(
                                                                    children:  [
                                                                      ...List.generate(featuredFilterController.model.value.data![index].award!.length, (index1){
                                                                        return  InkWell(
                                                                          onTap: (){
                                                                            showGeneralDialog(
                                                                                context: context,
                                                                                barrierDismissible: true,
                                                                                barrierColor: const Color(0xFF000000).withOpacity(0.58),
                                                                                barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                                                                pageBuilder: (BuildContext context,Animation first, Animation second){
                                                                                  return  Stack(
                                                                                    children: [
                                                                                      Center(child: CachedNetworkImage(
                                                                                        imageUrl:     featuredFilterController.model.value.data![index].award![index1].image.toString(),
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
                                                                                          onTap:(){
                                                                                            Get.back();
                                                                                          },
                                                                                          child: Container(
                                                                                              padding: const EdgeInsets.all(10),
                                                                                              height: 50,
                                                                                              decoration: const BoxDecoration(
                                                                                                  color: Colors.white,
                                                                                                  shape: BoxShape.circle
                                                                                              ),
                                                                                              child:  const Icon(Icons.clear)
                                                                                          ),
                                                                                        ),)
                                                                                    ],
                                                                                  );
                                                                                }
                                                                            );
                                                                          },
                                                                          child:    CachedNetworkImage(
                                                                            imageUrl:     featuredFilterController.model.value.data![index].award![index1].image.toString(),
                                                                            //fit: BoxFit.cover,
                                                                            height: 40,
                                                                            width: 40,
                                                                            errorWidget: (_, __, ___) => Image.asset(
                                                                              'assets/images/topChef.png',
                                                                              // fit: BoxFit.cover,
                                                                              height: 40,
                                                                              width: 40,
                                                                            ),
                                                                            placeholder: (_, __) =>
                                                                            const Center(child: CircularProgressIndicator()),
                                                                          ),);
                                                                      })



                                                                    ],
                                                                  ),
                                                                  if(featuredFilterController.model.value.data![index].sustainablePackagingStatus == true)
                                                                    InkWell(
                                                                      onTap: (){
                                                                        showGeneralDialog(
                                                                            context: context,
                                                                            barrierDismissible: true,
                                                                            barrierColor: const Color(0xFF000000).withOpacity(0.58),
                                                                            barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                                                            pageBuilder: (BuildContext context,Animation first, Animation second){
                                                                              return  Stack(
                                                                                children: [
                                                                                  Center(
                                                                                    child: Image.asset(
                                                                                      'assets/images/leavesIcon.png',
                                                                                      // fit: BoxFit.cover,
                                                                                      height: height * .3,
                                                                                      // width: width * .4,
                                                                                    ),),
                                                                                  Positioned(
                                                                                    right: 20,
                                                                                    top: 100,
                                                                                    child: GestureDetector(
                                                                                      onTap: (){
                                                                                        Get.back();
                                                                                      },
                                                                                      child: Container(
                                                                                          padding: const EdgeInsets.all(10),
                                                                                          height: 50,
                                                                                          decoration: const BoxDecoration(
                                                                                              color: Colors.white,
                                                                                              shape: BoxShape.circle
                                                                                          ),
                                                                                          child:  const Icon(Icons.clear)
                                                                                      ),
                                                                                    ),)
                                                                                ],
                                                                              );
                                                                            }
                                                                        );
                                                                      },
                                                                      child: Image.asset(
                                                                        'assets/images/leavesIcon.png',
                                                                        // fit: BoxFit.cover,
                                                                        height: 35,
                                                                        width: 35,
                                                                      ),
                                                                    )
                                                                ],
                                                              )
                                                          ) : const SizedBox(),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                      : const Padding(
                                          padding: EdgeInsets.only(top: 80),
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 100),
                                            child: Center(
                                                child: CircularProgressIndicator(
                                              color: Color(0xff7ED957),
                                            )),
                                          ),
                                        )));
                        }),
                      ],
                    )
                  : const Center(
                      child: Text(
                      'No Cooks available',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black),
                    ))
              : Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                );
        })));
  }

   buildContainer() {
    return DropdownButtonFormField<dynamic>(
      focusColor: Colors.grey.shade50,
      menuMaxHeight: 210,
      isExpanded: true,
      isDense: true,
      iconEnabledColor: const Color(0xff97949A),
      icon: const Icon(Icons.keyboard_arrow_down),
      hint: Text(
        "",
        style: TextStyle(color: AppTheme.userText, fontSize: AddSize.font14),
        textAlign: TextAlign.justify,
      ),
      decoration: InputDecoration(
          fillColor: const Color(0xFFF2F2F2),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffE3E3E3)), borderRadius: BorderRadius.all(Radius.circular(10.0)))),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please select units';
        }
        return null;
      },
      value: chooseUnit,
      items: choosedOption.map((value) {
        return DropdownMenuItem(
          value: value.toString(),
          child: Text(
            value.toString(),
            style: TextStyle(color: AppTheme.userText, fontSize: AddSize.font14),
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          chooseUnit = newValue!;
          print(chooseUnit);
        });
      },
    );
  }

  Future<void> _showSimpleDialog1() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          final height = MediaQuery.of(context).size.height;
          return Stack(
            children: [
              Positioned(
                right: 35,
                top: height * .2,
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
                    child: SizedBox(
                      height: 80,
                      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: InkWell(
                            onTap: (){
                              featuredFilterController.status.value = "1";
                              featuredFilterController.getData();
                              Get.back();
                            },
                            child: Text(
                              "Stock",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: InkWell(
                            onTap: (){
                              featuredFilterController.status.value = "0";
                              featuredFilterController.getData();
                              Get.back();
                            },
                            child: Text(
                              "Out of Stock",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
