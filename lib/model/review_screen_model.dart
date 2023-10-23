class FeedBackModel {
  bool? status;
  String? message;
  Data? data;

  FeedBackModel({this.status, this.message, this.data});

  FeedBackModel.fromJson(Map<String, dynamic> json) {
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
        reviewsList!.add(ReviewsList.fromJson(v));
      });
    }
    avgRating = json['avg_rating'];
    if (json['totalReviews'] != null) {
      totalReviews = <TotalReviews>[];
      json['totalReviews'].forEach((v) {
        totalReviews!.add(TotalReviews.fromJson(v));
      });
    }
    reviewsCount = json['ReviewsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reviewsList != null) {
      data['reviewsList'] = reviewsList!.map((v) => v.toJson()).toList();
    }
    data['avg_rating'] = avgRating;
    if (totalReviews != null) {
      data['totalReviews'] = totalReviews!.map((v) => v.toJson()).toList();
    }
    data['ReviewsCount'] = reviewsCount;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_name'] = userName;
    data['profile_image'] = profileImage;
    data['review'] = review;
    data['rating'] = rating;
    data['is_delivery'] = isDelivery;
    data['date'] = date;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avg'] = avg;
    data['title'] = title;
    return data;
  }
}
