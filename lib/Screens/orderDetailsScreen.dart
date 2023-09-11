import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/app_theme.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:homemady/widgets/dimenestion.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/order_details_controller.dart';
import '../controller/user_profile_controller.dart';
import '../model/order_details_model.dart';
import '../service/firebase_service.dart';
import 'chat_screen/chat_screen.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  final controller = Get.put(OrderDetailsController());

  final profileController = Get.put(UserProfileController());
  @override
  void initState() {
    super.initState();
    controller.getData();
    tabController = TabController(length: 2, vsync: this);
  }
  _makingPhoneCall(call) async {
    var url = Uri.parse(call);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(title: 'Order Details', context: context),
      body:
              NestedScrollView(
               headerSliverBuilder: (_, __){
                 return [
                   Obx(() {
                     return SliverToBoxAdapter(
                       child: Padding(
                         padding: EdgeInsets.symmetric(
                             horizontal: AddSize.padding16, vertical: AddSize.padding10),
                         child: controller.isDataLoading.value ? Column(
                           children: [
                             addHeight(10),
                             Container(
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.circular(12),
                                 boxShadow: [
                                   BoxShadow(
                                     color: const Color(0xFF37C666).withOpacity(0.10),
                                     offset: const Offset(.1, .1,
                                     ),
                                     blurRadius: 20.0,
                                     spreadRadius: 1.0,
                                   ),
                                 ],
                               ),
                               child: Padding(
                                 padding: const EdgeInsets.all(18.0),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Image.asset('assets/images/order_details.png',height: 18,),
                                     addWidth(15),
                                     Expanded(
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text('Order ID: ${controller.model.value.orderDetail!.orderId!.toString()}'
                                             ,style: GoogleFonts.poppins(
                                               fontWeight: FontWeight.w600,
                                               fontSize: 15,
                                               color: const Color(0xFF7ED957)
                                           ),),
                                           Text(controller.model.value.orderDetail!.placedAt!.toString(),
                                             style: GoogleFonts.poppins(
                                               fontWeight: FontWeight.w400,
                                               fontSize: 11,
                                               color: const Color(0xFF303C5E)
                                           ),),
                                           addHeight(10),
                                           controller.model.value.orderDetail!.deliveryTime != null ?
                                           Text('Delivery Time'
                                             ,style: GoogleFonts.poppins(
                                                 fontWeight: FontWeight.w600,
                                                 fontSize: 14,
                                                 color: const Color(0xFF1A2E33)
                                             ),):const SizedBox(),
                                           controller.model.value.orderDetail!.deliveryTime != null ?
                                           Text(controller.model.value.orderDetail!.deliveryTime!.toString(),
                                             style: GoogleFonts.poppins(
                                                 fontWeight: FontWeight.w400,
                                                 fontSize: 11,
                                                 color: const Color(0xFF303C5E)
                                             ),): const SizedBox(),

                                           controller.model.value.orderDetail!.specialRequets != '' ?
                                           Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               const SizedBox(height: 3,),
                                               Text('Special Request'
                                                 ,style: GoogleFonts.poppins(
                                                     fontWeight: FontWeight.w600,
                                                     fontSize: 14,
                                                     color: const Color(0xFF1A2E33)
                                                 ),),
                                               Text(controller.model.value.orderDetail!.specialRequets!.toString().capitalizeFirst.toString(),
                                                 style: GoogleFonts.poppins(
                                                     fontWeight: FontWeight.w400,
                                                     fontSize: 11,
                                                     color: const Color(0xFF303C5E)
                                                 ),),
                                             ],
                                           ) : const SizedBox(),
                                           controller.model.value.orderDetail!.instructionForDelivery != "" ?
                                           Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Text('Instruction for delivery'
                                                 ,style: GoogleFonts.poppins(
                                                     fontWeight: FontWeight.w600,
                                                     fontSize: 14,
                                                     color: const Color(0xFF1A2E33)
                                                 ),),
                                               Text(controller.model.value.orderDetail!.instructionForDelivery!.toString().capitalizeFirst.toString(),
                                                 style: GoogleFonts.poppins(
                                                     fontWeight: FontWeight.w400,
                                                     fontSize: 11,
                                                     color: const Color(0xFF303C5E)
                                                 ),),
                                             ],
                                           ): const SizedBox(),
                                         ],
                                       ),
                                     ),
                                     // const Spacer(),
                                     Container(
                                       // height: 25,
                                       // width: 100,
                                       decoration:  BoxDecoration(
                                           borderRadius: BorderRadius.circular(6),
                                           color: const Color(0xFF7ED957)
                                       ),
                                       child: Center(
                                         child: Padding(
                                           padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                           child: Text(
                                             controller.model.value.orderDetail!.deliveryStatus!.toString(),
                                             style: GoogleFonts.poppins(
                                               color: const Color(0xFFFFFFFF),
                                               fontSize: 12,
                                               fontWeight: FontWeight.w500,
                                             ),
                                           ),
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                             addHeight(10),
                             Container(
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.circular(12),
                                 boxShadow: [
                                   BoxShadow(
                                     color: const Color(0xFF37C666).withOpacity(0.10),
                                     offset: const Offset(.1, .1,
                                     ),
                                     blurRadius: 20.0,
                                     spreadRadius: 1.0,
                                   ),
                                 ],
                               ),
                               child: ListView.builder(
                                 shrinkWrap: true,
                                 itemCount: controller.model.value.orderDetail!.orderItems!.length,
                                 physics: const BouncingScrollPhysics(),
                                 itemBuilder: (context, index) {
                                   return Column(
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 15),
                                         child: Row(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             ClipRRect(
                                               borderRadius: BorderRadius.circular(10),
                                               child:
                                               CachedNetworkImage(
                                                 imageUrl: controller.model.value.orderDetail!.orderItems![index].productImage.toString(),
                                                 fit: BoxFit.cover,
                                                 height: 80,
                                                 width: 75,
                                                 errorWidget: (_, __, ___) => Image.asset(
                                                   'assets/images/Rectangle 23007.png',
                                                   fit: BoxFit.cover,
                                                   height: 80,
                                                   width: 60,
                                                 ),
                                                 placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                                               ),
                                             ),
                                           // CachedNetworkImage(imageUrl: controller.model.value.orderDetail!.orderItems![index]..toString(),)
                                           //   Image.asset('assets/images/Rectangle 39702.png',height: 75,),
                                             addWidth(15),
                                             Expanded(
                                               child: Padding(
                                                 padding: const EdgeInsets.symmetric(vertical: 5),
                                                 child: Column(
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                   children: [
                                                     Text(controller.model.value.orderDetail!.orderItems![index].productName.toString().capitalizeFirst.toString(),
                                                       style: GoogleFonts.poppins(
                                                           fontWeight: FontWeight.w600,
                                                           fontSize: 18,
                                                           color: const Color(0xFF1A2E33)
                                                       ),),
                                                     addHeight(1),
                                                     Row(
                                                       children: [
                                                         Text('Quantity: ${controller.model.value.orderDetail!.orderItems![index].qty.toString()}',
                                                           style: GoogleFonts.poppins(
                                                               fontWeight: FontWeight.w400,
                                                               fontSize: 12,
                                                               color: const Color(0xFF486769B5).withOpacity(0.71)
                                                           ),),
                                                       ],
                                                     ),
                                                     Row(
                                                       children: [
                                                         Text('Size: ${controller.model.value.orderDetail!.orderItems![index].sizeQuantity.toString()}',
                                                           style: GoogleFonts.poppins(
                                                               fontWeight: FontWeight.w400,
                                                               fontSize: 12,
                                                               color: const Color(0xFF486769B5).withOpacity(0.71)
                                                           ),),
                                                         addWidth(3),
                                                         Text('${controller.model.value.orderDetail!.orderItems![index].sizeId.toString()}',
                                                           style: GoogleFonts.poppins(
                                                               fontWeight: FontWeight.w400,
                                                               fontSize: 12,
                                                               color: const Color(0xFF486769B5).withOpacity(0.71)
                                                           ),),
                                                       ],
                                                     ),
                                                     addHeight(3),
                                                     Text('€ ${controller.model.value.orderDetail!.orderItems![index].price.toString()}',
                                                       style: GoogleFonts.poppins(
                                                           fontWeight: FontWeight.w600,
                                                           fontSize: 16,
                                                           color: const Color(0xFF70CC49)
                                                       ),),
                                                   ],
                                                 ),
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),
                                       const Padding(
                                         padding:  EdgeInsets.symmetric(horizontal: 12,),
                                         child: Divider(
                                           color: Color(0xFFF2F2F2),
                                           height: 1,
                                           thickness: 1.2,
                                         ),
                                       ),


                                     ],
                                   );
                                 },),
                             ),
                             addHeight(10),
                             Card(
                                 elevation: 0,
                                 shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(0)),
                                 child: Padding(
                                   padding: EdgeInsets.symmetric(
                                       horizontal: AddSize.screenWidth * 0.02,
                                       vertical: AddSize.screenHeight * .005),
                                   child: TabBar(
                                     physics: const BouncingScrollPhysics(),
                                     tabs:  [
                                       Tab(
                                         child: Text(
                                           "Driver  Detail",
                                           textAlign: TextAlign.center,
                                           style:GoogleFonts.poppins(
                                               fontSize: 16,
                                               fontWeight: FontWeight.w500),
                                         ),
                                       ),
                                       Tab(
                                         child: Text(
                                           "Home Cook Detail",
                                           textAlign: TextAlign.center,
                                           style: GoogleFonts.poppins(
                                               fontSize: 16,
                                               fontWeight: FontWeight.w500),
                                         ),
                                       )
                                     ],
                                     // onTap: (value){
                                     //   tabController.index=value;
                                     // },
                                     unselectedLabelColor: const Color(0xFF909090),
                                     labelColor: const Color(0xFF1A2E33),
                                     labelStyle: const TextStyle(
                                         color: Color(0xFF1A2E33),
                                         fontSize: 16,
                                         fontWeight: FontWeight.w500),
                                     unselectedLabelStyle: const TextStyle(
                                         color: Color(0xFF909090),
                                         fontSize: 16,
                                         fontWeight: FontWeight.w500),
                                     controller: tabController,
                                     indicatorSize: TabBarIndicatorSize.tab,
                                     indicator: const BoxDecoration(
                                         border: Border(
                                             bottom: BorderSide(color: Color(0xFF7ED957),width: 5)
                                         )
                                     ),
                                   ),
                                 )),
                           ],
                         ):const SizedBox(),
                       ),
                     );
                   })
                 ];
               },
               body:
                  TabBarView(
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

                           child: controller.isDataLoading.value ? controller.model.value.orderDetail!.driver != null  ?
                           Column(
                               children: [
                                 Container(
                                   decoration: BoxDecoration(
                                     color: Colors.white,
                                     borderRadius: BorderRadius.circular(12),
                                     boxShadow: [
                                       BoxShadow(
                                         color: const Color(0xFF37C666).withOpacity(0.10),
                                         offset: const Offset(.1, .1,
                                         ),
                                         blurRadius: 20.0,
                                         spreadRadius: 1.0,
                                       ),
                                     ],
                                   ),
                                   child: Padding(
                                     padding: EdgeInsets.symmetric(
                                         horizontal: AddSize.padding15,
                                         vertical: AddSize.padding15),
                                     child: Column(
                                       children: [
                                         ...[
                                           Row(
                                             mainAxisAlignment:
                                             MainAxisAlignment.spaceBetween,
                                             children: [
                                               Row(children: [
                                                 Column(
                                                   crossAxisAlignment:
                                                   CrossAxisAlignment.start,
                                                   children: [
                                                     const Text(
                                                       "Driver Name",
                                                       style: TextStyle(
                                                           color: Color(0xff486769),
                                                           fontWeight: FontWeight.w300,
                                                           fontSize: 14),
                                                     ),
                                                     Text(
                                                       controller.model.value.orderDetail!.driver!.name.toString(),
                                                       style: const TextStyle(
                                                           height: 1.5,
                                                           fontWeight: FontWeight.w600,
                                                           fontSize: 16),
                                                     ),
                                                   ],
                                                 ),
                                               ]),
                                               Container(
                                                 height: AddSize.size45,
                                                 width: AddSize.size45,
                                                 decoration: const ShapeDecoration(
                                                     color: Color(0xFFFE7E73),
                                                     shape: CircleBorder()),
                                                 child: const Center(
                                                     child: Icon(
                                                       Icons.person_rounded,
                                                       color: AppTheme.backgroundcolor,
                                                     )),
                                               ),
                                             ],
                                           ),
                                           const Divider(),
                                           Row(
                                             mainAxisAlignment:
                                             MainAxisAlignment.spaceBetween,
                                             children: [
                                               Row(children: [
                                                 Column(
                                                   crossAxisAlignment:
                                                   CrossAxisAlignment.start,
                                                   children: [
                                                     const Text(
                                                       "Driver Number",
                                                       style: TextStyle(
                                                           color: Color(0xff486769),
                                                           fontWeight: FontWeight.w300,
                                                           fontSize: 14),
                                                     ),
                                                     Text(
                                                       controller.model.value.orderDetail!.driver!.phone.toString(),
                                                       style: const TextStyle(
                                                           height: 1.5,
                                                           fontWeight: FontWeight.w600,
                                                           fontSize: 16),
                                                     ),
                                                   ],
                                                 ),
                                               ]),
                                               GestureDetector(
                                                 onTap: () {
                                                   _makingPhoneCall("tel:+91${controller.model.value.orderDetail!.driver!.phone.toString()}");
                                                 },
                                                 child: Container(
                                                     height: AddSize.size45,
                                                     width: AddSize.size45,
                                                     decoration: const ShapeDecoration(
                                                         color: Color(0xFF71E189),
                                                         shape: CircleBorder()),
                                                     child: const Center(
                                                         child: Icon(
                                                           Icons.phone,
                                                           color: AppTheme.backgroundcolor,
                                                         ))),
                                               ),
                                             ],
                                           ),
                                           const Divider(),
                                           Row(
                                             mainAxisAlignment:
                                             MainAxisAlignment.spaceBetween,
                                             children: [
                                               Expanded(
                                                 child: Row(children: [
                                                   Expanded(
                                                     child: Column(
                                                       crossAxisAlignment:
                                                       CrossAxisAlignment.start,
                                                       children:  [
                                                         const Text(
                                                           "Delivery Address",
                                                           style: TextStyle(
                                                               color: Color(0xff486769),
                                                               fontWeight: FontWeight.w300,
                                                               fontSize: 14),
                                                         ),
                                                         Text(
                                                           controller.model.value.orderDetail!.address!.location.toString(),
                                                           style: const TextStyle(
                                                               height: 1.5,
                                                               fontWeight: FontWeight.w600,
                                                               fontSize: 16),
                                                         ),
                                                         const SizedBox(
                                                           width: 5,
                                                         ),
                                                       ],
                                                     ),
                                                   ),
                                                 ]),
                                               ),
                                               GestureDetector(
                                                 onTap: () {
                                                   Get.toNamed(MyRouters.chooseAddress);
                                                 },
                                                 child: Container(
                                                   height: AddSize.size45,
                                                   width: AddSize.size45,
                                                   decoration: const ShapeDecoration(
                                                       color: Color(0xFF7ED957),
                                                       shape: CircleBorder()),
                                                   child: const Center(
                                                       child: Icon(
                                                         Icons.location_on,
                                                         color: AppTheme.backgroundcolor,
                                                       )),
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ]
                                       ],
                                     ),
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.only(top:15),
                                   child: Container(
                                     decoration: BoxDecoration(
                                       color: Colors.white,
                                       borderRadius: BorderRadius.circular(12),
                                       boxShadow: [
                                         BoxShadow(
                                           color: const Color(0xFF37C666).withOpacity(0.10),
                                           offset: const Offset(.1, .1,
                                           ),
                                           blurRadius: 20.0,
                                           spreadRadius: 1.0,
                                         ),
                                       ],
                                     ),
                                     child: Padding(
                                       padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               Text('Payment:',
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 16,
                                                     fontWeight: FontWeight.w600,
                                                     color: const Color(0xff1A2E33)
                                                 ),),
                                               const Spacer(),
                                               Container(
                                                 height: 25,
                                                 width: 52,
                                                 decoration: BoxDecoration(
                                                   color: const Color(0xFF7ED957),
                                                   borderRadius: BorderRadius.circular(4),
                                                 ),
                                                 child: Center(
                                                   child: Text(
                                                     controller.model.value.orderDetail!.orderType.toString(),
                                                     style: GoogleFonts.poppins(
                                                         color: Colors.white,
                                                         fontSize: 13,
                                                         fontWeight: FontWeight.w500),
                                                   ),
                                                 ),
                                               )
                                             ],
                                           ),
                                           addHeight(10),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               Text('Subtotal:',
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 16,
                                                     fontWeight: FontWeight.w600,
                                                     color: const Color(0xff1A2E33)
                                                 ),),
                                               const Spacer(),
                                               Text( '€ ${controller.model.value.orderDetail!.itemTotal.toString()}',
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 14,
                                                     fontWeight: FontWeight.w500,
                                                     color: const Color(0xff486769)
                                                 ),),
                                             ],
                                           ),
                                           addHeight(10),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               Text('Small Order Fee:',
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 16,
                                                     fontWeight: FontWeight.w600,
                                                     color: const Color(0xff1A2E33)
                                                 ),),
                                               const Spacer(),
                                               Text( "€ ${controller.model.value.orderDetail!.minOrderCharge.toString()}",
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 14,
                                                     fontWeight: FontWeight.w500,
                                                     color: const Color(0xff486769)
                                                 ),),
                                             ],
                                           ),
                                           addHeight(10),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               Text('Service charge:',
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 16,
                                                     fontWeight: FontWeight.w600,
                                                     color: const Color(0xff1A2E33)
                                                 ),),
                                               const Spacer(),
                                               Text( "€ ${controller.model.value.orderDetail!.serviceCharge.toString()}",
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 14,
                                                     fontWeight: FontWeight.w500,
                                                     color: const Color(0xff486769)
                                                 ),),
                                             ],
                                           ),
                                           addHeight(10),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               Text('Small Order Fee:',
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 16,
                                                     fontWeight: FontWeight.w600,
                                                     color: const Color(0xff1A2E33)
                                                 ),),
                                               const Spacer(),
                                               Text( "€ ${controller.model.value.orderDetail!.minOrderCharge.toString()}",
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 14,
                                                     fontWeight: FontWeight.w500,
                                                     color: const Color(0xff486769)
                                                 ),),
                                             ],
                                           ),
                                           addHeight(10),
                                           controller.model.value.orderDetail!.deliveryCharges != 0 ?
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               Text('Delivery:',
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 16,
                                                     fontWeight: FontWeight.w600,
                                                     color: const Color(0xff1A2E33)
                                                 ),),
                                               const Spacer(),
                                               Text(  "€ ${controller.model.value.orderDetail!.deliveryCharges.toString()}",
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 14,
                                                     fontWeight: FontWeight.w500,
                                                     color: const Color(0xff486769)
                                                 ),),
                                             ],
                                           ):const SizedBox(),
                                           addHeight(10),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               Text('Total:',
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 15,
                                                     fontWeight: FontWeight.w700,
                                                     color: const Color(0xff6BC744)
                                                 ),),
                                               const Spacer(),
                                               Text( '€ ${controller.model.value.orderDetail!.grandTotal.toString()}',
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 14,
                                                     fontWeight: FontWeight.w500,
                                                     color: const Color(0xff6BC744)
                                                 ),),
                                             ],
                                           ),
                                           addHeight(20)
                                         ],

                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(height: AddSize.size20),
                                 InkWell(
                                   onTap: () {
                                     Get.toNamed(MyRouters.reviewScreen);
                                   },
                                   child: Container(
                                     height: 56,
                                     width: AddSize.screenWidth / 1.1,
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(10),
                                         color: const Color(0xFFFF6B6B)
                                     ),
                                     child: Center(
                                       child: Text(
                                         'Send Feedback For Order',
                                         style: GoogleFonts.poppins(
                                           color:  Colors.white,
                                           fontSize: 16,
                                           fontWeight: FontWeight.w700,
                                         ),
                                         textAlign: TextAlign.center,
                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(height: AddSize.size20),

                               ]
                           ) : Padding(
                             padding: const EdgeInsets.all(5.0),
                             child: Column(
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.only(top:15),
                                   child: Container(
                                     decoration: BoxDecoration(
                                       color: Colors.white,
                                       borderRadius: BorderRadius.circular(12),
                                       boxShadow: [
                                         BoxShadow(
                                           color: const Color(0xFF37C666).withOpacity(0.10),
                                           offset: const Offset(.1, .1,
                                           ),
                                           blurRadius: 20.0,
                                           spreadRadius: 1.0,
                                         ),
                                       ],
                                     ),
                                     child: Padding(
                                       padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               Text('Payment:',
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 16,
                                                     fontWeight: FontWeight.w600,
                                                     color: const Color(0xff1A2E33)
                                                 ),),
                                               const Spacer(),
                                               Container(
                                                 height: 25,
                                                 width: 52,
                                                 decoration: BoxDecoration(
                                                   color: const Color(0xFF7ED957),
                                                   borderRadius: BorderRadius.circular(4),
                                                 ),
                                                 child: Center(
                                                   child: Text(
                                                     controller.model.value.orderDetail!.orderType.toString(),
                                                     style: GoogleFonts.poppins(
                                                         color: Colors.white,
                                                         fontSize: 13,
                                                         fontWeight: FontWeight.w500),
                                                   ),
                                                 ),
                                               )
                                             ],
                                           ),
                                           addHeight(10),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               Text('Subtotal:',
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 16,
                                                     fontWeight: FontWeight.w600,
                                                     color: const Color(0xff1A2E33)
                                                 ),),
                                               const Spacer(),
                                               Text( '€ ${controller.model.value.orderDetail!.itemTotal.toString()}',
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 14,
                                                     fontWeight: FontWeight.w500,
                                                     color: const Color(0xff486769)
                                                 ),),
                                             ],
                                           ),
                                           addHeight(10),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               Text('Small Order Fee:',
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 16,
                                                     fontWeight: FontWeight.w600,
                                                     color: const Color(0xff1A2E33)
                                                 ),),
                                               const Spacer(),
                                               Text( "€ ${controller.model.value.orderDetail!.minOrderCharge.toString()}",
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 14,
                                                     fontWeight: FontWeight.w500,
                                                     color: const Color(0xff486769)
                                                 ),),
                                             ],
                                           ),
                                           addHeight(10),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               Text('Service charge:',
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 16,
                                                     fontWeight: FontWeight.w600,
                                                     color: const Color(0xff1A2E33)
                                                 ),),
                                               const Spacer(),
                                               Text( "€ ${controller.model.value.orderDetail!.serviceCharge.toString()}",
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 14,
                                                     fontWeight: FontWeight.w500,
                                                     color: const Color(0xff486769)
                                                 ),),
                                             ],
                                           ),
                                           addHeight(10),
                                           controller.model.value.orderDetail!.deliveryCharges != 0 ?
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               Text('Delivery:',
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 16,
                                                     fontWeight: FontWeight.w600,
                                                     color: const Color(0xff1A2E33)
                                                 ),),
                                               const Spacer(),
                                               Text(  "€ ${controller.model.value.orderDetail!.deliveryCharges.toString()}",
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 14,
                                                     fontWeight: FontWeight.w500,
                                                     color: const Color(0xff486769)
                                                 ),),
                                             ],
                                           ):const SizedBox(),
                                           addHeight(10),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               Text('Total:',
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 15,
                                                     fontWeight: FontWeight.w700,
                                                     color: const Color(0xff6BC744)
                                                 ),),
                                               const Spacer(),
                                               Text( '€ ${controller.model.value.orderDetail!.grandTotal.toString()}',
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 14,
                                                     fontWeight: FontWeight.w500,
                                                     color: const Color(0xff6BC744)
                                                 ),),
                                             ],
                                           ),
                                           addHeight(20)
                                         ],

                                       ),
                                     ),
                                   ),
                                 ),
                                 Row(mainAxisAlignment: MainAxisAlignment.end,
                                   children: [
                                     TextButton(onPressed: () {
                                       OrderDetail gg = controller.model.value.orderDetail!;
                                       log(jsonEncode(controller.model.value.orderDetail));
                                       gg.user = User.fromJson(profileController.model.value.data!.toJson());
                                       gg.vendorID = gg.vendor!.id.toString();
                                       String roomId = FirebaseService().createChatRoom(
                                           user1: gg.user!.id!
                                               .toString()
                                               .convertToNum
                                               .toInt(),
                                           user2: gg.vendor!.id!
                                               .toString()
                                               .convertToNum
                                               .toInt());
                                       Get.to(()=> const ChatScreen1(), arguments: [
                                         roomId,
                                         controller.model.value.orderDetail!.user!.id!
                                             .toString()
                                             .convertToNum
                                             .toInt()
                                             .toString(),
                                         gg
                                       ]);
                                     },
                                         child: const Text('Need any help?',style: TextStyle())),
                                   ],
                                 ),
                               ],
                             ),
                           ) :const Center(child: CircularProgressIndicator()),
                         ),
                       );
                     }),



                     Obx(() {
                       return  SingleChildScrollView(
                         physics: const BouncingScrollPhysics(),
                         child: Padding(
                           padding: EdgeInsets.symmetric(
                             horizontal: AddSize.padding16,
                           ),
                           child: controller.isDataLoading.value ? controller.model.value.orderDetail!.vendor != null ?
                           Column(
                             children: [
                               Container(
                                 decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.circular(12),
                                   boxShadow: [
                                     BoxShadow(
                                       color: const Color(0xFF37C666).withOpacity(0.10),
                                       offset: const Offset(.1, .1,
                                       ),
                                       blurRadius: 20.0,
                                       spreadRadius: 1.0,
                                     ),
                                   ],
                                 ),
                                 child: Padding(
                                   padding: EdgeInsets.symmetric(
                                       horizontal: AddSize.padding15,
                                       vertical: AddSize.padding15),
                                   child: Column(
                                     children: [
                                       ...[
                                         Row(
                                           mainAxisAlignment:
                                           MainAxisAlignment.spaceBetween,
                                           children: [
                                             Row(children: [
                                               Column(
                                                 crossAxisAlignment:
                                                 CrossAxisAlignment.start,
                                                 children:  [
                                                   const Text(
                                                     "Home Name",
                                                     style: TextStyle(
                                                         color: Color(0xff486769),
                                                         fontWeight: FontWeight.w300,
                                                         fontSize: 14),
                                                   ),
                                                   Text(
                                                     controller.model.value.orderDetail!.vendor!.storeName.toString().capitalizeFirst.toString(),
                                                     style: const TextStyle(
                                                         height: 1.5,
                                                         fontWeight: FontWeight.w600,
                                                         fontSize: 16),
                                                   ),
                                                 ],
                                               ),
                                             ]),
                                             Container(
                                               height: AddSize.size45,
                                               width: AddSize.size45,
                                               decoration: const ShapeDecoration(
                                                   color: Color(0xFFFE7E73),
                                                   shape: CircleBorder()),
                                               child: const Center(
                                                   child: Icon(
                                                     Icons.person_rounded,
                                                     color: AppTheme.backgroundcolor,
                                                   )),
                                             ),
                                           ],
                                         ),
                                         const Divider(),
                                         Row(
                                           mainAxisAlignment:
                                           MainAxisAlignment.spaceBetween,
                                           children: [
                                             Row(children: [
                                               Column(
                                                 crossAxisAlignment:
                                                 CrossAxisAlignment.start,
                                                 children:  [
                                                   const Text(
                                                     "Home Number",
                                                     style: TextStyle(
                                                         color: Color(0xff486769),
                                                         fontWeight: FontWeight.w300,
                                                         fontSize: 14),
                                                   ),
                                                   Text(
                                                       controller.model.value.orderDetail!.vendor!.phone.toString(),
                                                     style: const TextStyle(
                                                         height: 1.5,
                                                         fontWeight: FontWeight.w600,
                                                         fontSize: 16),
                                                   ),
                                                 ],
                                               ),
                                             ]),
                                             GestureDetector(
                                               onTap: () {
                                                 _makingPhoneCall("tel:+91 ${controller.model.value.orderDetail!.vendor!.phone.toString()}");
                                               },
                                               child: Container(
                                                   height: AddSize.size45,
                                                   width: AddSize.size45,
                                                   decoration: const ShapeDecoration(
                                                       color: Color(0xFF71E189),
                                                       shape: CircleBorder()),
                                                   child: const Center(
                                                       child: Icon(
                                                         Icons.phone,
                                                         color: AppTheme.backgroundcolor,
                                                       ))),
                                             ),
                                           ],
                                         ),
                                         const Divider(),
                                         Row(
                                           mainAxisAlignment:
                                           MainAxisAlignment.spaceBetween,
                                           children: [
                                             Expanded(
                                               child: Row(children: [
                                                 Expanded(
                                                   child: Column(
                                                     crossAxisAlignment:
                                                     CrossAxisAlignment.start,
                                                     children:   [
                                                       const Text(
                                                         "Home Address",
                                                         style: TextStyle(
                                                             color: Color(0xff486769),
                                                             fontWeight: FontWeight.w300,
                                                             fontSize: 14),
                                                       ),
                                                       Text(
                                                           controller.model.value.orderDetail!.vendor!.location.toString(),
                                                         style: const TextStyle(
                                                             height: 1.5,
                                                             fontWeight: FontWeight.w600,
                                                             fontSize: 16),
                                                       ),
                                                       const SizedBox(
                                                         width: 5,
                                                       ),
                                                     ],
                                                   ),
                                                 ),
                                               ]),
                                             ),
                                             GestureDetector(
                                               onTap: () {
                                                 openMap(double.parse(controller.model.value.orderDetail!.vendor!.latitude.toString()),
                                                     double.parse(controller.model.value.orderDetail!.vendor!.longitude.toString()));
                                               },
                                               child: Container(
                                                 height: AddSize.size45,
                                                 width: AddSize.size45,
                                                 decoration: const ShapeDecoration(
                                                     color: Color(0xFF7ED957),
                                                     shape: CircleBorder()),
                                                 child: const Center(
                                                     child: Icon(
                                                       Icons.location_on,
                                                       color: AppTheme.backgroundcolor,
                                                     )),
                                               ),
                                             ),
                                           ],
                                         ),
                                       ]
                                     ],
                                   ),
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(top:15),
                                 child: Container(
                                   decoration: BoxDecoration(
                                     color: Colors.white,
                                     borderRadius: BorderRadius.circular(12),
                                     boxShadow: [
                                       BoxShadow(
                                         color: const Color(0xFF37C666).withOpacity(0.10),
                                         offset: const Offset(.1, .1,
                                         ),
                                         blurRadius: 20.0,
                                         spreadRadius: 1.0,
                                       ),
                                     ],
                                   ),
                                   child: Padding(
                                     padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             Text('Payment:',
                                               style: GoogleFonts.poppins(
                                                   fontSize: 16,
                                                   fontWeight: FontWeight.w600,
                                                   color: const Color(0xff1A2E33)
                                               ),),
                                             const Spacer(),
                                             Container(
                                               height: 25,
                                               width: 52,
                                               decoration: BoxDecoration(
                                                 color: const Color(0xFF7ED957),
                                                 borderRadius: BorderRadius.circular(4),
                                               ),
                                               child: Center(
                                                 child: Text(
                                                   controller.model.value.orderDetail!.orderType.toString(),
                                                   style: GoogleFonts.poppins(
                                                       color: Colors.white,
                                                       fontSize: 13,
                                                       fontWeight: FontWeight.w500),
                                                 ),
                                               ),
                                             )
                                           ],
                                         ),
                                         addHeight(10),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             Text('Subtotal:',
                                               style: GoogleFonts.poppins(
                                                   fontSize: 16,
                                                   fontWeight: FontWeight.w600,
                                                   color: const Color(0xff1A2E33)
                                               ),),
                                             const Spacer(),
                                             Text( '€ ${controller.model.value.orderDetail!.itemTotal.toString()}',
                                               style: GoogleFonts.poppins(
                                                   fontSize: 14,
                                                   fontWeight: FontWeight.w500,
                                                   color: const Color(0xff486769)
                                               ),),
                                           ],
                                         ),
                                         addHeight(10),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             Text('Small Order Fee:',
                                               style: GoogleFonts.poppins(
                                                   fontSize: 16,
                                                   fontWeight: FontWeight.w600,
                                                   color: const Color(0xff1A2E33)
                                               ),),
                                             const Spacer(),
                                             Text( "€ ${controller.model.value.orderDetail!.minOrderCharge.toString()}",
                                               style: GoogleFonts.poppins(
                                                   fontSize: 14,
                                                   fontWeight: FontWeight.w500,
                                                   color: const Color(0xff486769)
                                               ),),
                                           ],
                                         ),
                                         addHeight(10),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             Text('Service charge:',
                                               style: GoogleFonts.poppins(
                                                   fontSize: 16,
                                                   fontWeight: FontWeight.w600,
                                                   color: const Color(0xff1A2E33)
                                               ),),
                                             const Spacer(),
                                             Text( "€ ${controller.model.value.orderDetail!.serviceCharge.toString()}",
                                               style: GoogleFonts.poppins(
                                                   fontSize: 14,
                                                   fontWeight: FontWeight.w500,
                                                   color: const Color(0xff486769)
                                               ),),
                                           ],
                                         ),

                                         addHeight(10),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             Text('Small Order Fee:',
                                               style: GoogleFonts.poppins(
                                                   fontSize: 16,
                                                   fontWeight: FontWeight.w600,
                                                   color: const Color(0xff1A2E33)
                                               ),),
                                             const Spacer(),
                                             Text( "€ ${controller.model.value.orderDetail!.minOrderCharge.toString()}",
                                               style: GoogleFonts.poppins(
                                                   fontSize: 14,
                                                   fontWeight: FontWeight.w500,
                                                   color: const Color(0xff486769)
                                               ),),
                                           ],
                                         ),
                                         addHeight(10),
                                         controller.model.value.orderDetail!.deliveryCharges != 0 ?
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             Text('Delivery:',
                                               style: GoogleFonts.poppins(
                                                   fontSize: 16,
                                                   fontWeight: FontWeight.w600,
                                                   color: const Color(0xff1A2E33)
                                               ),),
                                             const Spacer(),
                                             Text(  "€ ${controller.model.value.orderDetail!.deliveryCharges.toString()}",
                                               style: GoogleFonts.poppins(
                                                   fontSize: 14,
                                                   fontWeight: FontWeight.w500,
                                                   color: const Color(0xff486769)
                                               ),),
                                           ],
                                         ):const SizedBox(),
                                         addHeight(10),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             Text('Total:',
                                               style: GoogleFonts.poppins(
                                                   fontSize: 15,
                                                   fontWeight: FontWeight.w700,
                                                   color: const Color(0xff6BC744)
                                               ),),
                                             const Spacer(),
                                             Text( '€ ${controller.model.value.orderDetail!.grandTotal.toString()}',
                                               style: GoogleFonts.poppins(
                                                   fontSize: 14,
                                                   fontWeight: FontWeight.w500,
                                                   color: const Color(0xff6BC744)
                                               ),),
                                           ],
                                         ),
                                         addHeight(20)
                                       ],

                                     ),
                                   ),
                                 ),
                               ),


                               Row(mainAxisAlignment: MainAxisAlignment.end,
                                 children: [
                                   TextButton(onPressed: () {
                                     OrderDetail gg = controller.model.value.orderDetail!;
                                     log(jsonEncode(controller.model.value.orderDetail));
                                     gg.user = User.fromJson(profileController.model.value.data!.toJson());
                                     gg.vendorID = gg.vendor!.id.toString();
                                     String roomId = FirebaseService().createChatRoom(
                                         user1: gg.user!.id!
                                             .toString()
                                             .convertToNum
                                             .toInt(),
                                         user2: gg.vendor!.id!
                                             .toString()
                                             .convertToNum
                                             .toInt());
                                     Get.to(()=> const ChatScreen1(), arguments: [
                                       roomId,
                                       controller.model.value.orderDetail!.user!.id!
                                           .toString()
                                           .convertToNum
                                           .toInt()
                                           .toString(),
                                       gg
                                     ]);
                                   },
                                       child: const Text('Need any help?',style: TextStyle())),
                                 ],
                               ),


                               SizedBox(height: AddSize.size20),
                             ],
                           ):  const Center(child: Text('NO Vendor Information')) : const Center(child: CircularProgressIndicator()),
                         ),
                       );
                     })
                   ],
                 )
             ),

      bottomNavigationBar:
      Obx((){
        return controller.model.value.orderDetail != null ? controller.model.value.orderDetail!.feedback == false ?
        InkWell(
          onTap: () {
            Get.toNamed(MyRouters.reviewScreen);
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 56,
              width: AddSize.screenWidth / 1.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFFF6B6B)
              ),
              child: Center(
                child:

                Text(
                  'Send Feedback For Order',
                  style: GoogleFonts.poppins(
                    color:  Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ): const SizedBox():const SizedBox();
      }),



    );
  }
}
