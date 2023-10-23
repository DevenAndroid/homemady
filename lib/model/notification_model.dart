class NotificationModel {
  bool? status;
  String? message;
  Data? data;

  NotificationModel({this.status, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? count;
  List<NotificationData>? notificationData;

  Data({this.count, this.notificationData});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['notificationData'] != null) {
      notificationData = <NotificationData>[];
      json['notificationData'].forEach((v) {
        notificationData!.add(NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (notificationData != null) {
      data['notificationData'] =
          notificationData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  int? id;
  String? title;
  String? body;
  String? notificationType;
  String? orderId;
  int? seen;
  String? time;

  NotificationData(
      {this.id,
        this.title,
        this.body,
        this.notificationType,
        this.seen,
        this.orderId,
        this.time});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    orderId = json['order_id'];
    notificationType = json['notification_type'];
    seen = json['seen'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['order_id'] = orderId;
    data['notification_type'] = notificationType;
    data['seen'] = seen;
    data['time'] = time;
    return data;
  }
}
