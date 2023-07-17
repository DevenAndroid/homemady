import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/routers/routers.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/dimenestion.dart';

import '../controller/my_cart_controller.dart';
import '../controller/vendor_single_store_controller.dart';
import '../repository/add_cart_repo.dart';
import '../repository/remove_cartitem_repo.dart';
import '../repository/update_cart_repo.dart';
import '../resources/add_text.dart';

class carteScreen extends StatefulWidget {
  const carteScreen({Key? key}) : super(key: key);

  @override
  State<carteScreen> createState() => _carteScreenState();
}

class _carteScreenState extends State<carteScreen> {
  final controller = Get.put(VendorSingleStoreController());
  final cartListController = Get.put(MyCartListController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _decrement();
    _increment();
  }

  int count = 0;
  void _increment() {
    setState(() {
      count++;
    });
  }

  void _decrement() {
    setState(() {
      count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: controller.model.value.data!.latestProducts!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                  const Color(0xFF37C666).withOpacity(0.10),
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
                              print(
                                controller
                                    .model.value.data!.latestProducts![index].id
                                    .toString(),
                              );
                              Get.toNamed(MyRouters.myCartScreen);
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
                                        imageUrl: controller.model.value.data!
                                            .latestProducts![index].image
                                            .toString(),
                                        fit: BoxFit.cover,
                                        height: 80,
                                        width: 70,
                                        errorWidget: (_, __, ___) => Image.asset(
                                          'assets/images/Rectangle 23007.png',
                                        ),
                                        placeholder: (_, __) => Center(
                                            child: CircularProgressIndicator()),
                                      ),
                                    ),
                                    addWidth(10),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.model.value.data!
                                              .latestProducts![index].name
                                              .toString().replaceAll('homemady product test1284sdf', 'Test'),
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color: const Color(0xFF21283D)),maxLines: 2,
                                        ),
                                        addHeight(3),
                                        Text(
                                          controller.model.value.data!
                                              .latestProducts![index].size
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 11,
                                              color: const Color(0xFF364A4F)),
                                        ),
                                        addHeight(3),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'spiciness :',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 10,
                                                      color: const Color(
                                                          0xFF1F2D30)),
                                                ),
                                                addWidth(4),
                                                Text(
                                                  'Mildly Spicy',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 10,
                                                      color: const Color(
                                                          0xFF6CC844)),
                                                ),
                                              ],
                                            ),
                                            addWidth(10),
                                            Row(
                                              children: [
                                                Text(
                                                  'Allergens :',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 10,
                                                      color: const Color(
                                                          0xFF1F2D30)),
                                                ),
                                                addWidth(4),
                                                Text(
                                                  'Crustaceans',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 10,
                                                      color: const Color(
                                                          0xFF6CC844)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        addHeight(6),
                                        IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  /*if (buttonCount.value > 1) {
                                                      buttonCount.value--;
                                                    }*/
                                                  updateCartRepo(
                                                      cartListController
                                                          .model
                                                          .value
                                                          .data!
                                                          .cartItems![index]
                                                          .id
                                                          .toString(),
                                                      int.parse(controller
                                                          .model
                                                          .value
                                                          .data!
                                                          .latestProducts![
                                                      index]
                                                          .buttonCount
                                                          .value
                                                          .toString()),
                                                      context)
                                                      .then((value) {
                                                    if (value.status == true) {
                                                      controller
                                                          .model
                                                          .value
                                                          .data!
                                                          .latestProducts![
                                                      index]
                                                          .buttonCount
                                                          .value--;
                                                      showToast(value.message
                                                          .toString());
                                                      cartListController
                                                          .getData();
                                                      print(
                                                          "buttonCount ${controller.model.value.data!.latestProducts![index].qty.toString()}");
                                                    }
                                                    setState(() {

                                                    });
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xFF72CD4A)),
                                                      shape: BoxShape.circle),
                                                  alignment: Alignment.center,
                                                  child: const Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 3),
                                                    child: Text(
                                                      '-',
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontSize: 16,
                                                          color:
                                                          Color(0xFF72CD4A)),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Obx(() {
                                                return Container(
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 14.0, right: 14.0),
                                                    child: Text(
                                                      controller
                                                          .model
                                                          .value
                                                          .data!
                                                          .latestProducts![index]
                                                          .buttonCount
                                                          .value
                                                          .toString(),
                                                    ),
                                                  ),
                                                );
                                              }),
                                              InkWell(
                                                onTap: () {
                                                  // buttonCount.value++;
                                                    addToCartRepo(
                                                        product_id: controller
                                                            .model
                                                            .value
                                                            .data!
                                                            .latestProducts![
                                                        index]
                                                            .id
                                                            .toString(),
                                                        qty: controller
                                                            .model
                                                            .value
                                                            .data!
                                                            .latestProducts![
                                                        index]
                                                            .buttonCount
                                                            .value,
                                                        context: context)
                                                        .then((value1) {
                                                      if (value1.status == true) {
                                                        controller
                                                            .model
                                                            .value
                                                            .data!
                                                            .latestProducts![
                                                        index]
                                                            .value = true;
                                                        controller
                                                            .model
                                                            .value
                                                            .data!
                                                            .latestProducts![
                                                        index]
                                                            .buttonCount
                                                            .value++;
                                                        showToast(value1.message
                                                            .toString());
                                                        cartListController
                                                            .getData();
                                                      }
                                                    });
                                                  setState(() {

                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                      const Color(0xFF72CD4A),
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xFF72CD4A)),
                                                      shape: BoxShape.circle),
                                                  alignment: Alignment.center,
                                                  child: const Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                    child: Text(
                                                      '+',
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.w600,
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
                                    Text(
                                      'Can cook more units by: 30th June 2023',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 11,
                                          color: const Color(0xFF364A4F)),
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
                        Positioned(
                          top: 14,
                          right: 20,
                          child: Text(
                            '€ ${controller.model.value.data!.latestProducts![index].price.toString()}',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: const Color(0xFF70CC49)),
                          ),
                        )
                      ],
                    ),
                    addHeight(10)
                  ],
                );
              },
            ),
          ),
        ],
      );
    });
  }

}
