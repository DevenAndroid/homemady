class RatingGetModel {
  bool? status;
  String? message;
  Data? data;
  Meta? meta;
  Link? link;

  RatingGetModel({this.status, this.message, this.data, this.meta, this.link});

  RatingGetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    link = json['link'] != null ? new Link.fromJson(json['link']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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
  List<Reviews>? reviews;
  String? avgRating;
  int? foodQuality;
  int? foodQuantity;
  int? communication;
  int? hygiene;

  Data(
      {this.reviews,
        this.avgRating,
        this.foodQuality,
        this.foodQuantity,
        this.communication,
        this.hygiene});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    avgRating = json['avg_rating'];
    foodQuality = json['foodQuality'];
    foodQuantity = json['FoodQuantity'];
    communication = json['Communication'];
    hygiene = json['Hygiene'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    data['avg_rating'] = this.avgRating;
    data['foodQuality'] = this.foodQuality;
    data['FoodQuantity'] = this.foodQuantity;
    data['Communication'] = this.communication;
    data['Hygiene'] = this.hygiene;
    return data;
  }
}

class Reviews {
  int? id;
  String? userName;
  String? profileImage;
  String? review;
  String? rating;
  String? date;

  Reviews(
      {this.id,
        this.userName,
        this.profileImage,
        this.review,
        this.rating,
        this.date});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    profileImage = json['profile_image'];
    review = json['review'];
    rating = json['rating'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['profile_image'] = this.profileImage;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['date'] = this.date;
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
