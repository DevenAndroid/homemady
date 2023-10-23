class SearchStoreModel {
  bool? status;
  String? message;
  List<Data>? data;
  Meta? meta;
  Link? link;

  SearchStoreModel(
      {this.status, this.message, this.data, this.meta, this.link});

  SearchStoreModel.fromJson(Map<String, dynamic> json) {
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
  dynamic id;
  dynamic sKU;
  dynamic name;
  dynamic qty;
  dynamic price;
  dynamic content;
  dynamic image;
  dynamic cookUnitDays;
  dynamic size;
  dynamic sizeId;
  dynamic inMenu;
  dynamic discountOff;
  dynamic avgRating;

  Data(
      {this.id,
        this.sKU,
        this.name,
        this.qty,
        this.price,
        this.content,
        this.image,
        this.cookUnitDays,
        this.size,
        this.sizeId,
        this.inMenu,
        this.discountOff,
        this.avgRating});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sKU = json['SKU'];
    name = json['name'];
    qty = json['qty'];
    price = json['price'];
    content = json['content'];
    image = json['image'];
    cookUnitDays = json['cook_unit_days'];
    size = json['size'];
    sizeId = json['size_id'];
    inMenu = json['in_menu'];
    discountOff = json['discount_off'];
    avgRating = json['avg_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['SKU'] = sKU;
    data['name'] = name;
    data['qty'] = qty;
    data['price'] = price;
    data['content'] = content;
    data['image'] = image;
    data['cook_unit_days'] = cookUnitDays;
    data['size'] = size;
    data['size_id'] = sizeId;
    data['in_menu'] = inMenu;
    data['discount_off'] = discountOff;
    data['avg_rating'] = avgRating;
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
