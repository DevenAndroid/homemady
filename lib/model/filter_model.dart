import 'package:homemady/model/vendor_store_single_model.dart';

class FilterProductModel {
  bool? status;
  String? message;
  List<Data>? data;
  Meta? meta;
  Link? link;

  FilterProductModel(
      {this.status, this.message, this.data, this.meta, this.link});

  FilterProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    link = json['link'] != null ? Link.fromJson(json['link']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (link != null) {
      data['link'] = link!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? sKU;
  String? subTitle;
  String? name;
  String? price;
  bool ? value;
  String? content;
  String? image;
  String? cookUnitDays;
  String? sizeQuantity;
  String? sizeId;
  String? spiciness;
  // String? allergens;
  List<Allergen>? allergen = [];
  bool? inMenu;
  String? status;
  String? time;
  String? time1;
  String? date;
  dynamic special_offer;
  String? distance;
  String? discountOff;
  bool? wishlist;
  dynamic productCount = 0;

  Data(
      {this.id,
        this.sKU,
        this.allergen,
        this.subTitle,
        this.name,
        this.price,
        this.time,
        this.time1,
        this.date,
        this.content,
        this.special_offer,
        this.image,
        this.cookUnitDays,
        this.sizeQuantity,
        this.sizeId,
        this.distance,
        this.spiciness,
        this.inMenu,
        this.status,
        this.discountOff,
        this.wishlist});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sKU = json['SKU'];
    subTitle = json['sub_title'];
    name = json['name'];
    price = json['price'];
    special_offer = json['special_offer'];
    date = json['Date'];
    distance = json['distance'];
    time = json['Time'];
    time1 = json['Time1'];
    content = json['content'];
    image = json['image'];
    cookUnitDays = json['cook_unit_days'];
    sizeQuantity = json['size_quantity'];
    sizeId = json['size_id'];
    spiciness = json['spiciness'];
    try {
      if (json['allergens'] != null) {
        allergen = <Allergen>[];
        json['allergens'].forEach((v) {
          allergen!.add(new Allergen.fromJson(v));
        });
      }
    } catch(e){}
    allergen ??= [];
    inMenu = json['in_menu'];
    status = json['status'];
    discountOff = json['discount_off'];
    wishlist = json['wishlist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['SKU'] = sKU;
    data['sub_title'] = subTitle;
    data['name'] = name;
    data['price'] = price;
    data['distance'] = distance;
    data['Time'] = time;
    data['Date'] = date;
    data['Time1'] = time1;
    data['content'] = content;
    data['image'] = image;
    data['cook_unit_days'] = cookUnitDays;
    data['size_quantity'] = sizeQuantity;
    data['size_id'] = sizeId;
    data['spiciness'] = spiciness;
    // data['allergens'] = allergens;
    data['in_menu'] = inMenu;
    data['status'] = status;
    data['discount_off'] = discountOff;
    data['wishlist'] = wishlist;
    return data;
  }
}

class Meta {
  int? totalPage;
  int? currentPage;
  int? totalItem;
  int? perPage;

  Meta({this.totalPage, this.currentPage, this.totalItem, this.perPage});

  Meta.fromJson(Map<String, dynamic> json) {
    totalPage = json['total_page'];
    currentPage = json['current_page'];
    totalItem = json['total_item'];
    perPage = json['per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_page'] = totalPage;
    data['current_page'] = currentPage;
    data['total_item'] = totalItem;
    data['per_page'] = perPage;
    return data;
  }
}

class Link {
  bool? next;
  bool? prev;

  Link({this.next, this.prev});

  Link.fromJson(Map<String, dynamic> json) {
    next = json['next'];
    prev = json['prev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['next'] = next;
    data['prev'] = prev;
    return data;
  }
}
