import 'dart:developer';
import 'dart:math';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart' hide Badge;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/dimenestion.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:vertical_scrollable_tabview/vertical_scrollable_tabview.dart';
import '../controller/category_controller.dart';
import '../controller/homepage_controller.dart';
import '../repository/wishlist_repo.dart';
import '../resources/add_text.dart';
import '../widgets/custome_textfiled.dart';

class StoreListScreen extends StatefulWidget {
 final Function(bool gg) performAction;
  const StoreListScreen({Key? key, required this.performAction}) : super(key: key);
  static var storeListScreen ="/storeListScreen";

  @override
  State<StoreListScreen> createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> with TickerProviderStateMixin  {
  final homeController = Get.put(HomePageController());
  final categoryController = Get.put(CategoryController());

  String dateInput11 = "";
  RxBool isValue = false.obs;
  String? selectedCategory;
  int currentIndex = -1;
  bool? isSlotSelected = true;

  final scrollController = ScrollController();
  RxBool isSelect = false.obs;
  RxBool selectIcon = false.obs;
  int currentDrawer = 0;
  RxInt count = 0.obs;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedDate = 'Deliver Now';
  late TabController tabController;
  final autoController = AutoScrollController();
  bool isClicked=false;
  bool isClicked1=false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeController.getData();
      tabController = TabController(length: 3,vsync: this);
    });
  }

  // void _scrollListener() {
  //   if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
  //     searchController.page.value = searchController.page.value + 1;
  //     searchController.getSearchData();
  //   } else {
  //     if (kDebugMode) {
  //       print("Dont call");
  //     }
  //   }
  // }

  // void _increment() {
  //   setState(() {
  //     count++;
  //   });
  // }
  //
  // void _decrement() {
  //   setState(() {
  //     count--;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        appBar: backAppBar(title: 'Featured Today', context: context,performAction: (bool sd){
          widget.performAction(sd);
        }),
        body: Obx(() {
          return SafeArea(
            child: homeController.isDataLoading.value
                ? RefreshIndicator(
              onRefresh: () {
                return homeController.getData();
              },
              child:
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[

                              InkWell(

                                child: Container(
                                  // margin: EdgeInsets.symmetric(vertical: 5),
                                  height: 44,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF7ED957),
                                      borderRadius: BorderRadius.circular(30),
                                      border:  Border.all(
                                          color: const Color(0xFF717171).withOpacity(0.22),
                                          width: 1
                                      )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text("A la Carte", textAlign:TextAlign.center,style: GoogleFonts.ibmPlexSansArabic(fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffFFFFFF)),),
                                    ),
                                  ),
                                ),
                              ),

                              isClicked == false ?
                              GestureDetector(
                                onTap: (){
                                  isClicked=!isClicked;
                                  setState(() {});
                                },
                                child: Container(
                                  // margin: EdgeInsets.symmetric(vertical: 5),
                                  height: 44,
                                  // width: 110,
                                  decoration: BoxDecoration(
                                      // color: Color(0xFF7ED957),
                                      borderRadius: BorderRadius.circular(0),

                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text("Catering", textAlign:TextAlign.center,style: GoogleFonts.ibmPlexSansArabic(fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),),
                                    ),
                                  ),
                                ),
                              ):
                              InkWell(
                                 onTap: (){
                                   isClicked=!isClicked;
                                   setState(() {});
                                 },
                                child: Container(
                                  // margin: EdgeInsets.symmetric(vertical: 5),
                                  height: 44,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF7ED957),
                                      borderRadius: BorderRadius.circular(30),
                                      border:  Border.all(
                                          color: const Color(0xFF717171).withOpacity(0.22),
                                          width: 1
                                      )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text("Catering", textAlign:TextAlign.center,style: GoogleFonts.ibmPlexSansArabic(fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffFFFFFF)),),
                                    ),
                                  ),
                                ),
                              ),

                              isClicked1 == false ?
                              GestureDetector(
                                onTap: (){
                                  isClicked1=!isClicked1;
                                  setState(() {});
                                },
                                child: Container(
                                  // margin: EdgeInsets.symmetric(vertical: 5),
                                  height: 44,
                                  // width: 110,
                                  decoration: BoxDecoration(
                                    // color: Color(0xFF7ED957),
                                    borderRadius: BorderRadius.circular(0),

                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text("Meal Prep", textAlign:TextAlign.center,style: GoogleFonts.ibmPlexSansArabic(fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),),
                                    ),
                                  ),
                                ),
                              ): InkWell(
                                onTap: (){
                                  isClicked1=!isClicked1;
                                  setState(() {});
                                },
                                child: Container(
                                  // margin: EdgeInsets.symmetric(vertical: 5),
                                  height: 44,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF7ED957),
                                      borderRadius: BorderRadius.circular(30),
                                      border:  Border.all(
                                          color: const Color(0xFF717171).withOpacity(0.22),
                                          width: 1
                                      )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text("Meal Prep", textAlign:TextAlign.center,style: GoogleFonts.ibmPlexSansArabic(fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffFFFFFF)),),
                                    ),
                                  ),
                                ),
                              ),



                            ]
                        ),
                      ),
                    ),


                    // Container(
                    //   height: 100,
                    //   color: Colors.white,
                    //   child: ListView.builder(
                    //       shrinkWrap: true,
                    //       scrollDirection: Axis.horizontal,
                    //       itemCount:
                    //       // categoryController.categoryModel.value.data!.categories!.length,
                    //       min(3, categoryController.categoryModel.value.data!.categories!.length),
                    //       itemBuilder: (context, index) {
                    //         return Padding(
                    //           padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 7),
                    //           child:
                    //           Container(
                    //             color: Colors.white,
                    //             child: Row(
                    //                 children:[
                    //
                    //                   InkWell(
                    //                     onTap: () {
                    //                       currentIndex = index;
                    //                       setState(() {
                    //
                    //                       });
                    //                     },
                    //                     child: Container(
                    //                       // margin: EdgeInsets.symmetric(vertical: 5),
                    //                       height: 44,
                    //                       // width: 110,
                    //                       decoration: BoxDecoration(
                    //                           color: currentIndex != index ? Colors.transparent: Color(0xFF7ED957),
                    //                           borderRadius: BorderRadius.circular(30),
                    //                           border:  currentIndex == index  ? Border.all(
                    //                               color: const Color(0xff7ED957),
                    //                               width: 2
                    //                           ) :  Border.all(
                    //                               color: const Color(0xFF717171).withOpacity(0.22),
                    //                               width: 1
                    //                           )
                    //                       ),
                    //                       child: Padding(
                    //                         padding: const EdgeInsets.all(8.0),
                    //                         child: Center(
                    //                           child: Text(categoryController.categoryModel.value.data!.categories![index].name.toString().capitalizeFirst.toString(), textAlign:TextAlign.center,style: GoogleFonts.ibmPlexSansArabic(fontSize: 15,
                    //                               fontWeight: FontWeight.w600,
                    //                               color: currentIndex != index ? const Color(0xFF262626).withOpacity(0.62):Color(0xffFFFFFF)),),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   SizedBox(width: 10,),
                    //                 ]
                    //             ),
                    //           ),
                    //         );
                    //       }),
                    // ),


                              SizedBox(height: 20,),
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
                                                imageUrl:
                                                homeController.model.value.data!.stores![index].image.toString(),
                                                fit: BoxFit.cover,
                                                height: 150,
                                                width: AddSize.screenWidth,
                                                errorWidget: (_, __, ___) =>
                                                    Image.asset(
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
                                              homeController.model.value.data!.stores![index].name.toString(),
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
                                          children: const [
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
                                                height: 48,
                                                decoration:
                                                const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(3),
                                                  child: Image.asset('assets/images/avtarImg.png'),
                                                )),
                                            addHeight(3),
                                            Text(
                                              (homeController.model.value.data!.stores![index].cookName!.isEmpty
                                                  ? 'Test'
                                                  : homeController.model.value.data!.stores![index].cookName)
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
                                                  homeController.model.value.data!.stores![index].rating.toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 11,
                                                      color: const Color(0xFF6A7080)),
                                                ),
                                                Text(
                                                  '(${(homeController.model.value.data!.stores![index].countReviewData!
                                                      .isEmpty ? '3' : '').toString()})',
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
                                                decoration:
                                                const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      // // isSelect.value = !isSelect.value;
                                                      // print(homeController.model.value.data!.stores![index].id
                                                      //     .toString());
                                                      // wishlistRepo(
                                                      //     id: homeController.model.value.data!.stores![index].id
                                                      //         .toString())
                                                      //     .then((value) {
                                                      //   if (value.status == true) {
                                                      //     // if (value.message.toString() == 'global.WISHLIST_REMOVED') {
                                                      //     //   homeController.model.value.data!.stores![index].wishlist =
                                                      //     //   false;
                                                      //     // } else {
                                                      //     //   homeController.model.value.data!.stores![index].wishlist =
                                                      //     //   true;
                                                      //     // }
                                                      //
                                                      //     showToast(value.message.toString());
                                                      //     // homeController.getData();
                                                      //     // setState(() {});
                                                      //   }
                                                      // });

                                                    },

                                                    child:   homeController.model.value.data!.stores![index].wishlist! ? Icon(
                                                      Icons.favorite,
                                                      color: Color(0xFF54C523),
                                                    ) : const Icon(
                                                      Icons.favorite_outline,
                                                      color: Color(0xFF54C523),
                                                    ),
                                                  ),
                                                )),
                                            //   }),
                                          ],
                                        )),
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
                                                      barrierColor: const Color(0xFF000000).withOpacity(0.58),
                                                      barrierLabel:
                                                      MaterialLocalizations
                                                          .of(context)
                                                          .modalBarrierDismissLabel,
                                                      pageBuilder:
                                                          (BuildContext context, Animation first, Animation second) {
                                                        return Stack(
                                                          children: [
                                                            Center(
                                                                child: Image.asset('assets/images/dialogboximg.png')),
                                                            Positioned(
                                                              right: 18,
                                                              top: 30,
                                                              child: Container(
                                                                  padding: EdgeInsets.all(10),
                                                                  height: 80,
                                                                  decoration: const BoxDecoration(
                                                                      color: Colors.white, shape: BoxShape.circle),
                                                                  child: GestureDetector(
                                                                    child: Icon(Icons.clear),
                                                                    onTap: () {
                                                                      Get.back();
                                                                    },
                                                                  )),
                                                            )
                                                          ],
                                                        );
                                                      });
                                                },
                                                child: Image.asset(
                                                  'assets/images/topChef.png',
                                                  width: 50,
                                                )),
                                            GestureDetector(
                                                onTap: () {
                                                  showGeneralDialog(
                                                      context: context,
                                                      barrierDismissible: true,
                                                      barrierColor: const Color(0xFF000000).withOpacity(0.58),
                                                      barrierLabel:
                                                      MaterialLocalizations
                                                          .of(context)
                                                          .modalBarrierDismissLabel,
                                                      pageBuilder:
                                                          (BuildContext context, Animation first, Animation second) {
                                                        return Stack(
                                                          children: [
                                                            Center(
                                                                child: Image.asset('assets/images/dialogboximg.png')),
                                                            Positioned(
                                                              right: 18,
                                                              top: 50,
                                                              child: Container(
                                                                  padding: EdgeInsets.all(10),
                                                                  height: 50,
                                                                  decoration: const BoxDecoration(
                                                                      color: Colors.white, shape: BoxShape.circle),
                                                                  child: GestureDetector(
                                                                    child: Icon(Icons.clear),
                                                                    onTap: () {
                                                                      Get.back();
                                                                    },
                                                                  )),
                                                            )
                                                          ],
                                                        );
                                                      });
                                                },
                                                child: Image.asset(
                                                  'assets/images/topChef.png',
                                                  width: 50,
                                                )),
                                          ],
                                        )),
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

                  ],
                ),
              ),
            )
                : Center(child: CircularProgressIndicator()),
          );
        })
      //bottomNavigationBar: ,
    );
  }
}
