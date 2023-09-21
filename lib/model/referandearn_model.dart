class ReferAndEarnModel {
  bool? status;
  String? message;
  Data? data;

  ReferAndEarnModel({this.status, this.message, this.data});

  ReferAndEarnModel.fromJson(Map<String, dynamic> json) {
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
  String? referCode;
  String? referAmount;

  Data({this.referCode, this.referAmount});

  Data.fromJson(Map<String, dynamic> json) {
    referCode = json['referCode'];
    referAmount = json['referAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['referCode'] = this.referCode;
    data['referAmount'] = this.referAmount;
    return data;
  }
}
