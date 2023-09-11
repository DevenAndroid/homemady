class FeedBackModel {
  bool? status;
  String? message;
  Data? data;

  FeedBackModel({this.status, this.message, this.data});

  FeedBackModel.fromJson(Map<String, dynamic> json) {
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
  List<ReviewsList>? reviewsList;
  String? avgRating;
  List<TotalReviews>? totalReviews;
  dynamic reviewsCount;

  Data(
      {this.reviewsList, this.avgRating, this.totalReviews, this.reviewsCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['reviewsList'] != null) {
      reviewsList = <ReviewsList>[];
      json['reviewsList'].forEach((v) {
        reviewsList!.add(new ReviewsList.fromJson(v));
      });
    }
    avgRating = json['avg_rating'];
    if (json['totalReviews'] != null) {
      totalReviews = <TotalReviews>[];
      json['totalReviews'].forEach((v) {
        totalReviews!.add(new TotalReviews.fromJson(v));
      });
    }
    reviewsCount = json['ReviewsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reviewsList != null) {
      data['reviewsList'] = this.reviewsList!.map((v) => v.toJson()).toList();
    }
    data['avg_rating'] = this.avgRating;
    if (this.totalReviews != null) {
      data['totalReviews'] = this.totalReviews!.map((v) => v.toJson()).toList();
    }
    data['ReviewsCount'] = this.reviewsCount;
    return data;
  }
}

class ReviewsList {
  dynamic id;
  dynamic userName;
  dynamic profileImage;
  dynamic review;
  dynamic rating;
  dynamic isDelivery;
  dynamic date;

  ReviewsList(
      {this.id,
        this.userName,
        this.profileImage,
        this.review,
        this.rating,
        this.isDelivery,
        this.date});

  ReviewsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    profileImage = json['profile_image'];
    review = json['review'];
    rating = json['rating'];
    isDelivery = json['is_delivery'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['profile_image'] = this.profileImage;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['is_delivery'] = this.isDelivery;
    data['date'] = this.date;
    return data;
  }
}

class TotalReviews {
  dynamic avg;
  dynamic title;

  TotalReviews({this.avg, this.title});

  TotalReviews.fromJson(Map<String, dynamic> json) {
    avg = json['avg'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avg'] = this.avg;
    data['title'] = this.title;
    return data;
  }
}
