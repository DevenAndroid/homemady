import 'favorite_list_model.dart';

class FeaturedFilterModel {
  bool? status;
  String? message;
  List<Data>? data;
  Meta? meta;
  Link? link;

  FeaturedFilterModel(
      {this.status, this.message, this.data, this.meta, this.link});

  FeaturedFilterModel.fromJson(Map<String, dynamic> json) {
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
  dynamic rating;
  dynamic countReviewData;
  dynamic cookName;
  bool? sustainablePackagingStatus;
  bool? wishlist;
  dynamic profileImage;
  String? collection;

  Data(
      {this.id,
        this.name,
        this.distance,
        this.image,
        this.time,
        this.time1,
        this.award,
        this.rating,
        this.collection,
        this.countReviewData,
        this.sustainablePackagingStatus,
        this.cookName,
        this.wishlist,
        this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['Time'];
    time1 = json['Time1'];
    name = json['name'];
    distance = json['distance'];
    collection = json['collection'];
    image = json['image'];
    if (json['award'] != null) {
      award = <Award>[];
      json['award'].forEach((v) {
        award!.add(Award.fromJson(v));
      });
    }
    rating = json['rating'];
    sustainablePackagingStatus = json['sustainable_packaging_status'];
    countReviewData = json['count_review_Data'];
    cookName = json['Cook name'];
    wishlist = json['wishlist'];
    profileImage = json['profile image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['collection'] = collection;
    data['distance'] = distance;
    data['image'] = image;
    if (award != null) {
      data['award'] = award!.map((v) => v.toJson()).toList();
    }
    data['rating'] = rating;
    data['sustainable_packaging_status'] = sustainablePackagingStatus;
    data['count_review_Data'] = countReviewData;
    data['Cook name'] = cookName;
    data['wishlist'] = wishlist;
    data['profile image'] = profileImage;
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
