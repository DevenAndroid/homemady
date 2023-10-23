
// old one
// class FilterProductCategoryModel {
//   bool? status;
//   String? message;
//   List<Data>? data;
//   Meta? meta;
//   Link? link;
//
//   FilterProductCategoryModel(
//       {this.status, this.message, this.data, this.meta, this.link});
//
//   FilterProductCategoryModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//     meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
//     link = json['link'] != null ? new Link.fromJson(json['link']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     if (this.meta != null) {
//       data['meta'] = this.meta!.toJson();
//     }
//     if (this.link != null) {
//       data['link'] = this.link!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   dynamic id;
//   dynamic sKU;
//   dynamic name;
//   dynamic price;
//   dynamic content;
//   dynamic image;
//   dynamic cookUnitDays;
//   dynamic sizeQuantity;
//   dynamic subTitle;
//   dynamic sizeId;
//   dynamic spiciness;
//   dynamic allergens;
//   dynamic qty;
//   dynamic inMenu;
//   dynamic status;
//   dynamic discountOff;
//   dynamic avgRating;
//   dynamic exclude;
//   bool? wishlist;
//   bool ? value;
//   dynamic productId;
//   dynamic productCount = 0;
//
//   Data(
//       {this.id,
//         this.sKU,
//         this.name,
//         this.price,
//         this.content,
//         this.image,
//         this.cookUnitDays,
//         this.qty,
//         this.sizeQuantity,
//         this.sizeId,
//         this.spiciness,
//         this.allergens,
//         this.inMenu,
//         this.subTitle,
//         this.status,
//         this.discountOff,
//         this.avgRating,
//         this.exclude,
//         this.wishlist});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     sKU = json['SKU'];
//     name = json['name'];
//     price = json['price'];
//     content = json['content'];
//     image = json['image'];
//     subTitle = json['sub_title'];
//     qty = json['qty'];
//     cookUnitDays = json['cook_unit_days'];
//     sizeQuantity = json['size_quantity'];
//     sizeId = json['size_id'];
//     spiciness = json['spiciness'];
//     allergens = json['allergens'];
//     inMenu = json['in_menu'];
//     status = json['status'];
//     discountOff = json['discount_off'];
//     avgRating = json['avg_rating'];
//     exclude = json['exclude'];
//     wishlist = json['wishlist'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['SKU'] = this.sKU;
//     data['name'] = this.name;
//     data['price'] = this.price;
//     data['content'] = this.content;
//     data['qty'] = this.qty;
//     data['image'] = this.image;
//     data['cook_unit_days'] = this.cookUnitDays;
//     data['size_quantity'] = this.sizeQuantity;
//     data['sub_title'] = this.subTitle;
//     data['size_id'] = this.sizeId;
//     data['spiciness'] = this.spiciness;
//     data['allergen_id'] = this.allergens;
//     data['in_menu'] = this.inMenu;
//     data['status'] = this.status;
//     data['discount_off'] = this.discountOff;
//     data['avg_rating'] = this.avgRating;
//     data['exclude'] = this.exclude;
//     data['wishlist'] = this.wishlist;
//     return data;
//   }
// }
//
// class Meta {
//   int? totalPage;
//   int? currentPage;
//   int? totalItem;
//   int? perPage;
//
//   Meta({this.totalPage, this.currentPage, this.totalItem, this.perPage});
//
//   Meta.fromJson(Map<String, dynamic> json) {
//     totalPage = json['total_page'];
//     currentPage = json['current_page'];
//     totalItem = json['total_item'];
//     perPage = json['per_page'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['total_page'] = this.totalPage;
//     data['current_page'] = this.currentPage;
//     data['total_item'] = this.totalItem;
//     data['per_page'] = this.perPage;
//     return data;
//   }
// }
//
// class Link {
//   bool? next;
//   bool? prev;
//
//   Link({this.next, this.prev});
//
//   Link.fromJson(Map<String, dynamic> json) {
//     next = json['next'];
//     prev = json['prev'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['next'] = this.next;
//     data['prev'] = this.prev;
//     return data;
//   }
// }

class FilterProductCategoryModel {
  bool? status;
  String? message;
  List<Data>? data;
  Meta? meta;
  Link? link;

  FilterProductCategoryModel(
      {this.status, this.message, this.data, this.meta, this.link});

  FilterProductCategoryModel.fromJson(Map<String, dynamic> json) {
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
  dynamic name;
  dynamic distance;
  dynamic time;
  dynamic time1;
  dynamic image;
  List<Award>? award;
  dynamic  rating;
  dynamic  countReviewData;
  dynamic  cookName;
  dynamic  description;
  bool? wishlist;
  bool? canDeliver;
  bool? sustainablePackagingStatus;
  dynamic profileImage;
  dynamic collection;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    distance = json['distance'];
    time = json['Time'];
    time1 = json['Time1'];
    image = json['image'];
    if (json['award'] != null) {
      award = <Award>[];
      json['award'].forEach((v) {
        award!.add(Award.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['distance'] = distance;
    data['Time'] = time;
    data['Time1'] = time1;
    data['image'] = image;
    if (award != null) {
      data['award'] = award!.map((v) => v.toJson()).toList();
    }
    data['rating'] = rating;
    data['count_review_Data'] = countReviewData;
    data['Cook name'] = cookName;
    data['description'] = description;
    data['wishlist'] = wishlist;
    data['can_deliver'] = canDeliver;
    data['sustainable_packaging_status'] = sustainablePackagingStatus;
    data['profile image'] = profileImage;
    data['collection'] = collection;
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


