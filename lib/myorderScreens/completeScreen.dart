import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/resources/add_text.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';

import '../Screens/mycart_Screen.dart';
import '../Screens/orderDetailsScreen.dart';
import '../Screens/review_screen.dart';
import '../controller/my_order_controller.dart';
import '../controller/order_details_controller.dart';
import '../repository/my_cart_repo.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({super.key});

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  final controller = Get.put(MyOrderController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getData();
    });
  }

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
                        return Column(
                          children: [
                            if (controller.model.value.data![index].deliveryStatus == 'Completed')
                              GestureDetector(
                                onTap: () {
                                  // orderDetailsController.id.value = controller.model.value.data![index].orderId.toString();
                                  // Get.toNamed(MyRouters.orderDetailsScreen,arguments: [orderDetailsController.id.value]);
                                  Get.to(() => OrderDetailsScreen(
                                        storeID: controller.model.value.data![index].orderId.toString(),
                                      ));
                                },
                                child: Container(
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
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(17)),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: CachedNetworkImage(
                                                  imageUrl: controller.model.value.data![index].orderItems![0].productImage.toString(),
                                                  fit: BoxFit.cover,
                                                  height: 76,
                                                  width: 76,
                                                  errorWidget: (_, __, ___) => Image.asset(
                                                    'assets/images/Rectangle 23007.png',
                                                    fit: BoxFit.cover,
                                                    height: 76,
                                                    width: 76,
                                                  ),
                                                  placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                                                ),
                                              ),
                                            ),
                                            addWidth(10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  (controller.isDataLoading.value
                                                          ? controller.model.value.data![index].orderItems![0].productName ?? 'Test'
                                                          : '')
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600, fontSize: 18, color: const Color(0xFF1A2E33)),
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
                                                      '1.5km',
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
                                                          fontWeight: FontWeight.w600, fontSize: 16, color: const Color(0xFF70CC49)),
                                                    ),
                                                    addWidth(8),
                                                    Container(
                                                      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                                                      // height: 25,
                                                      // width: 80,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(6), color: const Color(0xFF7ED957)),
                                                      child: Center(
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                                          child: Text(
                                                            controller.model.value.data![index].deliveryStatus.toString(),
                                                            style: GoogleFonts.poppins(
                                                              color: const Color(0xFFFFFFFF),
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                        ),
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
                                      addHeight(10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                // Get.toNamed(MyRouters.reviewScreen);
                                                Get.to(() => ReviewScreen(
                                                      orderId: controller.model.value.data![index].orderId.toString(),
                                                    ));
                                              },
                                              child: Container(
                                                // height: 30,
                                                // width: 132,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(16),
                                                    border: Border.all(color: const Color(0xFF7ED957))),
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                                                    child: Text(
                                                      'Leave a review',
                                                      style: GoogleFonts.poppins(
                                                        color: const Color(0xFF7ED957),
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            addWidth(15),
                                            GestureDetector(
                                              onTap: () {
                                                reOrderRepo(
                                                        context: context, id: controller.model.value.data![index].orderId.toString())
                                                    .then((value) {
                                                  if (value.status == true) {
                                                    showToast(value.message);
                                                    Get.to(() => const MyCartScreen());
                                                  } else {
                                                    showToast(value.message);
                                                  }
                                                });
                                              },
                                              child: Container(
                                                // height: 30,
                                                // width: 132,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(14), color: const Color(0xFF7ED957)),
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                    child: Text(
                                                      'Order Again',
                                                      style: GoogleFonts.poppins(
                                                        color: const Color(0xFFFFFFFF),
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      addHeight(15),
                                    ],
                                  ),
                                ),
                              )
                            else
                              index == 0 &&
                                      !controller.model.value.data!
                                          .map((element) => element.deliveryStatus == 'Completed')
                                          .toList()
                                          .contains(true)
                                  ? Padding(
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
                                            "You do not have an active order at this time",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.dmSans(
                                                fontWeight: FontWeight.w700, color: const Color(0xff747474), fontSize: 22),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox()
                          ],
                        );
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
                            style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, color: const Color(0xff000000), fontSize: 22),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "You do not have an active order at this time",
                            style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, color: const Color(0xff747474), fontSize: 22),
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
