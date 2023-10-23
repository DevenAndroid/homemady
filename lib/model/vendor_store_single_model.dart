
import 'favorite_list_model.dart';

class VendorStoreSingleModel {
  bool? status;
  String? message;
  Data? data;

  VendorStoreSingleModel({this.status, this.message, this.data});

  VendorStoreSingleModel.fromJson(Map<String, dynamic> json) {
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
  StoreDetails? storeDetails;
  List<LatestProducts>? latestProducts;
  //List<Null>? reviews;

  Data({this.storeDetails, this.latestProducts, //this.reviews
  });

  Data.fromJson(Map<String, dynamic> json) {
    storeDetails = json['storeDetails'] != null
        ? StoreDetails.fromJson(json['storeDetails'])
        : null;
    if (json['LatestProducts'] != null) {
      latestProducts = <LatestProducts>[];
      json['LatestProducts'].forEach((v) {
        latestProducts!.add(LatestProducts.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (storeDetails != null) {
      data['storeDetails'] = storeDetails!.toJson();
    }
    if (latestProducts != null) {
      data['LatestProducts'] =
          latestProducts!.map((v) => v.toJson()).toList();
    }
    /*if (this.reviews != null) {
      data['Reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class StoreDetails {
  dynamic id;
  dynamic storeName;
  dynamic description;
  dynamic name;
  List<Award>? award;
  dynamic profileImage;
  dynamic storeImage;
  dynamic avgRating;
  dynamic reviewCount;
  dynamic collection;
  dynamic deliveryType;
  dynamic deliveryTime;
  dynamic distance;
  bool? sustainablePackagingStatus;
  dynamic time;
  dynamic time1;

  dynamic wishlist;


  StoreDetails(
      {this.id,
        this.storeName,
        this.description,
        this.name,
        this.award,
        this.profileImage,
        this.storeImage,
        this.avgRating,
        this.collection,
        this.reviewCount,
        this.sustainablePackagingStatus,
        this.deliveryType,
        this.distance,

        this.time,
        this.time1,
        this.wishlist,
        this.deliveryTime});

  StoreDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
    description = json['description'];
    collection = json['collection'];
    name = json['name'];
    if (json['award'] != null) {
      award = <Award>[];
      json['award'].forEach((v) {
        award!.add(Award.fromJson(v));
      });
    }
    distance = json['distance'];
    time = json['Time'];
    time1 = json['Time1'];
    wishlist = json['wishlist'];
    profileImage = json['profile_image'];
    storeImage = json['store_image'];
    sustainablePackagingStatus = json['sustainable_packaging_status'];
    avgRating = json['avg_rating'];
    reviewCount = json['review_count'];
    deliveryType = json['delivery_type'];
    deliveryTime = json['delivery_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['store_name'] = storeName;
    data['description'] = description;
    data['name'] = name;
    if (award != null) {
      data['award'] = award!.map((v) => v.toJson()).toList();
    }
    data['distance'] = distance;
    data['sustainable_packaging_status'] = sustainablePackagingStatus;
    data['Time'] = time;
    data['Time1'] = time1;
    data['distance'] = distance;
    data['collection'] = collection;
    data['profile_image'] = profileImage;
    data['store_image'] = storeImage;
    data['avg_rating'] = avgRating;
    data['review_count'] = reviewCount;

    data['wishlist'] = wishlist;
    data['delivery_type'] = deliveryType;
    data['delivery_time'] = deliveryTime;
    return data;
  }
}

class LatestProducts {
  dynamic id;
  dynamic sKU;
  dynamic name;
  dynamic qty;
  dynamic qtyType;
  bool ? value;
  dynamic minQty;
  dynamic date;
  dynamic subTitle;
  dynamic sizeQuantity;
  dynamic maxQty;
  dynamic price;
  dynamic content;
  dynamic image;
  dynamic cookUnitDays;
  dynamic size;
  dynamic sizeId;
  dynamic discountOff;
  dynamic wishlist;
  dynamic spiciness;
  dynamic allergens;
  dynamic exclude;

  dynamic avgRating;
  // RxInt buttonCount = 0.obs;
  int productCount = 0;
  LatestProducts(
      {this.id,
        this.sKU,
        this.name,
        this.qty,
        this.qtyType,
        this.minQty,
        this.date,
        this.maxQty,
        this.price,
        this.content,
        this.sizeQuantity,
        this.image,
        this.subTitle,
        this.cookUnitDays,
        this.size,
        this.wishlist,
        this.sizeId,
        this.spiciness,
        this.allergens,
        this.discountOff,
        this.exclude,
        this.avgRating});

  LatestProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sKU = json['SKU'];
    name = json['name'];
    qty = json['qty'];
    spiciness = json['spiciness'];
    qtyType = json['qty_type'];
    minQty = json['min_qty'];
    subTitle = json['sub_title'];
    maxQty = json['max_qty'];
    price = json['price'];
    date = json['Date'];
    allergens = json['allergens'];
    sizeQuantity = json['size_quantity'];
    content = json['content'];
    wishlist = json['wishlist'];
    image = json['image'];
    cookUnitDays = json['cook_unit_days'];
    size = json['size'];
    sizeId = json['size_id'];
    discountOff = json['discount_off'];
    exclude = json['exclude'];
    avgRating = json['avg_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['SKU'] = sKU;
    data['name'] = name;
    data['qty'] = qty;
    data['Date'] = date;
    data['wishlist'] = wishlist;
    data['qty_type'] = qtyType;
    data['min_qty'] = minQty;
    data['spiciness'] = spiciness;
    data['max_qty'] = maxQty;
    data['sub_title'] = subTitle;
    data['price'] = price;
    data['allergens'] = allergens;
    data['content'] = content;
    data['image'] = image;
    data['size_quantity'] = sizeQuantity;
    data['cook_unit_days'] = cookUnitDays;
    data['size'] = size;
    data['size_id'] = sizeId;
    data['discount_off'] = discountOff;
    data['avg_rating'] = avgRating;
    data['exclude'] = exclude;
    return data;
  }
}
