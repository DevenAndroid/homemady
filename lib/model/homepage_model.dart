class HomePageModel {
  bool? status;
  String? message;
  Data? data;
  Meta? meta;
  Link? link;

  HomePageModel({this.status, this.message, this.data, this.meta, this.link});

  HomePageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null && json['data'].toString() != "[]" ? Data.fromJson(json['data']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    link = json['link'] != null ? Link.fromJson(json['link']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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
  List<SliderData>? sliderData;
  List<Stores>? stores;

  Data({this.sliderData, this.stores});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sliderData'] != null) {
      sliderData = <SliderData>[];
      json['sliderData'].forEach((v) {
        sliderData!.add(SliderData.fromJson(v));
      });
    }
    sliderData ??= [];
    sliderData = sliderData!.where((element) => element.storeId.toString().isNotEmpty).toList();
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(Stores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sliderData != null) {
      data['sliderData'] = sliderData!.map((v) => v.toJson()).toList();
    }
    if (stores != null) {
      data['stores'] = stores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SliderData {
  int? id;
  dynamic storeId;
  String? title;
  String? link;
  String? image;

  SliderData({this.id, this.title, this.link, this.image});

  SliderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'] ?? "";
    title = json['title'];
    link = json['link'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['store_id'] = storeId;
    data['title'] = title;
    data['link'] = link;
    data['image'] = image;
    return data;
  }
}

class Stores {
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
  dynamic collection;
  bool ? sustainablePackagingStatus;
  bool? wishlist;
  dynamic profileImage;

  Stores(
      {this.id,
        this.name,
        this.distance,
        this.time,
        this.image,
        this.award,
        this.rating,
        this.collection,
        this.sustainablePackagingStatus,
        this.countReviewData,
        this.cookName,
        this.wishlist,
        this.time1,
        this.profileImage});

  Stores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    distance = json['distance'];
    collection = json['collection'];
    sustainablePackagingStatus = json['sustainable_packaging_status'];
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
    wishlist = json['wishlist'];
    time = json['Time'];
    time1 = json['Time1'];
    profileImage = json['profile image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['distance'] = distance;
    data['Time'] = time;
    data['sustainable_packaging_status'] = sustainablePackagingStatus;
    data['image'] = image;
    if (award != null) {
      data['award'] = award!.map((v) => v.toJson()).toList();
    }
    data['rating'] = rating;
    data['collection'] = collection;
    data['count_review_Data'] = countReviewData;
    data['Cook name'] = cookName;
    data['wishlist'] = wishlist;
    data['Time1'] = time1;
    data['profile image'] = profileImage;
    return data;
  }
}

class Award {
  String? title;
  String? image;

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
