import 'dart:async';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/filter_controller.dart';
import '../controller/homepage_controller.dart';
import '../controller/my_cart_controller.dart';
import '../controller/search_store_conbtroller.dart';
import '../controller/user_profile_controller.dart';
import '../routers/routers.dart';
import '../widgets/app_theme.dart';
import '../widgets/custome_size.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/dimenestion.dart';
import 'myAddressScreen.dart';

class SearchScreenData extends StatefulWidget {
  const SearchScreenData({Key? key}) : super(key: key);
  static var searchScreen = "/searchScreen";
  @override
  State<SearchScreenData> createState() => _SearchScreenDataState();
}

class _SearchScreenDataState extends State<SearchScreenData> {
  final controller = Get.put(HomePageController());
  final filterDataController = Get.put(FilterController());
  final profileController = Get.put(UserProfileController());
  final searchController = Get.put(SearchStoreController());
  final myCartController = Get.put(MyCartListController());

  Timer? timer;

  debounceSearch(){
    if(timer != null){
      timer!.cancel();
    }
    timer = Timer(const Duration(milliseconds: 200), () {
      filterDataController.getFilterData().then((value) {
        setState(() {});
      });
    });
  }

  @override
  void initState() {
    super.initState();
    filterDataController.storeSearchController.clear();
    filterDataController.getFilterData().then((value){
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: const Color(0xffFFFFFF),
        appBar: AppBar(
          title: Row(
            children: [
              GestureDetector(onTap: () {
                profileController.scaffoldKey.currentState!.openDrawer();
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
      body:
      filterDataController.isDataLoading ?
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AddSize.padding16, vertical: AddSize.padding10),
          child: Column(
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
                        profileController.model.value.data!.name.toString().capitalizeFirst.toString(),
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
                          controller: filterDataController.storeSearchController,
                          prefix: InkWell(
                            onTap: () {

                              filterDataController.getFilterData();
                            },
                            child: Icon(
                              Icons.search,
                              size: 19,
                              color: const Color(0xFF000000).withOpacity(0.56),
                            ),
                          ),
                          onChanged: (val) {
                            debounceSearch();
                          },
                        )),
                  ),
                  addWidth(10),
                  GestureDetector(
                    onTap: () {
                      Get.back();
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
                      Get.back();
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
              addHeight(26),
              // SizedBox(
              //   height: height * .07,
              //   child: TextField(
              //     maxLines: 1,
              //     controller: filterDataController.storeSearchController,
              //     style: const TextStyle(fontSize: 17),
              //     textAlignVertical: TextAlignVertical.center,
              //     textInputAction: TextInputAction.search,
              //     onChanged: (value) {
              //       debounceSearch();
              //     },
              //     decoration: InputDecoration(
              //         focusedBorder: const OutlineInputBorder(
              //             borderSide: BorderSide(
              //               color: Colors.grey,
              //             )),
              //         enabledBorder: const OutlineInputBorder(
              //           borderSide: BorderSide(color: Colors.grey, width: 0.0),
              //         ),
              //         filled: true,
              //         suffixIcon: IconButton(
              //           onPressed: () {
              //             filterDataController.getFilterData();
              //           },
              //           icon: const Icon(
              //             Icons.search_rounded,
              //             color: Color(0xff7ED957),
              //             size: 30,
              //           ),
              //         ),
              //         border: const OutlineInputBorder(
              //           // borderSide: BorderSide.none,
              //             borderRadius: BorderRadius.all(Radius.circular(8))),
              //         fillColor: Colors.white,
              //         contentPadding:
              //         EdgeInsets.symmetric(horizontal: width * .04),
              //         hintText: 'search store..',
              //         hintStyle: TextStyle(
              //             fontSize: AddSize.font14,
              //             color: AppTheme.blackcolor,
              //             fontWeight: FontWeight.w400)),
              //   ),
              // ),

              filterDataController.filterModel.value.data != null && filterDataController.filterModel.value.data!.isNotEmpty
              // ? (searchController.searchDataModel.value.data != null && searchController.searchDataModel.value.data!.isNotEmpty)
                  ? ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                  itemCount: filterDataController.filterModel.value.data != null
                      ? filterDataController.filterModel.value.data!.length
                      : 0,
                  shrinkWrap: true,
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
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(MyRouters.homeDetailsScreen, arguments: [
                                        filterDataController.filterModel.value.data![index].id
                                            .toString()]);
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: CachedNetworkImage(
                                            imageUrl: filterDataController.filterModel.value.data![index].image
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
                                        // Image.asset(
                                        //     'assets/images/Rectangle 2171.png'),
                                        addHeight(6),
                                        Text(
                                          filterDataController.filterModel.value.data![index].name
                                              .toString()
                                              .capitalizeFirst!,
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
                                  // const Positioned(
                                  //   top: 80,
                                  //   // bottom: 0,
                                  //   left: 20,
                                  //   right: 20,
                                  //   //   bottom: 0,
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       Icon(
                                  //         Icons.arrow_back_ios,
                                  //         color: Colors.white,
                                  //         size: 20,
                                  //       ),
                                  //       Icon(
                                  //         Icons.arrow_forward_ios,
                                  //         color: Colors.white,
                                  //         size: 20,
                                  //       )
                                  //     ],
                                  //   )),
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
                                                shape: BoxShape.circle, color: Colors.white),
                                            child:
                                            SizedBox(
                                              height: 50,
                                              width: 50,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(100),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                  filterDataController.isDataLoading ?
                                                  filterDataController.filterModel.value.data![index].profileImage.toString()
                                                      :
                                                  'assets/images/avtarImg.png',
                                                  // height: 40,
                                                  fit: BoxFit.cover,
                                                  // errorWidget: (-, --, ---)=>Image.asset('assets/images/avtarImg.png'),
                                                ),

                                              ),
                                            ),
                                            // Padding(
                                            //   padding: const EdgeInsets.all(3),
                                            //   child: Image.asset('assets/images/avtarImg.png'),
                                            // )
                                        ),
                                        addHeight(3),
                                        Text(

                                          filterDataController.filterModel.value.data![index].cookName
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
                                              (filterDataController.filterModel.value.data![index].distance??
                                                  '3')
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 11,
                                                  color: const Color(0xFF6A7080)),
                                            ),
                                            addWidth(5),
                                            // Text(
                                            //   '(${(controller1.model.value.data!.store![index].countReviewData ?? '12').toString()})',
                                            //   style: GoogleFonts.poppins(
                                            //       fontWeight: FontWeight.w500,
                                            //       fontSize: 11,
                                            //       color: const Color(0xFF6A7080)),
                                            // ),
                                          ],
                                        )
                                      ],
                                    )),

