import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../model/order_details_model.dart';
enum MessageType{
  simpleMessage,
  withImage,
}

class FirebaseService{
  static String messageCollection = "chats_list";

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessagesList({
    required String roomId,
  }){
    return fireStore.collection(messageCollection).doc(roomId).collection("messages").orderBy("message_sent_time", descending: true).snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getRoomInfoStream({
    required String roomId,
  }){
    return fireStore.collection(messageCollection).doc(roomId).snapshots();
  }

  Future<int> getUnseenCount({
    required String roomId,
    required DateTime lastSeen
  }) async {
    int length = 0;
    await fireStore.collection(messageCollection).doc(roomId)
        .collection("messages")
        .where("last_message_time",isLessThan: lastSeen)
        .limit(12).get().then((value) {
      length = value.docs.length;
      // return value;
    });
    return length;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getRoomsListStream({
    required String profileID,
  }){
    return fireStore.collection(messageCollection).where("creators", arrayContains: profileID)
        .orderBy("last_message_time", descending: true).snapshots();
  }

  Future<OrderDetail?> getRoomInfo({
    required String roomId,
  }) async {
    var gg = await fireStore.collection(messageCollection).doc(roomId).get();
    if(gg.exists) {
      if(gg.data() == null){
        return null;
      }
      var mm = gg.data()!["data"];
      return OrderDetail.fromJson(mm as Map);
    }
    return null;
  }

  Future<int> getUnreadMessages({required String roomId,required DateTime lastTime}) async {
    QuerySnapshot<Map<String, dynamic>> docSnap =
    await fireStore.collection(messageCollection).doc(roomId).collection("messages").where("time",isGreaterThan: lastTime).get();
    if (kDebugMode) print(docSnap.docs.map((e) => e.data().toString()).toList());
    return docSnap.docs.length;
  }

  updateLastSeen({
    required String roomId,
    required String myId,
  }) async {
    await fireStore.collection(messageCollection).doc(roomId).update({
      "last_time_$myId" : DateTime.now().microsecondsSinceEpoch
    }).then((value) {
      log("last time updated....      $myId");
    });
  }

  Future sendMessage({
    required String roomId,
    required String message,
    required String senderId,
    required MessageType messageType,
    required OrderDetail orderDetail,
    required bool allowSet
  }) async {
    DateTime currentTime = DateTime.now();
    Map<String, dynamic> map = {};
    map["text_message"] = message;
    map["sender_id"] = senderId;
    map["message_type"] = messageType.name;
    map["message_sent_time"] = currentTime;

    await fireStore.collection(messageCollection).doc(roomId)
        .collection("messages").add(map).then((value) async {
      log("Message Sent........");

      Map<String, dynamic> map1 = {};
      map1["last_message"] = message;
      map1["last_message_time"] = currentTime;
      map1["last_message_sender"] = senderId;
      if(orderDetail.user != null){
        map1["order_details"] = orderDetail.toJson();
        map1["creators"] = [senderId,orderDetail.vendor!.id.toString()];
      }
      if(allowSet == true) {
        await fireStore.collection(messageCollection).doc(roomId).set(map1).then((value) {
          log("Message Updated");
        });
      } else {
        await fireStore.collection(messageCollection).doc(roomId).update(map1).then((value) {
          log("Message Updated");
        });
      }

    });
  }


  String createChatRoom({
    required int user1,
    required int user2,
  }){
    String gg = "";
    if(user1 > user2){
      gg = "$user1 -- $user2";
    } else {
      gg = "$user2 -- $user1";
    }
    return gg;
  }
}

extension ConverToNum on String{
  num get convertToNum{
    return num.tryParse(this) ?? 0;
  }
}