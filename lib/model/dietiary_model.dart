import 'package:get/get.dart';

class DietiartyModel {
  bool? status;
  String? message;
  Data? data;

  DietiartyModel({this.status, this.message, this.data});

  DietiartyModel.fromJson(Map<String, dynamic> json) {
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
  RxString selected = "".obs;
  List<Dietary>? dietary;
  List<Dietary>? selectedItems=[];

  Data({this.dietary});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['dietary'] != null) {
      dietary = <Dietary>[];
      json['dietary'].forEach((v) {
        dietary!.add(new Dietary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dietary != null) {
      data['dietary'] = this.dietary!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
