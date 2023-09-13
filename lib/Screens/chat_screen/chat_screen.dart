import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:homemady/resources/helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../controller/user_profile_controller.dart';
import '../../model/chat_model/model_chat_data.dart';
import '../../model/order_details_model.dart';
import '../../service/firebase_service.dart';
import '../../widgets/app_theme.dart';
import '../../widgets/custome_textfiled.dart';
import '../../widgets/dimenestion.dart';
import '../orderDetailsScreen.dart';
import 'chat_bubble.dart';

class ChatScreen1 extends StatefulWidget {
  const ChatScreen1({Key? key}) : super(key: key);
  static var chatScreen1 = '/chatScreen1';

  @override
  State<ChatScreen1> createState() => _ChatScreen1State();
}

class _ChatScreen1State extends State<ChatScreen1> {
  String chatRoomId = "";
  String senderID = "";
  OrderDetail orderDetails = OrderDetail();
  FirebaseService service = FirebaseService();
  final TextEditingController messageController = TextEditingController();
  RxInt refreshInt = 0.obs;
  bool fromApi = false;

  File pickedImage = File("");
  RxString profileImage = "".obs;

  pickImage(ImageSource imageType) async {
    try {
      final photo =
      await ImagePicker().pickImage(source: imageType, imageQuality: 30);
      if (photo == null) return;
      final tempImage = File(photo.path);
      pickedImage = tempImage;
      pickedImage = tempImage;
      profileImage.value= pickedImage.path;
      // print( "22222222222222222  ${profileImage.value.toString()}");
      // print( "2111111111111111  ${pickedImage.path.toString()}");
      //List<int> imageBytes = pickedImage.readAsBytesSync();
      //profileImage.value = base64Encode(imageBytes);
      Get.back();
      refreshInt.value = DateTime.now().microsecondsSinceEpoch;
    } catch (error) {
      debugPrint(error.toString());
    }
  }
  getRooInfo() {
    service.getRoomInfo(roomId: chatRoomId).then((value) {
      if (value == null) return;
      orderDetails = value;
      fromApi = true;
      updateMyLastSeen();
      refreshInt.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  getUnreadMessages(DateTime time) {
    service.getUnreadMessages(roomId: chatRoomId, lastTime: time);
  }

  updateMyLastSeen() {
    service.updateLastSeen(roomId: chatRoomId, myId: profileController.myProfileID.toString());
  }

  final profileController = Get.put(UserProfileController());

  String get userName => profileController.myProfileID1 == orderDetails.user!.id.toString()
      ? orderDetails.vendor!.storeName.toString()
      : orderDetails.user!.name.toString();

  String get otherUserId => orderDetails.vendor!.id.toString();

  String get myUserId1 => profileController.myProfileID1;

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null) {
      chatRoomId = Get.arguments[0];
      senderID = Get.arguments[1];
      orderDetails = Get.arguments[2] ?? const OrderDetailsScreen();
      getRooInfo();
      listenToChanges();
    }
  }

  late StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> lastSeenSubscription;

  RxInt lastTimeByOther = 0.obs;
  DateTime? lastTimeByOtherTime;

  listenToChanges() {
    lastSeenSubscription = service.getRoomInfoStream(roomId: chatRoomId).listen((event) {
      log("events....    " + event.data().toString());
      lastTimeByOther.value = event.data()!["last_time_${otherUserId}"];
      log("events.........    " + lastTimeByOther.value.toString() + "   gggg");
      log("events.........    " + otherUserId + "   gggg");
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (fromApi == true) {
      lastSeenSubscription.cancel();
      Future.delayed(const Duration(seconds: 1)).then((value) {
        updateMyLastSeen();
      });
    }
  }

  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Pic Image From",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor),
                    onPressed: () {
                      pickImage(ImageSource.camera);
                      //Navigator.pop(context);
                    },
                    icon:  Icon(Icons.camera,color: Colors.white,),
                    label: const Text("CAMERA",style: TextStyle( color:Colors.white),),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor),
                    onPressed: () {
                      //Navigator.pop(context);
                      pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image,color: Colors.white),
                    label: const Text("GALLERY",style: TextStyle( color: Colors.white)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor),
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close,color: Colors.white),
                    label: const Text("CANCEL",style: TextStyle( color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Theme(
      data: ThemeData(useMaterial3: true, backgroundColor: Colors.transparent, dividerColor: Colors.transparent),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.white,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          bottom: PreferredSize(
            preferredSize: Size(AddSize.screenWidth, AddSize.size14),
            child: Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(offset: const Offset(0, 3), color: Colors.grey.withOpacity(.090), blurRadius: 1),
                const BoxShadow(offset: Offset(0, -1), color: Colors.white, blurRadius: 20),
              ]),
              height: AddSize.size10,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(16),
            child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.arrow_back)),
          ),
          title: Obx(() {
            if (refreshInt.value > 0) {}
            bool showUser = true;
            if (orderDetails.user != null) {
              showUser = orderDetails.user!.id.toString() == senderID;
            }
            return Row(
              children: [
                orderDetails.user != null
                    ? Image.network(
                        showUser ? orderDetails.user!.profileImage.toString() : orderDetails.vendor!.storeImage,
                        height: 30,
                        width: 30,
                        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                      )
                    : Image.asset(
                        'assets/images/chatPerson.png',
                        height: 30,
                        width: 30,
                      ),
                InkWell(
                  onTap: () {
                    // Get.toNamed(ChatInformationScreen.chatInformation);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderDetails.user != null
                          ? Text(userName,
                              style: TextStyle(
                                  fontSize: AddSize.font14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF1F2124)))
                          : Text('',
                              style: TextStyle(
                                  fontSize: AddSize.font14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF1F2124))),
                      Text(DateFormat("hh:mm a").format(DateTime.fromMillisecondsSinceEpoch(lastTimeByOther.value)),
                          style: TextStyle(
                              fontSize: AddSize.font10, fontWeight: FontWeight.w300, color: const Color(0xFF1F2124))),
                      // Text('last seen recently',style: TextStyle(fontSize: AddSize.font8,fontWeight: FontWeight.w400,color: Color(0xFF303D48))),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: service.getMessagesList(roomId: chatRoomId),
                  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasData) {
                      List<MessageModel> messagesList = [];
                      messagesList = snapshot.data!.docs.map((e) => MessageModel.fromMap(e.data())).toList();
                      String givenValue = "";
                      messagesList.reversed.toList().forEach((element) {
                        // print(element.messageSentTime!.isCurrentData);
                        if (element.messageSentTime == null) return;
                        if (element.messageSentTime!.toSimpleDate.toString() != givenValue) {
                          element.highlightDate = element.messageSentTime!.toSimpleDate.toString();
                          givenValue = element.messageSentTime!.toSimpleDate.toString();
                          // print(givenValue);
                        }
                      });

                      // print(messagesList[0].textMessage);
                      return ListView.builder(
                        // physics: BouncingScrollPhysics(),
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: messagesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Obx(() {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: ChatBubble(
                                isMe: profileController.myProfileID == messagesList[index].senderId.toString(),
                                highlightTime: DateTime.tryParse(messagesList[index].highlightDate),
                                message: messagesList[index].textMessage.toString(),
                                sentTime: messagesList[index].messageSentTime,
                                messageSeen: messagesList[index].messageSentTime != null && lastTimeByOther.value != 0
                                    ? lastTimeByOther.value >
                                        messagesList[index].messageSentTime!.microsecondsSinceEpoch
                                    : false,
                              ),
                            );
                          });
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
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
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){
                      pickImage(ImageSource.gallery);

            },
                    child: Image.asset(
                      'assets/images/add-square.png',
                      height: 28,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      imagePickerOption();
                    },
                    child: Image.asset(
                      'assets/images/camera1.png',
                      height: 28,
                    ),
                  ),
                  SizedBox(
                    width: 260,
                    child: CommonTextFieldWidgetSearch1(
                      controller: messageController,
                      hint: 'Type messages...',
                      suffix: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: GestureDetector(
                            onTap: () {
                              if (messageController.text.trim().isEmpty) return;
                              service
                                  .sendMessage(
                                      roomId: chatRoomId,
                                      message: messageController.text.trim(),
                                      senderId: profileController.myProfileID,
                                      messageType: MessageType.simpleMessage,
                                      orderDetail: orderDetails,
                                      allowSet: !fromApi)
                                  .then((value) {
                                messageController.clear();
                              });
                            },
                            child: Image.asset(
                              'assets/images/PaperPlaneRight.png',
                              height: 10,
                            )),
                      ),
                    ),
                  ),
                /*  Image.asset(
                    'assets/images/Group 1727.png',
                    height: 48,
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
