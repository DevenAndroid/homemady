class ForgotPasswordModel {
  bool? status;
  String? message;
  int? data;

  ForgotPasswordModel({this.status, this.message, this.data});

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}
