class SubscriptionListModel {
  bool? status;
  String? message;
  List<Data>? data;

  SubscriptionListModel({this.status, this.message, this.data});

  SubscriptionListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? userId;
  String? transactionId;
  String? amount;
  String? subscriptionStartDate;
  String? subscriptionExpiryDate;
  String? type;
  String? paymentMode;
  String? purchasedOn;
  String? status;

  Data(
      {this.id,
        this.userId,
        this.transactionId,
        this.amount,
        this.subscriptionStartDate,
        this.subscriptionExpiryDate,
        this.type,
        this.paymentMode,
        this.purchasedOn,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    transactionId = json['transaction_id'];
    amount = json['amount'];
    subscriptionStartDate = json['subscription_start_date'];
    subscriptionExpiryDate = json['subscription_expiry_date'];
    type = json['type'];
    paymentMode = json['payment_mode'];
    purchasedOn = json['purchased_on'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['transaction_id'] = transactionId;
    data['amount'] = amount;
    data['subscription_start_date'] = subscriptionStartDate;
    data['subscription_expiry_date'] = subscriptionExpiryDate;
    data['type'] = type;
    data['payment_mode'] = paymentMode;
    data['purchased_on'] = purchasedOn;
    data['status'] = status;
    return data;
  }
}
