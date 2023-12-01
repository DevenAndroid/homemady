import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/my_order_model.dart';
import '../repository/my_order_repo.dart';
import '../widgets/custome_size.dart';

class MyOrderController extends GetxController {
  Rx<MyOrderModel> model = MyOrderModel().obs;
  RxBool isDataLoading = false.obs;
  RxInt refreshInt = 0.obs;

  getData() {
    myOrderData().then((value1) {
      isDataLoading.value = true;
      model.value = value1;
      refreshInt.value = DateTime.now().millisecondsSinceEpoch;
    });
  }
}

extension ManageNotification on Widget {
  Widget manageNotification({bool? safeArea}){
    final controller = Get.put(MyOrderController());
    return Obx(() {
      if (controller.refreshInt.value > 0) {}
      return Stack(
        children: [
          this,
          if (controller.model.value.data != null && controller.model.value.data!.isNotEmpty)
            if (controller.model.value.data!.first.deliveryStatus != 'Cancelled' &&
                controller.model.value.data!.first.deliveryStatus != 'Completed')
              Positioned(
                bottom: 0,
                  right: 0,
                  left: 0,
                  child: SafeArea(
                    bottom: safeArea ?? true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16,).copyWith(
                        bottom: 20
                      ),
                      height: 95,
                      child: Material(
                        color: Colors.transparent,
                        elevation: 0,
                        surfaceTintColor: Colors.transparent,
                        child: Hero(
                          tag: "notification_tag",
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.green,
                              ),
                              width: Get.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 0,
                                      sigmaY: 00
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      addWidth(8),
                                      Container(
                                        height: 60,
                                        width: 3,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                          color: Colors.white,
                                        ),
                                        // child: VerticalDivider(
                                        //   color: Color(0xffFF6100),
                                        //   thickness: 2.5,
                                        // ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      const SizedBox(
                                        height: 32,
                                        width: 32,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Text(
                                            'B',
                                            style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10, right: 6),
                                              child: Text(
                                                controller.model.value.data!.first.placedAt.toString(),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: Text(
                                                controller.model.value.data!.first.deliveryStatus.toString(),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10, right: 10),
                                              child: Text(
                                                "You Order #${controller.model.value.data!.first.orderId}",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      );
    });
  }
}
