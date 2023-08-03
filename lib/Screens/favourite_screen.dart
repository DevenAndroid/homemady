import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../controller/homepage_controller.dart';
import '../model/my_cart_model.dart';

import '../controller/favorite_controller.dart';
import '../controller/my_cart_controller.dart';
import '../controller/vendor_single_store_controller.dart';
import '../repository/add_cart_repo.dart';
import '../repository/remove_cartitem_repo.dart';
import '../resources/add_text.dart';
import '../widgets/dimenestion.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen>  with TickerProviderStateMixin {
  RxBool isSelect1 = false.obs;
  RxBool isSelect = false.obs;
  late TabController tabController;
  final controller1 = FavoriteListController();

  final controller = Get.put(VendorSingleStoreController());
  final cartListController = Get.put(MyCartListController());
  final homeController = Get.put(HomePageController());

  final autoController = AutoScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller1.get();
    tabController = TabController(length: 3, vsync: this);
  }
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: backAppBar(title: 'My Favorites', context: context),
        body:
        controller1.isDataLoading.value
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              isSelect1.value = !isSelect1.value;
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                              decoration: isSelect1.value == true
                                  ? BoxDecoration(
                                      border: Border.all(color: const Color(0xFF717171), width: 1),
                                      borderRadius: BorderRadius.circular(4))
                                  : BoxDecoration(
                                      color: const Color(0xFF7ED957), borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                  child: isSelect1.value == true
                                      ? const Text(
                                          'Cooks',
                                          style: TextStyle(
                                            color: Color(0xFF717171),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      : const Text(
                                          'Cooks',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                            ),
                          )),
                          addWidth(26),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              isSelect1.value = !isSelect1.value;
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                              decoration: isSelect1.value == true
                                  ? BoxDecoration(
                                      color: const Color(0xFF7ED957), borderRadius: BorderRadius.circular(4))
                                  : BoxDecoration(
                                      border: Border.all(color: const Color(0xFF717171), width: 1),
                                      borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                  child: isSelect1.value == true
                                      ? const Text(
                                          'Meals',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      : const Text(
                                          'Meals',
                                          style: TextStyle(
                                            color: Color(0xFF717171),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                            ),
                          )),
                        ],
                      ),
                      addHeight(20),
                      isSelect1.value == false
                          ? controller1.isDataLoading.value
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller1.model.value.data!.store!.length,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        // controller1.storeId.value = homeController.model.value.data!.stores![index].id.toString();
                                        // print("store id is ..${homeController.model.value.data!.stores![index].id.toString()}");
                                        // Get.toNamed(MyRouters.homePageScreen);
                                      },
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
                                                        // controller1.storeId.value = homeController.model.value.data!.stores![index].id.toString();
                                                        // print("store id is ..${homeController.model.value.data!.stores![index].id.toString()}");
                                                        // Get.toNamed(CarteScreen.carteScreenPage);
                                                      },
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius: BorderRadius.circular(8),
                                                            child: CachedNetworkImage(
                                                              imageUrl: controller1
                                                                  .model.value.data!.store![index].image
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
                                                            controller1.model.value.data!.store![index].name
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
                                                  const Positioned(
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
                                                              height: 48,
                                                              decoration: const BoxDecoration(
                                                                  shape: BoxShape.circle, color: Colors.white),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(3),
                                                                child: Image.asset('assets/images/avtarImg.png'),
                                                              )),
                                                          addHeight(3),
                                                          Text(
                                                            controller1.model.value.data!.store![index].cookName
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
                                                                (controller1.model.value.data!.store![index].rating ??
                                                                        '3')
                                                                    .toString(),
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 11,
                                                                    color: const Color(0xFF6A7080)),
                                                              ),
                                                              addWidth(5),
                                                              Text(
                                                                '(${(controller1.model.value.data!.store![index].countReviewData ?? '12').toString()})',
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
                                                          Obx(() {
                                                            return Container(
                                                                height: 33,
                                                                decoration: const BoxDecoration(
                                                                    shape: BoxShape.circle, color: Colors.white),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(
                                                                      left: 10, right: 10, top: 3),
                                                                  child: InkWell(
                                                                    onTap: () {
                                                                      isSelect.value = !isSelect.value;
                                                                    },
                                                                    child: isSelect.value == true
                                                                        ? const Icon(
                                                                            Icons.favorite,
                                                                            color: Color(0xFF54C523),
                                                                          )
                                                                        : const Icon(
                                                                            Icons.favorite_outline,
                                                                            color: Color(0xFF54C523),
                                                                          ),
                                                                  ),
                                                                ));
                                                          }),
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
                                                          InkWell(
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
                                                                              child: Image.asset(
                                                                                  'assets/images/dialogboximg.png')),
                                                                          Positioned(
                                                                            right: 18,
                                                                            top: 30,
                                                                            child: Container(
                                                                                padding: EdgeInsets.all(10),
                                                                                height: 80,
                                                                                decoration: const BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    shape: BoxShape.circle),
                                                                                child: Icon(Icons.clear)),
                                                                          )
                                                                        ],
                                                                      );
                                                                    });
                                                              },
                                                              child: Image.asset(
                                                                'assets/images/topChef.png',
                                                                width: 50,
                                                              )),
                                                          InkWell(
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
                                                                              child: Image.asset(
                                                                                  'assets/images/dialogboximg.png')),
                                                                          Positioned(
                                                                            right: 18,
                                                                            top: 50,
                                                                            child: Container(
                                                                                padding: EdgeInsets.all(10),
                                                                                height: 50,
                                                                                decoration: const BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    shape: BoxShape.circle),
                                                                                child: Icon(Icons.clear)),
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
                                      ),
                                    );
                                  },
                                )
                              : const Center(child: Text("Data not loading")):SizedBox(),


                      controller.isDataLoading.value
                              ?
                              // ListView.builder(
                              //   shrinkWrap: true,
                              //   itemCount: controller.model.value.data!.store!.length,
                              //   physics: const BouncingScrollPhysics(),
                              //   itemBuilder: (context, index) {
                              //     return SingleChildScrollView(
                              //       child: Column(
                              //         children: [
                              //           Padding(
                              //             padding: const EdgeInsets.only(right: 8.0),
                              //             child: Container(
                              //               decoration: BoxDecoration(
                              //                 color: Colors.white,
                              //                 borderRadius: BorderRadius.circular(10),
                              //                 boxShadow: [
                              //                   BoxShadow(
                              //                     color: const Color(0xFF37C666).withOpacity(
                              //                         0.15),
                              //                     offset: const Offset(.3, .3,
                              //                     ),
                              //                     blurRadius: 20.0,
                              //                     spreadRadius: 1.0,
                              //                   ),
                              //                 ],
                              //               ),
                              //               child: Stack(
                              //                 children: [
                              //                   Padding(
                              //                     padding: const EdgeInsets.all(8.0),
                              //                     child: InkWell(
                              //                       onTap: (){
                              //                         // Get.toNamed(MyRouters.homeDetailsScreen);
                              //                       },
                              //                       child: Column(
                              //                         crossAxisAlignment: CrossAxisAlignment
                              //                             .start,
                              //                         children: [
                              //                           Image.asset(
                              //                               'assets/images/Rectangle 2171.png'),
                              //                           addHeight(6),
                              //                           Text(controller.model.value.data!.store![index].name.toString(),
                              //                             style: GoogleFonts.poppins(
                              //                                 fontWeight: FontWeight.w700,
                              //                                 fontSize: 16,
                              //                                 color: const Color(0xFF21283D)
                              //                             ),),
                              //                           addHeight(6),
                              //                           Row(
                              //                             children: [
                              //                               Image.asset(
                              //                                 'assets/images/truckimg.png',
                              //                                 height: 22,
                              //                                 color: const Color(0xFF04666E),),
                              //                               addWidth(10),
                              //                               Text('Delivery Only 25 mins',
                              //                                 style: GoogleFonts.poppins(
                              //                                     fontWeight: FontWeight.w400,
                              //                                     fontSize: 12,
                              //                                     color: const Color(0xFF606573)
                              //                                 ),),
                              //                             ],
                              //                           )
                              //                         ],
                              //                       ),
                              //                     ),
                              //                   ),
                              //                   Positioned(
                              //                       top: 80,
                              //                       // bottom: 0,
                              //                       left: 20,
                              //                       right: 20,
                              //                       //   bottom: 0,
                              //                       child: Row(
                              //                         mainAxisAlignment: MainAxisAlignment
                              //                             .spaceBetween,
                              //                         children: const [
                              //                           Icon(Icons.arrow_back_ios,
                              //                             color: Colors.white,size: 20,),
                              //                           Icon(Icons.arrow_forward_ios,
                              //                             color: Colors.white,size: 20,)
                              //                         ],
                              //                       )
                              //                   ),
                              //                   Positioned(
                              //                       bottom: 10,
                              //                       right: 20,
                              //                       //   bottom: 0,
                              //                       child: Column(
                              //                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //                         children: [
                              //                           Container(
                              //                               height: 48,
                              //                               decoration: const BoxDecoration(
                              //                                   shape: BoxShape.circle,
                              //                                   color: Colors.white
                              //                               ),
                              //                               child: Padding(
                              //                                 padding: const EdgeInsets.all(3),
                              //                                 child: Image.asset(
                              //                                     'assets/images/avtarImg.png'),
                              //                               )
                              //                           ),
                              //                           addHeight(3),
                              //                           Text(controller.model.value.data!.store![index].cookName.toString(),
                              //                             style: GoogleFonts.poppins(
                              //                                 fontWeight: FontWeight.w500,
                              //                                 fontSize: 12,
                              //                                 color: const Color(0xFF21283D)
                              //                             ),),
                              //                           Row(
                              //                             crossAxisAlignment: CrossAxisAlignment
                              //                                 .center,
                              //                             mainAxisAlignment: MainAxisAlignment
                              //                                 .center,
                              //                             children: [
                              //                               const Icon(Icons.star,
                              //                                 color: Color(0xFFFFC529),
                              //                                 size: 14,),
                              //                               addWidth(3),
                              //                               Text((controller.model.value.data!.store![index].rating ?? '3').toString(),
                              //                                 style: GoogleFonts.poppins(
                              //                                     fontWeight: FontWeight.w500,
                              //                                     fontSize: 11,
                              //                                     color: const Color(0xFF6A7080)
                              //                                 ),),
                              //                               addWidth(3),
                              //                               Text((controller.model.value.data!.store![index].countReviewData ?? '10').toString(),
                              //                                 style: GoogleFonts.poppins(
                              //                                     fontWeight: FontWeight.w500,
                              //                                     fontSize: 11,
                              //                                     color: const Color(0xFF6A7080)
                              //                                 ),),
                              //                             ],
                              //                           )
                              //                         ],
                              //                       )
                              //                   ),
                              //                   Positioned(
                              //                       top: 16,
                              //                       // bottom: 0,
                              //                       // left: 290,
                              //                       right: 10,
                              //                       //   bottom: 0,
                              //
                              //                       child: Column(
                              //                         children: [
                              //                           Obx(() {
                              //                             return Container(
                              //                                 height: 33,
                              //                                 decoration: const BoxDecoration(
                              //                                     shape: BoxShape.circle,
                              //                                     color: Colors.white
                              //                                 ),
                              //                                 child: Padding(
                              //                                   padding: const EdgeInsets
                              //                                       .only(left: 10,
                              //                                       right: 10,
                              //                                       top: 3),
                              //                                   child: InkWell(
                              //                                     onTap: () {
                              //                                       isSelect.value = !isSelect.value;
                              //                                     },
                              //                                     child: isSelect.value ==
                              //                                         true
                              //                                         ? const Icon(
                              //                                       Icons.favorite,
                              //                                       color: Color(0xFF54C523),)
                              //                                         :
                              //                                     const Icon(Icons.favorite_outline,
                              //                                       color: Color(
                              //                                           0xFF54C523),),
                              //                                   ),
                              //                                 )
                              //                             );
                              //                           }),
                              //                         ],
                              //                       )
                              //                   ),
                              //                   Positioned(
                              //                       top: 14,
                              //                       // bottom: 0,
                              //                       left: 10,
                              //                       right: 15,
                              //                       //   bottom: 0,
                              //                       child: Row(
                              //                         children:  [
                              //
                              //                           InkWell(
                              //                               onTap: (){
                              //                                 showGeneralDialog(
                              //                                     context: context,
                              //                                     barrierDismissible: true,
                              //                                     barrierColor: const Color(0xFF000000).withOpacity(0.58),
                              //                                     barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                              //                                     pageBuilder: (BuildContext context,Animation first, Animation second){
                              //                                       return  Stack(
                              //                                         children: [
                              //                                           Center(child: Image.asset('assets/images/dialogboximg.png')),
                              //                                           Positioned(
                              //                                             right: 18,
                              //                                             top: 30,
                              //                                             child: Container(
                              //                                                 padding: EdgeInsets.all(10),
                              //                                                 height: 80,
                              //                                                 decoration: const BoxDecoration(
                              //                                                     color: Colors.white,
                              //                                                     shape: BoxShape.circle
                              //                                                 ),
                              //                                                 child:  Icon(Icons.clear)
                              //                                             ),)
                              //                                         ],
                              //                                       );
                              //                                     }
                              //                                 );
                              //                               },
                              //                               child: Image.asset('assets/images/topChef.png',width: 50,)),
                              //                           InkWell(
                              //                               onTap: (){
                              //                                 showGeneralDialog(
                              //                                     context: context,
                              //                                     barrierDismissible: true,
                              //                                     barrierColor: const Color(0xFF000000).withOpacity(0.58),
                              //                                     barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                              //                                     pageBuilder: (BuildContext context,Animation first, Animation second){
                              //                                       return  Stack(
                              //                                         children: [
                              //                                           Center(child: Image.asset('assets/images/dialogboximg.png')),
                              //                                           Positioned(
                              //                                             right: 18,
                              //                                             top: 50,
                              //                                             child: Container(
                              //                                                 padding: EdgeInsets.all(10),
                              //                                                 height: 50,
                              //                                                 decoration: const BoxDecoration(
                              //                                                     color: Colors.white,
                              //                                                     shape: BoxShape.circle
                              //                                                 ),
                              //                                                 child:  Icon(Icons.clear)
                              //                                             ),)
                              //                                         ],
                              //                                       );
                              //                                     }
                              //                                 );
                              //                               },
                              //                               child: Image.asset('assets/images/topChef.png',width: 50,)),
                              //                         ],
                              //                       )
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           ),
                              //           const SizedBox(height: 15,)
                              //         ],
                              //       ),
                              //     );
                              //   },
                              // )
                              ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: controller.model.value.data!.latestProducts!.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    String productID =
                                        controller.model.value.data!.latestProducts![index].id.toString().trim();
                                    controller.model.value.data!.latestProducts![index].productCount = int.tryParse(
                                            (cartListController.model.value.data!.cartItems!
                                                        .firstWhere(
                                                            (element) => element.productId.toString() == productID,
                                                            orElse: () => CartItems())
                                                        .cartItemQty ??
                                                    "")
                                                .toString()) ??
                                        0;
                                    final product = controller.model.value.data!.latestProducts![index];

                                    return Column(
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
                                          child: InkWell(
                                            onTap: () {
                                              // print(
                                              //   controller.model.value.data!.latestProducts![index].id.toString(),
                                              // );
                                              // Get.toNamed(MyRouters.myCartScreen);
                                            },
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(10),
                                                      child: CachedNetworkImage(
                                                        imageUrl: controller
                                                            .model.value.data!.latestProducts![index].image
                                                            .toString(),
                                                        fit: BoxFit.cover,
                                                        height: 80,
                                                        width: 60,
                                                        errorWidget: (_, __, ___) => Image.asset(
                                                          'assets/images/Rectangle 23007.png',
                                                          fit: BoxFit.cover,
                                                          height: 80,
                                                          width: 60,
                                                        ),
                                                        placeholder: (_, __) =>
                                                            const Center(child: CircularProgressIndicator()),
                                                      ),
                                                    ),
                                                    addWidth(10),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  controller
                                                                      .model.value.data!.latestProducts![index].name
                                                                      .toString()
                                                                      .replaceAll(
                                                                          'homemady product test1284sdf', 'Test'),
                                                                  style: GoogleFonts.poppins(
                                                                      fontWeight: FontWeight.w700,
                                                                      fontSize: 14,
                                                                      color: const Color(0xFF21283D)),
                                                                  maxLines: 2,
                                                                ),
                                                              ),
                                                              // const Spacer(),
                                                              Text(
                                                                '€ ${controller.model.value.data!.latestProducts![index].price.toString()}',
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w700,
                                                                    fontSize: 15,
                                                                    color: const Color(0xFF70CC49)),
                                                              ),
                                                            ],
                                                          ),
                                                          addHeight(3),
                                                          Text(
                                                            '${(controller.model.value.data!.latestProducts![index].size ?? '300').toString()} gm',
                                                            style: GoogleFonts.poppins(
                                                                fontWeight: FontWeight.w300,
                                                                fontSize: 11,
                                                                color: const Color(0xFF364A4F)),
                                                          ),
                                                          addHeight(3),
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
                                                              Expanded(
                                                                child: Text(
                                                                  'Mildly Spicy',
                                                                  style: GoogleFonts.poppins(
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 10,
                                                                      color: const Color(0xFF6CC844)),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          addHeight(4),
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
                                                              Expanded(
                                                                child: Text(
                                                                  'Crustaceans',
                                                                  style: GoogleFonts.poppins(
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 10,
                                                                      color: const Color(0xFF6CC844)),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          addHeight(4),
                                                          IntrinsicHeight(
                                                            child: Row(
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    if (cartListController.model.value.data!.cartItems!
                                                                            .map((e) => e.productId.toString())
                                                                            .toList()
                                                                            .contains(productID) &&
                                                                        product.productCount == 1) {
                                                                      print("sssssssssssssssssssssssss");
                                                                      print(
                                                                          "sssssssssssssssssssssssss${cartListController.model.value.data!.cartItems!.map((e) => e.productId.toString()).toList()}");
                                                                      String gg = (cartListController
                                                                                  .model.value.data!.cartItems!
                                                                                  .firstWhere(
                                                                                      (element) =>
                                                                                          element.productId
                                                                                              .toString() ==
                                                                                          productID,
                                                                                      orElse: () => CartItems())
                                                                                  .id ??
                                                                              "")
                                                                          .toString();
                                                                      if (gg.isEmpty) return;
                                                                      removeCartItemRepo(
                                                                              cart_item_id: gg, context: context)
                                                                          .then((value) {
                                                                        if (value.status == true) {
                                                                          cartListController.getData().then((value) {
                                                                            setState(() {});
                                                                          });
                                                                        }
                                                                      });
                                                                    } else {
                                                                      addToCartRepo(
                                                                              product_id: controller.model.value.data!
                                                                                  .latestProducts![index].id
                                                                                  .toString(),
                                                                              qty: product.productCount - 1,
                                                                              //controller.model.value.data!.latestProducts![index].buttonCount.value,
                                                                              context: context)
                                                                          .then((value1) {
                                                                        if (value1.status == true) {
                                                                          controller.model.value.data!
                                                                              .latestProducts![index].value = true;
                                                                          // controller.model.value.data!.latestProducts![index].buttonCount.value--;
                                                                          showToast(value1.message.toString());
                                                                          // controller.decreaseQty();
                                                                          cartListController.getData();
                                                                        }
                                                                      });
                                                                      cartListController.getData().then((value) {
                                                                        setState(() {});
                                                                      });
                                                                    }
                                                                  },
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                        border:
                                                                            Border.all(color: const Color(0xFF72CD4A)),
                                                                        shape: BoxShape.circle),
                                                                    alignment: Alignment.center,
                                                                    child: const Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: 8, vertical: 3),
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
                                                                  child: Padding(
                                                                    padding:
                                                                        const EdgeInsets.only(left: 14.0, right: 14.0),
                                                                    child: Text(product.productCount.toString()
                                                                        // controller.model.value.data!.latestProducts![index].buttonCount.value
                                                                        //     .toString(),
                                                                        ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    // buttonCount.value++;
                                                                    addToCartRepo(
                                                                            product_id: controller.model.value.data!
                                                                                .latestProducts![index].id
                                                                                .toString(),
                                                                            qty: product.productCount + 1,
                                                                            //controller.model.value.data!.latestProducts![index].buttonCount.value,
                                                                            context: context)
                                                                        .then((value1) {
                                                                      if (value1.status == true) {
                                                                        controller.model.value.data!
                                                                            .latestProducts![index].value = true;
                                                                        // controller.model.value.data!.latestProducts![index].buttonCount.value++;
                                                                        showToast(value1.message.toString());
                                                                        // controller.increaseQty();
                                                                        cartListController.getData().then((value) {
                                                                          setState(() {});
                                                                        });
                                                                      }
                                                                    });
                                                                  },
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                        color: const Color(0xFF72CD4A),
                                                                        border:
                                                                            Border.all(color: const Color(0xFF72CD4A)),
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
                                                    ),
                                                  ],
                                                ),
                                                addHeight(5),
                                                Container(
                                                  margin: EdgeInsets.only(left: 82),
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
                                                    Expanded(
                                                      child: Text(
                                                        'Can cook more units by: 30th June 2023',
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 11,
                                                            color: const Color(0xFF364A4F)),
                                                      ),
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
                                                      '${controller.model.value.data!.latestProducts![index].cookUnitDays ?? '5'.toString()} Units',
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
                                        ),
                                        addHeight(10)
                                      ],
                                    );
                                  },
                                )
                              : SizedBox(),
                    ],
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator()),

      );
    });
  }
}
