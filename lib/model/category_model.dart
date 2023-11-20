import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CategoryModel {
  bool? status;
  String? message;
  Data? data;

  CategoryModel({this.status, this.message, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
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

  List<Category> get allCategory => [
    ...category ?? [],
    ...secondaryCategory ?? [],
    ...tertiaryCategory ?? [],
  ];




  // RxString selectedID = "".obs;
  RxSet<String> selectedIds = <String>{}.obs;
  List<Category>? category;
  List<Category>? secondaryCategory;
  List<Category>? tertiaryCategory;
  List<Category>? selectedContacts = [];
  // List<Category>? selectedContacts1 = [];
  // List<Category>? selectedContacts2 = [];

  Data({this.category, this.secondaryCategory, this.tertiaryCategory});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
    if (json['secondaryCategory'] != null) {
      secondaryCategory = <Category>[];
      json['secondaryCategory'].forEach((v) {
        secondaryCategory!.add(Category.fromJson(v));
      });
    }
    if (json['tertiaryCategory'] != null) {
      tertiaryCategory = <Category>[];
      json['tertiaryCategory'].forEach((v) {
        tertiaryCategory!.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    if (secondaryCategory != null) {
      data['secondaryCategory'] =
          secondaryCategory!.map((v) => v.toJson()).toList();
    }
    if (tertiaryCategory != null) {
      data['tertiaryCategory'] =
          tertiaryCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? categoryType;

  Category({this.id, this.name, this.categoryType});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryType = json['category_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['category_type'] = categoryType;
    return data;
  }
}
