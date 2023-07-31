import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/app_theme.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:homemady/widgets/dimenestion.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/order_details_controller.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  final controller = Get.put(OrderDetailsController());
  @override
  void initState() {
    super.initState();
    controller.getData();
    // vendorOrderListController.filter.value = "";
    // vendorOrderListController.vendorOrderListData();
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
                                     Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text('Order ID: ${controller.model.value.data!.orderId!.toString()}',style: GoogleFonts.poppins(
                                             fontWeight: FontWeight.w600,
                                             fontSize: 15,
                                             color: Color(0xFF7ED957)
                                         ),),
                                         Text(controller.model.value.data!.placedAt!.toString(),style: GoogleFonts.poppins(
                                             fontWeight: FontWeight.w400,
                                             fontSize: 11,
                                             color: const Color(0xFF303C5E)
                                         ),),

                                       ],
                                     ),
                                     Spacer(),
                                     Container(
                                       // height: 25,
                                       // width: 100,
                                       decoration:  BoxDecoration(
                                           borderRadius: BorderRadius.circular(6),
                                           color: Color(0xFF7ED957)
                                       ),
                                       child: Center(
                                         child: Padding(
                                           padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                           child: Text('Successful',
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
                                 itemCount: controller.model.value.data!.orderItems!.length,
                                 physics: const BouncingScrollPhysics(),
                                 itemBuilder: (context, index) {
                                   return Column(
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 15),
                                         child: Row(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Image.asset('assets/images/Rectangle 39702.png',height: 75,),
                                             addWidth(15),
                                             Padding(
                                               padding: const EdgeInsets.symmetric(vertical: 5),
                                               child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 mainAxisAlignment: MainAxisAlignment.center,
                                                 children: [
                                                   Text(controller.model.value.data!.orderItems![index].productName.toString(),
                                                     style: GoogleFonts.poppins(
                                                         fontWeight: FontWeight.w600,
                                                         fontSize: 18,
                                                         color: const Color(0xFF1A2E33)
                                                     ),),
                                                   addHeight(1),
                                                   Text('Quantity: ${controller.model.value.data!.orderItems![index].qty.toString()}',
                                                     style: GoogleFonts.poppins(
                                                         fontWeight: FontWeight.w400,
                                                         fontSize: 12,
                                                         color: const Color(0xFF486769B5).withOpacity(0.71)
                                                     ),),
                                                   addHeight(3),
                                                   Text('€ ${controller.model.value.data!.orderItems![index].price.toString()}',
                                                     style: GoogleFonts.poppins(
                                                         fontWeight: FontWeight.w600,
                                                         fontSize: 16,
                                                         color: const Color(0xFF70CC49)
                                                     ),),
                                                 ],
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
                         ): Center(child: CircularProgressIndicator()),
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

                           child: controller.isDataLoading.value ? controller.model.value.data!.driver != null  ?
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
                                                       controller.model.value.data!.driver!.name.toString(),
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
                                                       controller.model.value.data!.driver!.phone.toString(),
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
                                                   _makingPhoneCall("tel:+916565656545");
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
                                                           controller.model.value.data!.address!.location.toString(),
                                                           style: const TextStyle(
                                                               height: 1.5,
                                                               fontWeight: FontWeight.w600,
                                                               fontSize: 16),
                                                         ),
                                                         SizedBox(
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
                                               Spacer(),
                                               Container(
                                                 height: 25,
                                                 width: 52,
                                                 decoration: BoxDecoration(
                                                   color: Color(0xFF7ED957),
                                                   borderRadius: BorderRadius.circular(4),
                                                 ),
                                                 child: Center(
                                                   child: Text(
                                                     controller.model.value.data!.orderType.toString(),
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
                                               Spacer(),
                                               Text( '€ ${controller.model.value.data!.itemTotal.toString()}',
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
                                                     color: Color(0xff1A2E33)
                                                 ),),
                                               Spacer(),
                                               Text( controller.model.value.data!.tax.toString(),
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 14,
                                                     fontWeight: FontWeight.w500,
                                                     color: Color(0xff486769)
                                                 ),),
                                             ],
                                           ),
                                           addHeight(10),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               Text('Delivery:',
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 16,
                                                     fontWeight: FontWeight.w600,
                                                     color: Color(0xff1A2E33)
                                                 ),),
                                               Spacer(),
                                               Text(  controller.model.value.data!.deliveryCharges.toString(),
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 14,
                                                     fontWeight: FontWeight.w500,
                                                     color: Color(0xff486769)
                                                 ),),
                                             ],
                                           ),
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
                                               Spacer(),
                                               Text( '€ ${controller.model.value.data!.grandTotal.toString()}',
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
                                 //           InkWell(
                                 //             onTap: () {
                                 //               Get.toNamed(MyRouters.reviewScreen);
                                 //             },
                                 //             child: Container(
                                 //               height: 56,
                                 //               width: AddSize.screenWidth / 1.1,
                                 //               decoration: BoxDecoration(
                                 //                   borderRadius: BorderRadius.circular(10),
                                 //                   border: Border.all(
                                 //                       color: const Color(0xFFFE724C), width: 2)),
                                 //               child: Center(
                                 //                 child: Text(
                                 //                   'Send Feedback For Driver',
                                 //                   style: GoogleFonts.poppins(
                                 //                     color: const Color(0xFFFE724C),
                                 //                     fontSize: 16,
                                 //                     fontWeight: FontWeight.w700,
                                 //                   ),
                                 //                   textAlign: TextAlign.center,
                                 //         ),
                                 //               ),
                                 //   ),
                                 // ),
                               ]
                           ) : Center(child: Text('NO Driver Information')): const Center(child: CircularProgressIndicator()),
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
                           child: controller.isDataLoading.value ? controller.model.value.data!.vendor != null ?
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
                                                     controller.model.value.data!.vendor!.storeName.toString(),
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
                                                       controller.model.value.data!.vendor!.phone.toString(),
                                                     style: const TextStyle(
                                                         height: 1.5,
                                                         fontWeight: FontWeight.w600,
                                                         fontSize: 16),
                                                   ),
                                                 ],
                                               ),
                                             ]),
                                             GestureDetector(
                                               onTap: () {},
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
                                                           controller.model.value.data!.vendor!.location.toString(),
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
                                               onTap: () {},
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
                                             Spacer(),
                                             Container(
                                               height: 25,
                                               width: 52,
                                               decoration: BoxDecoration(
                                                 color: Color(0xFF7ED957),
                                                 borderRadius: BorderRadius.circular(4),
                                               ),
                                               child: Center(
                                                 child: Text(
                                                   controller.model.value.data!.orderType.toString(),
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
                                             Spacer(),
                                             Text('€ ${controller.model.value.data!.itemTotal.toString()}',
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
                                                   color: Color(0xff1A2E33)
                                               ),),
                                             Spacer(),
                                             Text( '€ ${controller.model.value.data!.tax.toString()}',
                                               style: GoogleFonts.poppins(
                                                   fontSize: 14,
                                                   fontWeight: FontWeight.w500,
                                                   color: Color(0xff486769)
                                               ),),
                                           ],
                                         ),
                                         addHeight(10),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             Text('Packaging fee:',
                                               style: GoogleFonts.poppins(
                                                   fontSize: 16,
                                                   fontWeight: FontWeight.w600,
                                                   color: Color(0xff1A2E33)
                                               ),),
                                             Spacer(),
                                             Text( controller.model.value.data!.packingFee.toString(),
                                               style: GoogleFonts.poppins(
                                                   fontSize: 14,
                                                   fontWeight: FontWeight.w500,
                                                   color: Color(0xff486769)
                                               ),),
                                           ],
                                         ),
                                         addHeight(10),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             Text('Delivery:',
                                               style: GoogleFonts.poppins(
                                                   fontSize: 16,
                                                   fontWeight: FontWeight.w600,
                                                   color: Color(0xff1A2E33)
                                               ),),
                                             Spacer(),
                                             Text( controller.model.value.data!.deliveryCharges.toString(),
                                               style: GoogleFonts.poppins(
                                                   fontSize: 14,
                                                   fontWeight: FontWeight.w500,
                                                   color: Color(0xff486769)
                                               ),),
                                           ],
                                         ),
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
                                             Spacer(),
                                             Text('€ ${controller.model.value.data!.grandTotal.toString()}',
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
                               // InkWell(
                               //   onTap: () {
                               //     Get.toNamed(MyRouters.reviewScreen);
                               //   },
                               //   child: Container(
                               //     height: 56,
                               //     width: AddSize.screenWidth / 1.1,
                               //     decoration: BoxDecoration(
                               //         borderRadius: BorderRadius.circular(10),
                               //         color: const Color(0xFFFF6B6B)
                               //     ),
                               //     child: Center(
                               //       child: Text(
                               //         'Send Feedback For Order',
                               //         style: GoogleFonts.poppins(
                               //           color:  Colors.white,
                               //           fontSize: 16,
                               //           fontWeight: FontWeight.w700,
                               //         ),
                               //         textAlign: TextAlign.center,
                               //       ),
                               //     ),
                               //   ),
                               // ),
                               // SizedBox(height: AddSize.size20),
                             ],
                           ):  Center(child: Text('NO Vendor Information')) : const Center(child: CircularProgressIndicator()),
                         ),
                       );
                     })

                   ],
                 )
             ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: InkWell(
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
      ),



    );
  }
}
