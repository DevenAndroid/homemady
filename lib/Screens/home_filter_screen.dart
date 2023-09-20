import 'dart:async';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/widgets/new_helper.dart';
import '../controller/filter_controller.dart';
import '../controller/homepage_controller.dart';
import '../controller/my_cart_controller.dart';
import '../controller/search_store_conbtroller.dart';
import '../controller/user_profile_controller.dart';
import '../repository/wishlist_repo.dart';
import '../resources/add_text.dart';
import '../routers/routers.dart';
import '../widgets/custome_size.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/dimenestion.dart';
import 'myAddressScreen.dart';

class HomeFilterScreen extends StatefulWidget {
  const HomeFilterScreen({Key? key}) : super(key: key);
  static var homeFilterScreen = "/homeFilterScreen";
  @override
  State<HomeFilterScreen> createState() => _HomeFilterScreenState();
}

class _HomeFilterScreenState extends State<HomeFilterScreen> {
  final controller = Get.put(HomePageController());
  final filterDataController = Get.put(FilterController());
  final profileController = Get.put(UserProfileController());
  final searchController = Get.put(SearchStoreController());
  final myCartController = Get.put(MyCartListController());
  final homeController = Get.put(HomePageController());

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
    // filterDataController.storeSearchController.clear();
    // homeController.getData();
    // filterDataController.getFilterData().then((value){
    //   setState(() {});
    // });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // homeController.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: const Color(0xffFFFFFF),
        appBar: backAppBar(title: 'Cooks', context: context),
        body: true ?
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16, vertical: AddSize.padding10),
            child: Column(
              children: [

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
                                setState(() {});
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

                homeController.model.value.data!.stores!.isNotEmpty ?
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
                                              .toString().capitalizeFirst.toString(),
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
                                              'Delivery Only ${homeController.model.value.data!.stores![index].time ?? ''.toString()} mins',
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
                                // Arrows Ui
                                // const Positioned(
                                //    top: 80,
                                //    // bottom: 0,
                                //    left: 20,
                                //    right: 20,
                                //    //   bottom: 0,
                                //    child: Row(
                                //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //      children: [
                                //        Icon(
                                //          Icons.arrow_back_ios,
                                //          color: Colors.white,
                                //          size: 20,
                                //        ),
                                //        Icon(
                                //          Icons.arrow_forward_ios,
                                //          color: Colors.white,
                                //          size: 20,
                                //        )
                                //      ],
                                //    )),
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
                                              .toString().capitalizeFirst.toString(),
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
                                              '(${(homeController.model.value.data!.stores![index].countReviewData).toString()})',
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
                                homeController.model.value.data!.stores![index].award!.isNotEmpty || homeController.model.value.data!.stores![index].sustainablePackagingStatus == true?
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
                                            ...List.generate(homeController.model.value.data!.stores![index].award!.length, (index1){
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
                                                              imageUrl:     homeController.model.value.data!.stores![index].award![index1].image.toString(),
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
                                                  imageUrl:     homeController.model.value.data!.stores![index].award![index1].image.toString(),
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
                                        if(homeController.model.value.data!.stores![index].sustainablePackagingStatus == true)
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
                    );
                  },
                ):const Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: Center(child: Text('No Cooks available',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color: Colors.black),)),
                )

              ],
            ),
          ),
        ): const Center(child: CircularProgressIndicator(color: Colors.green,),),


    );
  }


}
