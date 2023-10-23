class RemoveCartModel {
  bool? status;
  String? message;

  RemoveCartModel({this.status, this.message});

  RemoveCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
