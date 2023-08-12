class FilterModel {
  bool? status;
  String? message;
  List<Data>? data;

  FilterModel({this.status, this.message, this.data});

  FilterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic name;
  dynamic distance;
  dynamic image;
  List<Null>? award;
  dynamic rating;
  dynamic countReviewData;
  dynamic cookName;
  bool? wishlist;
  dynamic profileImage;

  Data(
      {this.id,
        this.name,
        this.distance,
        this.image,
        this.award,
        this.rating,
        this.countReviewData,
        this.cookName,
        this.wishlist,
        this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    distance = json['distance'];
    image = json['image'];
    if (json['award'] != null) {
      award = <Null>[];
      json['award'].forEach((v) {
        //award!.add(new Null.fromJson(v));
      });
    }
    rating = json['rating'];
    countReviewData = json['count_review_Data'];
    cookName = json['Cook name'];
    wishlist = json['wishlist'];
    profileImage = json['profile image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['distance'] = this.distance;
    data['image'] = this.image;
    if (this.award != null) {
      //data['award'] = this.award!.map((v) => v.toJson()).toList();
    }
    data['rating'] = this.rating;
    data['count_review_Data'] = this.countReviewData;
    data['Cook name'] = this.cookName;
    data['wishlist'] = this.wishlist;
    data['profile image'] = this.profileImage;
    return data;
  }
}