                                // Positioned(
                                //     top: 14,
                                //     // bottom: 0,
                                //     left: 10,
                                //     right: 15,
                                //     //   bottom: 0,
                                //     child: Row(
                                //       children: [
                                //         InkWell(
                                //             onTap: () {
                                //               showGeneralDialog(
                                //                   context: context,
                                //                   barrierDismissible: true,
                                //                   barrierColor:
                                //                   const Color(0xFF000000).withOpacity(0.58),
                                //                   barrierLabel: MaterialLocalizations.of(context)
                                //                       .modalBarrierDismissLabel,
                                //                   pageBuilder: (BuildContext context, Animation first,
                                //                       Animation second) {
                                //                     return Stack(
                                //                       children: [
                                //                         Center(
                                //                             child: Image.asset(
                                //                                 'assets/images/dialogboximg.png')),
                                //                         Positioned(
                                //                           right: 18,
                                //                           top: 30,
                                //                           child: Container(
                                //                               padding: const EdgeInsets.all(10),
                                //                               height: 80,
                                //                               decoration: const BoxDecoration(
                                //                                   color: Colors.white,
                                //                                   shape: BoxShape.circle),
                                //                               child: const Icon(Icons.clear)),
                                //                         )
                                //                       ],
                                //                     );
                                //                   });
                                //             },
                                //             child: Image.asset(
                                //               'assets/images/topChef.png',
                                //               width: 50,
                                //             )),
                                //         InkWell(
                                //             onTap: () {
                                //               showGeneralDialog(
                                //                   context: context,
                                //                   barrierDismissible: true,
                                //                   barrierColor:
                                //                   const Color(0xFF000000).withOpacity(0.58),
                                //                   barrierLabel: MaterialLocalizations.of(context)
                                //                       .modalBarrierDismissLabel,
                                //                   pageBuilder: (BuildContext context, Animation first,
                                //                       Animation second) {
                                //                     return Stack(
                                //                       children: [
                                //                         Center(
                                //                             child: Image.asset(
                                //                                 'assets/images/dialogboximg.png')),
                                //                         Positioned(
                                //                           right: 18,
                                //                           top: 50,
                                //                           child: Container(
                                //                               padding: const EdgeInsets.all(10),
                                //                               height: 50,
                                //                               decoration: const BoxDecoration(
                                //                                   color: Colors.white,
                                //                                   shape: BoxShape.circle),
                                //                               child: const Icon(Icons.clear)),
                                //                         )
                                //                       ],
                                //                     );
                                //                   });
                                //             },
                                //             child: Image.asset(
                                //               'assets/images/topChef.png',
                                //               width: 50,
                                //             )),
                                //       ],
                                //     )),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    );
                  })
                  : Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    const SizedBox(height: 60,),
                    Image.asset('assets/images/searchImage.png'),
                    const SizedBox(height: 10,),
                    Text("Result Not Found",
                      style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,color: const Color(0xff000000),fontSize: 22),),
                  ],
                ),
              ) ,

            ],
          ),
        ),
      ): const Center(child: CircularProgressIndicator(color: Colors.green,),)

    );
  }


}
