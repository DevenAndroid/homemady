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
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
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

  Data(
      {this.id,
        this.userId,
        this.transactionId,
        this.amount,
        this.subscriptionStartDate,
        this.subscriptionExpiryDate,
        this.type,
        this.paymentMode,
        this.purchasedOn});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['transaction_id'] = this.transactionId;
    data['amount'] = this.amount;
    data['subscription_start_date'] = this.subscriptionStartDate;
    data['subscription_expiry_date'] = this.subscriptionExpiryDate;
    data['type'] = this.type;
    data['payment_mode'] = this.paymentMode;
    data['purchased_on'] = this.purchasedOn;
    return data;
  }
}
