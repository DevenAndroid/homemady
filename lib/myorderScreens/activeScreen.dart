import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/resources/add_text.dart';
import 'package:homemady/widgets/custome_size.dart';
import '../Screens/customer_order_tracking_screen.dart';
import '../Screens/orderDetailsScreen.dart';
import '../controller/my_order_controller.dart';
import '../controller/order_details_controller.dart';
import '../controller/order_tracking_controller.dart';
import '../repository/cancel_order_repo.dart';

class ActiveScreen extends StatefulWidget {
  const ActiveScreen({super.key});

  @override
  State<ActiveScreen> createState() => _ActiveScreenState();
}

class _ActiveScreenState extends State<ActiveScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getData();
    });
  }

  final controller = Get.put(MyOrderController());
  final orderDetailsController = Get.put(OrderDetailsController());
  final orderTrackingController = Get.put(OrderTrackingController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: controller.isDataLoading.value
              ? controller.model.value.data!.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.model.value.data!.length,
                      itemBuilder: (context, index) {
                        if (controller.model.value.data![index].deliveryStatus != 'Cancelled' &&
                                controller.model.value.data![index].deliveryStatus != 'Completed') {
                          return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // orderDetailsController.id.value = controller.model.value.data![index].orderId.toString();
                                      // Get.toNamed(MyRouters.orderDetailsScreen,arguments: [orderDetailsController.id.value]);
                                      Get.to(() => OrderDetailsScreen(
                                          storeID: controller.model.value.data![index].orderId.toString()));
                                    },
                                    child: controller.isDataLoading.value
                                        ? Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(12),
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
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(12.0),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(borderRadius: BorderRadius.circular(17)),
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(10),
                                                          child: CachedNetworkImage(
                                                            imageUrl: controller
                                                                .model.value.data![index].orderItems![0].productImage
                                                                .toString(),
                                                            fit: BoxFit.cover,
                                                            height: 76,
                                                            width: 76,
                                                            errorWidget: (_, __, ___) => Image.asset(
                                                              'assets/images/Rectangle 23007.png',
                                                              fit: BoxFit.cover,
                                                              height: 76,
                                                              width: 76,
                                                            ),
                                                            placeholder: (_, __) =>
                                                                const Center(child: CircularProgressIndicator()),
                                                          ),
                                                        ),
                                                        // CachedNetworkImage(
                                                        //   imageUrl: controller.isDataLoading.value ?
                                                        //   controller.model.value.data![index].image.toString():'',
                                                        // ),
                                                        // Image.asset('assets/images/Rectangle 39702.png',height: 76,width: 76,),
                                                      ),
                                                      addWidth(10),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Order Id #${(controller.model.value.data![index].orderId).toString().capitalizeFirst.toString()}',
                                                            style: GoogleFonts.poppins(
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 18,
                                                                color: const Color(0xFF1A2E33)),
                                                          ),
                                                          addHeight(3),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                '${controller.model.value.data![index].itemCount.toString()} items',
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize: 12,
                                                                    color: const Color(0xFF486769).withOpacity(0.70)),
                                                              ),
                                                              addWidth(10),
                                                              Container(
                                                                width: 1,
                                                                height: 10,
                                                                color: Colors.grey,
                                                              ),
                                                              addWidth(10),
                                                              Text(
                                                                '${controller.model.value.data![index].deliveryDistance.toString()} KM',
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize: 12,
                                                                    color: const Color(0xFF486769).withOpacity(0.70)),
                                                              ),
                                                            ],
                                                          ),
                                                          addHeight(5),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                '€ ${controller.model.value.data![index].grandTotal.toString()}',
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 16,
                                                                    color: const Color(0xFF70CC49)),
                                                              ),
                                                              addWidth(8),
                                                              Container(
                                                                // height: 25,
                                                                //width: 47,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(6),
                                                                    color: const Color(0xFF7ED957)),
                                                                child: Center(
                                                                  child: Padding(
                                                                      padding: const EdgeInsets.symmetric(
                                                                          vertical: 5, horizontal: 6),
                                                                      child:
                                                                          // controller.model.value.data![index].deliveryStatus == 'OP' ?
                                                                          Text(
                                                                        controller
                                                                            .model.value.data![index].deliveryStatus
                                                                            .toString(),
                                                                        style: GoogleFonts.poppins(
                                                                          color: const Color(0xFFFFFFFF),
                                                                          fontSize: 12,
                                                                          fontWeight: FontWeight.w400,
                                                                        ),
                                                                      )),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10),
                                                  child: Divider(
                                                    color: Color(0xFFE8E8E8),
                                                    thickness: 1.4,
                                                    height: 1,
                                                  ),
                                                ),
                                                addHeight(5),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          cancelOrderRepo(
                                                                  orderId: controller.model.value.data![index].orderId
                                                                      .toString(),
                                                                  context: context)
                                                              .then((value) {
                                                            if (value.status == true) {
                                                              showToast(value.message);
                                                              controller.getData();
                                                            }
                                                          });
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          height: 30,
                                                          width: 132,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(16),
                                                              border: Border.all(color: const Color(0xFF7ED957))),
                                                          child: Center(
                                                            child: Text(
                                                              'Cancel Order',
                                                              style: GoogleFonts.poppins(
                                                                color: const Color(0xFF7ED957),
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      addWidth(15),
                                                      controller.model.value.data![index].deliveryStatus == 'Accepted'
                                                          ? GestureDetector(
                                                              onTap: () {
                                                                // orderTrackingController.orderIdTracking.value = controller.model.value.data![index].orderId.toString();
                                                                // Get.toNamed(OrderTrackingScreen.orderTrackingScreen);
                                                                Get.to(() => OrderTrackingScreen(
                                                                      orderId: controller
                                                                          .model.value.data![index].orderId
                                                                          .toString(),
                                                                    ));
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(14),
                                                                    color: const Color(0xFF7ED957)),
                                                                child: Center(
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.symmetric(
                                                                        vertical: 5, horizontal: 20),
                                                                    child: Text(
                                                                      'Track Driver',
                                                                      style: GoogleFonts.poppins(
                                                                        color: const Color(0xFFFFFFFF),
                                                                        fontSize: 13,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                    ],
                                                  ),
                                                ),
                                                addHeight(18),
                                              ],
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(30.0),
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 60,
                                                ),
                                                Image.asset('assets/images/noOrderImage.png'),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Empty",
                                                  style: GoogleFonts.dmSans(
                                                      fontWeight: FontWeight.w700,
                                                      color: const Color(0xff000000),
                                                      fontSize: 22),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "You do not have an active order at this time",
                                                  style: GoogleFonts.dmSans(
                                                      fontWeight: FontWeight.w700,
                                                      color: const Color(0xff747474),
                                                      fontSize: 22),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ),
                                ],
                              );
                        } else {
                          return const SizedBox();
                        }
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          Image.asset('assets/images/noOrderImage.png'),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Empty",
                            style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w700, color: const Color(0xff000000), fontSize: 22),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "You do not have an active order of this time",
                            style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w700, color: const Color(0xff747474), fontSize: 22),
                          ),
                        ],
                      ),
                    )
              : const Center(child: CircularProgressIndicator()),
        ),
      );
    });
  }
}
