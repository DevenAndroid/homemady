
class MessageModel {
  String? textMessage;
  String? senderId;
  DateTime? messageSentTime;
  String? messageType;
  String highlightDate = "";

  MessageModel({
    this.textMessage,
    this.senderId,
    this.messageSentTime,
    this.messageType,
  });

  MessageModel.fromMap(Map<dynamic, dynamic> map) {
    textMessage = map["text_message"] ?? "";
    senderId = map["sender_id"].toString();
    messageSentTime = map["message_sent_time"].toDate();
    messageType = map["message_type"].toString();
  }

  Map<String, dynamic> toMap() {
    return {
      "text": textMessage,
      "message_sent_time": messageSentTime,
      "message_type": messageType,
      "sender_id": senderId,
    };
  }
}

class ChatDataModel {
  String? lastMessage;
  List<dynamic>? creators;
  DateTime? lastMessageTime;
  String? messageType;
  Map<dynamic, dynamic>? order_details;
  Map<dynamic, dynamic>? completeData;

  ChatDataModel({
    this.lastMessage,
    this.creators,
    this.lastMessageTime,
    this.completeData,
    this.messageType,
    this.order_details,
  });

  ChatDataModel.fromMap(Map<dynamic, dynamic> map) {
    lastMessage = map["last_message"] ?? "";
    creators = map['creators'].cast<String>();
    lastMessageTime = map["last_message_time"].toDate();
    messageType = map["message_type"].toString();
    order_details = map["order_details"];
    completeData = map;
  }

  Map<String, dynamic> toMap() {
    return {
      // "text": textMessage,
      // "message_sent_time": messageSentTime,
      // "message_type": messageType,
      // "sender_id": senderId,
    };
  }
}