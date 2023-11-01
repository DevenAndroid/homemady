class FavoriteListModel {
  bool? status;
  String? message;
  Data? data;

  FavoriteListModel({this.status, this.message, this.data});

  FavoriteListModel.fromJson(Map<String, dynamic> json) {
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
  List<Store>? store;
  List<Product>? product;

  Data({this.store, this.product});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['store'] != null) {
      store = <Store>[];
      json['store'].forEach((v) {
        store!.add(Store.fromJson(v));
      });
    }
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (store != null) {
      data['store'] = store!.map((v) => v.toJson()).toList();
    }
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Store {
  dynamic id;
  dynamic name;
  dynamic distance;
  dynamic time;
  dynamic time1;
  dynamic image;
  List<Award>? award;
  dynamic rating;
  dynamic countReviewData;
  dynamic cookName;
  dynamic description;
  bool? wishlist;
  bool? canDeliver;
  bool? sustainablePackagingStatus;
  dynamic profileImage;
  dynamic collection;

  Store(
      {this.id,
        this.name,
        this.distance,
        this.time,
        this.time1,
        this.image,
        this.award,
        this.rating,
        this.countReviewData,
        this.cookName,
        this.description,
        this.wishlist,
        this.canDeliver,
        this.sustainablePackagingStatus,
        this.profileImage,
        this.collection});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    distance = json['distance'];
    time = json['Time'];
    time1 = json['Time1'];
    image = json['image'];
    if (json['award'] != null) {
      award = <Award>[];
      json['award'].forEach((v) {
        award!.add(new Award.fromJson(v));
      });
    }
    rating = json['rating'];
    countReviewData = json['count_review_Data'];
    cookName = json['Cook name'];
    description = json['description'];
    wishlist = json['wishlist'];
    canDeliver = json['can_deliver'];
    sustainablePackagingStatus = json['sustainable_packaging_status'];
    profileImage = json['profile image'];
    collection = json['collection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['distance'] = this.distance;
    data['Time'] = this.time;
    data['Time1'] = this.time1;
    data['image'] = this.image;
    if (this.award != null) {
      data['award'] = this.award!.map((v) => v.toJson()).toList();
    }
    data['rating'] = this.rating;
    data['count_review_Data'] = this.countReviewData;
    data['Cook name'] = this.cookName;
    data['description'] = this.description;
    data['wishlist'] = this.wishlist;
    data['can_deliver'] = this.canDeliver;
    data['sustainable_packaging_status'] = this.sustainablePackagingStatus;
    data['profile image'] = this.profileImage;
    data['collection'] = this.collection;
    return data;
  }
}


class Award {
  dynamic title;
  dynamic image;

  Award({this.title, this.image});

  Award.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['image'] = image;
    return data;
  }
}

class Product {
  dynamic id;
  dynamic sKU;
  dynamic name;
  dynamic price;
  dynamic content;
  dynamic subTitle;
  bool ? value;
  dynamic image;
  dynamic  cookUnitDays;
  dynamic exclude;
  dynamic qty;
  dynamic sizeQuantity;
  dynamic sizeId;
  dynamic inMenu;
  dynamic date;
  dynamic status;
  dynamic spiciness;
  dynamic allergens;
  dynamic discountOff;
  dynamic avgRating;
  dynamic productCount = 0;

  Product(
      {this.id,
        this.sKU,
        this.name,
        this.price,
        this.content,
        this.exclude,
        this.date,
        this.image,
        this.cookUnitDays,
        this.qty,
        this.subTitle,
        this.sizeQuantity,
        this.sizeId,
        this.inMenu,
        this.status,
        this.spiciness,
        this.allergens,
        this.discountOff,
        this.avgRating});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sKU = json['SKU'];
    name = json['name'];
    date = json['Date'];
    price = json['price'];
    content = json['content'];
    exclude = json['exclude'];
    qty = json['qty'];
    image = json['image'];
    subTitle = json['sub_title'];
    cookUnitDays = json['cook_unit_days'];
    sizeQuantity = json['size_quantity'];
    sizeId = json['size_id'];
    inMenu = json['in_menu'];
    status = json['status'];
    discountOff = json['discount_off'];
    spiciness = json['spiciness'];
    allergens = json['allergens'];
    avgRating = json['avg_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['SKU'] = sKU;
    data['name'] = name;
    data['Date'] = date;
    data['exclude'] = exclude;
    data['price'] = price;
    data['qty'] = qty;
    data['content'] = content;
    data['image'] = image;
    data['cook_unit_days'] = cookUnitDays;
    data['size_quantity'] = sizeQuantity;
    data['size_id'] = sizeId;
    data['in_menu'] = inMenu;
    data['sub_title'] = subTitle;
    data['status'] = status;
    data['spiciness'] = spiciness;
    data['allergens'] = allergens;
    data['discount_off'] = discountOff;
    data['avg_rating'] = avgRating;
    return data;
  }
}
