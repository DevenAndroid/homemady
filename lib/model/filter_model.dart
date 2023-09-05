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
        data!.add(new Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    link = json['link'] != null ? new Link.fromJson(json['link']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.link != null) {
      data['link'] = this.link!.toJson();
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
  String? allergens;
  int? inMenu;
  String? status;
  String? discountOff;
  bool? wishlist;
  dynamic productCount = 0;

  Data(
      {this.id,
        this.sKU,
        this.subTitle,
        this.name,
        this.price,
        this.content,
        this.image,
        this.cookUnitDays,
        this.sizeQuantity,
        this.sizeId,
        this.spiciness,
        this.allergens,
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
    content = json['content'];
    image = json['image'];
    cookUnitDays = json['cook_unit_days'];
    sizeQuantity = json['size_quantity'];
    sizeId = json['size_id'];
    spiciness = json['spiciness'];
    allergens = json['allergens'];
    inMenu = json['in_menu'];
    status = json['status'];
    discountOff = json['discount_off'];
    wishlist = json['wishlist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['SKU'] = this.sKU;
    data['sub_title'] = this.subTitle;
    data['name'] = this.name;
    data['price'] = this.price;
    data['content'] = this.content;
    data['image'] = this.image;
    data['cook_unit_days'] = this.cookUnitDays;
    data['size_quantity'] = this.sizeQuantity;
    data['size_id'] = this.sizeId;
    data['spiciness'] = this.spiciness;
    data['allergens'] = this.allergens;
    data['in_menu'] = this.inMenu;
    data['status'] = this.status;
    data['discount_off'] = this.discountOff;
    data['wishlist'] = this.wishlist;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_page'] = this.totalPage;
    data['current_page'] = this.currentPage;
    data['total_item'] = this.totalItem;
    data['per_page'] = this.perPage;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next'] = this.next;
    data['prev'] = this.prev;
    return data;
  }
}
