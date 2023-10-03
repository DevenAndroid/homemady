class FavoriteListModel {
  bool? status;
  String? message;
  Data? data;

  FavoriteListModel({this.status, this.message, this.data});

  FavoriteListModel.fromJson(Map<String, dynamic> json) {
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
  List<Store>? store;
  List<Product>? product;

  Data({this.store, this.product});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['store'] != null) {
      store = <Store>[];
      json['store'].forEach((v) {
        store!.add(new Store.fromJson(v));
      });
    }
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.store != null) {
      data['store'] = this.store!.map((v) => v.toJson()).toList();
    }
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Store {
  dynamic id;
  dynamic name;
  dynamic distance;
  dynamic image;
  List<Award>? award;
  dynamic rating;
  dynamic time;
  dynamic countReviewData;
  dynamic cookName;
  dynamic collection;
  bool? wishlist;
  dynamic profileImage;

  Store(
      {this.id,
        this.name,
        this.distance,
        this.image,
        this.award,
        this.time,
        this.rating,
        this.collection,
        this.countReviewData,
        this.cookName,
        this.wishlist,
        this.profileImage});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    distance = json['distance'];
    image = json['image'];
    if (json['award'] != null) {
      award = <Award>[];
      json['award'].forEach((v) {
        award!.add(new Award.fromJson(v));
      });
    }
    rating = json['rating'];
    time = json['Time'];
    collection = json['collection'];
    countReviewData = json['count_review_Data'];
    cookName = json['Cook name'];
    wishlist = json['wishlist'];
    profileImage = json['profile image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['collection'] = this.collection;
    data['distance'] = this.distance;
    data['Time'] = this.time;
    data['image'] = this.image;
    if (this.award != null) {
      data['award'] = this.award!.map((v) => v.toJson()).toList();
    }
    data['rating'] = this.rating;
    data['count_review_Data'] = this.countReviewData;
    data['Cook name'] = this.cookName;
    data['wishlist'] = this.wishlist;
    data['profile image'] = this.profileImage;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image'] = this.image;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['SKU'] = this.sKU;
    data['name'] = this.name;
    data['Date'] = this.date;
    data['exclude'] = this.exclude;
    data['price'] = this.price;
    data['qty'] = this.qty;
    data['content'] = this.content;
    data['image'] = this.image;
    data['cook_unit_days'] = this.cookUnitDays;
    data['size_quantity'] = this.sizeQuantity;
    data['size_id'] = this.sizeId;
    data['in_menu'] = this.inMenu;
    data['sub_title'] = this.subTitle;
    data['status'] = this.status;
    data['spiciness'] = spiciness;
    data['allergens'] = allergens;
    data['discount_off'] = this.discountOff;
    data['avg_rating'] = this.avgRating;
    return data;
  }
}
