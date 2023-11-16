import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homemady/resources/helper.dart';
import 'package:intl/intl.dart';
import '../../controller/user_profile_controller.dart';
import '../../model/chat_model/model_chat_data.dart';
import '../../model/order_details_model.dart';
import '../../resources/add_text.dart';
import '../../service/firebase_service.dart';
import '../../widgets/app_theme.dart';
import '../../widgets/custome_size.dart';
import '../../widgets/dimenestion.dart';
import 'main_chat_screen.dart';
import 'count_unseen_message.dart';

class ChattingListScreen extends StatefulWidget {
  const ChattingListScreen({Key? key}) : super(key: key);
  static var notificationScreen2 = "/notificationScreen2";
  @override
  ChattingListScreenState createState() => ChattingListScreenState();
}

class ChattingListScreenState extends State<ChattingListScreen> {
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  final DateFormat dateFormat1 = DateFormat("hh:mm a");

  final profileController = Get.put(UserProfileController());
  String get myUserID => profileController.myProfileID;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Theme(
        data: ThemeData(useMaterial3: true, dividerColor: Colors.transparent, backgroundColor: Colors.transparent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(offset: const Offset(0, 3), color: Colors.grey.withOpacity(.090), blurRadius: 1),
                const BoxShadow(offset: Offset(0, -1), color: Colors.white, blurRadius: 20),
              ]),
              child: Padding(
                padding: EdgeInsets.only(top: height * .045),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: Colors.white),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 25,
                              ))),
                      SizedBox(width: width * .05),
                      Text(
                        'Chat'.tr,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff303C5E),
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  // stream: FirebaseService().getRoomsListStream(profileID: profileController.myProfileID),
                  stream: FirebaseService().getRoomsListStream(profileID: myUserID.toString()),
                  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasData) {
                      List<ChatDataModel> gg = snapshot.data!.docs.map((e) => ChatDataModel.fromMap(e.data())).toList();
                      log("AAAA----${snapshot.data!.docs.map((e) => e.data().toString()).toList()}");

                      return gg.isNotEmpty
                          ? ListView.builder(
                              itemCount: gg.length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 10),
                              // physics: BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                final chatData = gg[index];
                                OrderDetail orderDetail = OrderDetail.fromJson(chatData.order_details!);
                                String displayName = myUserID != orderDetail.vendor!.id.toString()
                                    ? orderDetail.vendor!.storeName.toString()
                                    : orderDetail.user!.name.toString();
                                String displayImage = myUserID != orderDetail.vendor!.id.toString()
                                    ? orderDetail.vendor!.storeImage.toString()
                                    : orderDetail.user!.profileImage.toString();
                                String otherID = myUserID != orderDetail.vendor!.id.toString()
                                    ? orderDetail.vendor!.id.toString()
                                    : orderDetail.user!.id.toString();
                                int otherTime = chatData.completeData!["last_time_$otherID"] ?? 0;
                                // log("other TIme.....     ${otherTime}");
                                log("other TIme.....     $otherID");
                                // log("other TIme.....     ${chatData.completeData!}");

                                String roomId = FirebaseService().createChatRoom(
                                    user1: profileController.myProfileID.convertToNum.toInt(),
                                    user2: orderDetail.vendor!.id!.toString().convertToNum.toInt());

                                return InkWell(
                                  onTap: () async {
                                    String? myUserId = await getMyUserId();
                                    if (myUserId == null) {
                                      showToast("User Not Found");
                                      return;
                                    }
                                    // String roomId = FirebaseService().createChatRoom(
                                    //     user1: myUserId.convertToNum.toInt(),
                                    //     user2: controller.model.value.orderDetail!.vendor!.storeId.toString().convertToNum.toInt());
                                    // log(roomId);
                                    // Get.to(()=> MainChatScreen(
                                    //   roomId: roomId,
                                    //   orderId: controller.model.value.orderDetail!.orderId.toString(),
                                    //   receiverId: controller.model.value.orderDetail!.vendor!.storeId.toString(),
                                    //   receiverName: controller.model.value.orderDetail!.vendor!.storeName.toString(),
                                    //   receiverImage: controller.model.value.orderDetail!.vendor!.storeImage.toString(),
                                    //   senderId: myUserId,
                                    //   customer: {
                                    //     "user_id": profileController.model.value.data!.id.toString(),
                                    //     "user_name": profileController.model.value.data!.name.toString(),
                                    //     "user_image": profileController.model.value.data!.profileImage.toString(),
                                    //   },
                                    //   vendor: {
                                    //     "user_id": controller.model.value.orderDetail!.vendor!.storeId.toString(),
                                    //     "user_name": controller.model.value.orderDetail!.vendor!.storeName.toString(),
                                    //     "user_image": controller.model.value.orderDetail!.vendor!.storeImage.toString(),
                                    //   },
                                    // ));
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white, border: Border(bottom: BorderSide(color: Color(0xFFE5E5E5)))
                                        // boxShadow: (blurBoxShadow)
                                        ),
                                    //margin: EdgeInsets.all(1),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(40),
                                                          child: Image.network(
                                                            displayImage.toString(),
                                                            height: 50,
                                                            width: 50,
                                                            fit: BoxFit.contain,
                                                            errorBuilder: (_, __, ___) => Container(
                                                                height: 50,
                                                                width: 50,
                                                                decoration: const BoxDecoration(color: Colors.grey),
                                                                child: const Icon(
                                                                  Icons.person,
                                                                  color: Colors.white,
                                                                )),
                                                            loadingBuilder: (_, __, ___) {
                                                              if (___ == null) {
                                                                return __;
                                                              }
                                                              return const Center(
                                                                child: CircularProgressIndicator.adaptive(),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  if (otherTime != 0)
                                                    Positioned(
                                                      left: 38,
                                                      top: 0,
                                                      child: CountUnSeenMessages(
                                                        roomId: roomId,
                                                        otherSeen: DateTime.fromMicrosecondsSinceEpoch(otherTime),
                                                      ),
                                                    )
                                                ],
                                              ),
                                              SizedBox(
                                                width: AddSize.size12,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          displayName,
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: AddSize.font16,
                                                              fontFamily: 'Poppins'),
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          chatData.lastMessageTime!.isCurrentData
                                                              ? dateFormat1.format(chatData.lastMessageTime!)
                                                              : dateFormat.format(chatData.lastMessageTime!),
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: AddSize.font12,
                                                              color: const Color(0xFF9E9E9E)),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: height * .005,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          chatData.lastMessage.toString(),
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: 12,
                                                              color: Color(0xFFAAAFB5),
                                                              fontFamily: 'Poppins'),
                                                        ),
                                                        const Spacer(),
                                                        Image.asset(
                                                          "imgList2[index]",
                                                          height: 10,
                                                          width: 16,
                                                          color: index == 5 || index == 6 ? Colors.grey : const Color(0xFF548FE7),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/message_image.png',
                                      height: 250,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "No Messages",
                                      style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: Text(
                                        "Bong, it seems that you do not have any messages at the moment",
                                        style: TextStyle(color: Color(0xff9E9E9E), fontSize: 18, fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                    }
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/lock.png',
                  height: 13,
                  width: 13,
                ),
                const SizedBox(
                  width: 5,
                ),
                RichText(
                    text: TextSpan(style: const TextStyle(fontFamily: 'Poppins'), children: <TextSpan>[
                  TextSpan(
                      text: 'Your personal message are '.tr,
                      style: TextStyle(fontSize: AddSize.font12, fontWeight: FontWeight.w500, color: const Color(0xFFADADAD))),
                  TextSpan(
                      text: ' end-to-end encrypted'.tr,
                      style: TextStyle(fontSize: AddSize.font12, fontWeight: FontWeight.w500, color: const Color(0xff6EE23B))),
                ])),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget notificationList(date, title, description) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: Card(
        elevation: 0,
        child: Row(
          children: [
            SizedBox(
              width: width * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * .005,
              ),
              child: Container(
                width: width * .010,
                height: height * .08,
                decoration: const BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
            SizedBox(
              width: width * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                height: height * .05,
                width: width * .10,
                decoration: const ShapeDecoration(color: AppTheme.primaryColor, shape: CircleBorder()),
                child: Center(
                    child: Text(
                  "B".tr,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 24, color: AppTheme.backgroundcolor),
                )),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(12, 8, 8, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      date,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppTheme.primaryColor,
                            fontSize: 12,
                          ),
                    ),
                    addHeight(4),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppTheme.blackcolor,
                            fontSize: 14,
                          ),
                    ),
                    //textBold(snapshot.data!.data.notifications[index].title),
                    addHeight(4),
                    Text(
                      description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppTheme.subText,
                            fontSize: 12,
                          ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
