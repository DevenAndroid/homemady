import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/widgets/custome_size.dart';

import '../controller/my_order_controller.dart';

class CancelledScreen extends StatefulWidget {
  const CancelledScreen({Key? key}) : super(key: key);

  @override
  State<CancelledScreen> createState() => _CancelledScreenState();
}

class _CancelledScreenState extends State<CancelledScreen> {
  final controller = Get.put(MyOrderController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      controller.getData();
      // Add Your Code here.

    });
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: controller.isDataLoading.value ? controller.model.value.data!.isNotEmpty ?
          ListView.builder(
            shrinkWrap: true,
            itemCount: controller.model.value.data!.length,
            itemBuilder: (context, index) {
              return Column(
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(17)
                                  ),
                                  child:
                                  Image.asset('assets/images/Rectangle 39702.png',height: 76,width: 76,)

                              ),
                              addWidth(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                  Text( ( controller.model.value.data![index].orderItems![0].productName ?? 'Test').toString(),
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: const Color(0xFF1A2E33)
                                    ),),
                                  addHeight(3),
                                  Row(
                                    children: [
                                      Text('${controller.model.value.data![index].itemCount.toString()} items',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: const Color(0xFF486769).withOpacity(0.70)
                                        ),),
                                      addWidth(10),
                                      Container(
                                        width: 1,
                                        height: 10,
                                        color: Colors.grey,
                                      ),
                                      addWidth(10),
                                      Text('1.5km',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: const Color(0xFF486769).withOpacity(0.70)
                                        ),),
                                    ],
                                  ),
                                  addHeight(5),
                                  Row(
                                    children: [
                                      Text('€ ${controller.model.value.data![index].grandTotal.toString()}',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: const Color(0xFF70CC49)
                                        ),),
                                      addWidth(8),
                                      Container(
                                        // height: 24,
                                        // width: 76,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(
                                              color: const Color(0xFFFF6C81),
                                            )
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 4),
                                            child: Text(controller.model.value.data![index].deliveryStatus.toString(),
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFFFF6C81),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
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
                      ],
                    ),
                  ),
                  addHeight(15),
                ],
              );
            },
          ) :Center(child: Text('No Order')) : const Center(child: CircularProgressIndicator()),
        ),
      );
    });
  }
}
