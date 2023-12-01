import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady/controller/my_order_controller.dart';
import 'package:homemady/widgets/custome_size.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import '../controller/notification_controller.dart';
import '../repository/notification_repo.dart';
import 'orderDetailsScreen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final controller = Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: backAppBar(title: "Notification", context: context),
        body: controller.isDataLoading.value
            ? controller.model.value.data!.notificationData!.isNotEmpty
                ? Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
                  child: ListView.builder(
                    // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: controller.model.value.data!.notificationData!.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
                          child: GestureDetector(
                            onTap: () {
                              notificationHideRepo(id: controller.model.value.data!.notificationData![index].id.toString());
                              Get.to(() => OrderDetailsScreen(
                                    storeID: controller.model.value.data!.notificationData![index].orderId.toString(),
                                  ));
                            },
                            child: Container(
                              height: 95,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0xFF04666E).withOpacity(0.14),
                                      spreadRadius: 1.0,
                                      blurRadius: 20.0,
                                      offset: const Offset(3.0, 3.0))
                                ],
                              ),
                              width: Get.width,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  addWidth(8),
                                  Container(
                                    height: 60,
                                    width: 3,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      color: Color(0xff7ED957),
                                    ),
                                    // child: VerticalDivider(
                                    //   color: Color(0xffFF6100),
                                    //   thickness: 2.5,
                                    // ),
                                  ),
                                  const SizedBox(
                                    width: 13,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xff7ED957),
                                      child: Text(
                                        'B',
                                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10, right: 6),
                                          child: Text(
                                            controller.model.value.data!.notificationData![index].time.toString(),
                                            style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff7ED957),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10, top: 2),
                                          child: Text(
                                            controller.model.value.data!.notificationData![index].title
                                                .toString()
                                                .capitalize
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff000000),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 2, left: 10, right: 10),
                                          child: Text(
                                            controller.model.value.data!.notificationData![index].body.toString(),
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              color: const Color(0xff292F34),
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
                        );
                      }),
                )
                : Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Image.asset('assets/images/notifactionIcon.png'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "No Notifications Yet",
                          style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, color: const Color(0xff000000), fontSize: 22),
                        ),
                      ],
                    ),
                  )
            : const Center(child: CircularProgressIndicator()),
      ).manageNotification();
    });
  }
}
