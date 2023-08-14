import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CategoryModel {
  bool? status;
  String? message;
  Data? data;

  CategoryModel({this.status, this.message, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
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

  List<Category>? category;
  List<SecondaryCategory>? secondaryCategory;
  List<TertiaryCategory>? tertiaryCategory;
  List<Category>? selectedContacts = [];
  List<SecondaryCategory>? selectedContacts1 = [];
  List<TertiaryCategory>? selectedContacts2 = [];

  Data({this.category, this.secondaryCategory, this.tertiaryCategory});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['secondaryCategory'] != null) {
      secondaryCategory = <SecondaryCategory>[];
      json['secondaryCategory'].forEach((v) {
        secondaryCategory!.add(new SecondaryCategory.fromJson(v));
      });
    }
    if (json['tertiaryCategory'] != null) {
      tertiaryCategory = <TertiaryCategory>[];
      json['tertiaryCategory'].forEach((v) {
        tertiaryCategory!.add(new TertiaryCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.secondaryCategory != null) {
      data['secondaryCategory'] =
          this.secondaryCategory!.map((v) => v.toJson()).toList();
    }
    if (this.tertiaryCategory != null) {
      data['tertiaryCategory'] =
          this.tertiaryCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? categoryType;

  RxBool isChecked = false.obs;

  Category({this.id, this.name, this.categoryType});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryType = json['category_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_type'] = this.categoryType;
    return data;
  }
}
class SecondaryCategory {
  int? id;
  String? name;
  String? categoryType;
  RxBool isChecked1 = false.obs;

  SecondaryCategory({this.id, this.name, this.categoryType});

  SecondaryCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryType = json['category_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_type'] = this.categoryType;
    return data;
  }
}
class TertiaryCategory {
  int? id;
  String? name;
  String? categoryType;
  RxBool isChecked2 = false.obs;

  TertiaryCategory({this.id, this.name, this.categoryType});

  TertiaryCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryType = json['category_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_type'] = this.categoryType;
    return data;
  }
}
