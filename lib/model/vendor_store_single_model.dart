import 'package:get/get.dart';

class VendorStoreSingleModel {
  bool? status;
  String? message;
  Data? data;

  VendorStoreSingleModel({this.status, this.message, this.data});

  VendorStoreSingleModel.fromJson(Map<String, dynamic> json) {
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
  StoreDetails? storeDetails;
  List<LatestProducts>? latestProducts;
  //List<Null>? reviews;

  Data({this.storeDetails, this.latestProducts, //this.reviews
  });

  Data.fromJson(Map<String, dynamic> json) {
    storeDetails = json['storeDetails'] != null
        ? new StoreDetails.fromJson(json['storeDetails'])
        : null;
    if (json['LatestProducts'] != null) {
      latestProducts = <LatestProducts>[];
      json['LatestProducts'].forEach((v) {
        latestProducts!.add(new LatestProducts.fromJson(v));
      });
    }
    /*if (json['Reviews'] != null) {
      reviews = <Null>[];
      json['Reviews'].forEach((v) {
        reviews!.add(new Null.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.storeDetails != null) {
      data['storeDetails'] = this.storeDetails!.toJson();
    }
    if (this.latestProducts != null) {
      data['LatestProducts'] =
          this.latestProducts!.map((v) => v.toJson()).toList();
    }
    /*if (this.reviews != null) {
      data['Reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class StoreDetails {
  int? id;
  String? storeName;
  String? description;
  String? name;
  String? profileImage;
  String? storeImage;
  String? avgRating;
  int? reviewCount;
  String? deliveryType;
  String? deliveryTime;

  StoreDetails(
      {this.id,
        this.storeName,
        this.description,
        this.name,
        this.profileImage,
        this.storeImage,
        this.avgRating,
        this.reviewCount,
        this.deliveryType,
        this.deliveryTime});

  StoreDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
    description = json['description'];
    name = json['name'];
    profileImage = json['profile_image'];
    storeImage = json['store_image'];
    avgRating = json['avg_rating'];
    reviewCount = json['review_count'];
    deliveryType = json['delivery_type'];
    deliveryTime = json['delivery_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_name'] = this.storeName;
    data['description'] = this.description;
    data['name'] = this.name;
    data['profile_image'] = this.profileImage;
    data['store_image'] = this.storeImage;
    data['avg_rating'] = this.avgRating;
    data['review_count'] = this.reviewCount;
    data['delivery_type'] = this.deliveryType;
    data['delivery_time'] = this.deliveryTime;
    return data;
  }
}

class LatestProducts {
  int? id;
  String? sKU;
  String? name;
  int? qty;
  String? qtyType;
  bool ? value;
  String? minQty;
  String? maxQty;
  String? price;
  String? content;
  String? image;
  int? cookUnitDays;
  String? size;
  String? sizeId;
  String? discountOff;
  Null? avgRating;
  RxInt buttonCount = 1.obs;

  LatestProducts(
      {this.id,
        this.sKU,
        this.name,
        this.qty,
        this.qtyType,
        this.minQty,
        this.maxQty,
        this.price,
        this.content,
        this.image,
        this.cookUnitDays,
        this.size,
        this.sizeId,
        this.discountOff,
        this.avgRating});

  LatestProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sKU = json['SKU'];
    name = json['name'];
    qty = json['qty'];
    qtyType = json['qty_type'];
    minQty = json['min_qty'];
    maxQty = json['max_qty'];
    price = json['price'];
    content = json['content'];
    image = json['image'];
    cookUnitDays = json['cook_unit_days'];
    size = json['size'];
    sizeId = json['size_id'];
    discountOff = json['discount_off'];
    avgRating = json['avg_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['SKU'] = this.sKU;
    data['name'] = this.name;
    data['qty'] = this.qty;
    data['qty_type'] = this.qtyType;
    data['min_qty'] = this.minQty;
    data['max_qty'] = this.maxQty;
    data['price'] = this.price;
    data['content'] = this.content;
    data['image'] = this.image;
    data['cook_unit_days'] = this.cookUnitDays;
    data['size'] = this.size;
    data['size_id'] = this.sizeId;
    data['discount_off'] = this.discountOff;
    data['avg_rating'] = this.avgRating;
    return data;
  }
}
