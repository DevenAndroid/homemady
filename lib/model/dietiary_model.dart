import 'package:get/get.dart';

class DietiartyModel {
  bool? status;
  String? message;
  Data? data;

  DietiartyModel({this.status, this.message, this.data});

  DietiartyModel.fromJson(Map<String, dynamic> json) {
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
  Set<String> selectedIds = {};
  // RxString selected = "".obs;
  List<Dietary>? dietary;
  List<Dietary>? selectedItems=[];

  Data({this.dietary});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['dietary'] != null) {
      dietary = <Dietary>[];
      json['dietary'].forEach((v) {
        dietary!.add(Dietary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dietary != null) {
      data['dietary'] = dietary!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dietary {
  int? id;
  String? title;
  RxBool isCheckedItem=false.obs;

  Dietary({this.id, this.title});

  Dietary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}
