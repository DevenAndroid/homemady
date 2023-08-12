class StripeModel {
  bool? status;
  String? message;
  Data? data;

  StripeModel({this.status, this.message, this.data});

  StripeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? storeId;
  String? stripId;
  String? stripKey;

  Data({this.id, this.storeId, this.stripId, this.stripKey});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    stripId = json['strip_id'];
    stripKey = json['strip_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['strip_id'] = this.stripId;
    data['strip_key'] = this.stripKey;
    return data;
  }
}
