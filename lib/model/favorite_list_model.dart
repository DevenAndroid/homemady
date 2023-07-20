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
  //List<Null>? product;

  Data({this.store, //this.product
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['store'] != null) {
      store = <Store>[];
      json['store'].forEach((v) {
        store!.add(new Store.fromJson(v));
      });
    }
   /* if (json['product'] != null) {
      product = <Null>[];
      json['product'].forEach((v) {
        product!.add(new Null.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.store != null) {
      data['store'] = this.store!.map((v) => v.toJson()).toList();
    }
    /*if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class Store {
  int? id;
  String? name;
  String? distance;
  String? image;
  List<Null>? award;
  String? rating;
  String? countReviewData;
  String? cookName;
  String? profileImage;

  Store(
      {this.id,
        this.name,
        this.distance,
        this.image,
        this.award,
        this.rating,
        this.countReviewData,
        this.cookName,
        this.profileImage});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    distance = json['distance'];
    image = json['image'];
  /*  if (json['award'] != null) {
      award = <Null>[];
      json['award'].forEach((v) {
        award!.add(new Null.fromJson(v));
      });
    }*/
    rating = json['rating'];
    countReviewData = json['count_review_Data'];
    cookName = json['Cook name'];
    profileImage = json['profile image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['distance'] = this.distance;
    data['image'] = this.image;
  /*  if (this.award != null) {
      data['award'] = this.award!.map((v) => v.toJson()).toList();
    }*/
    data['rating'] = this.rating;
    data['count_review_Data'] = this.countReviewData;
    data['Cook name'] = this.cookName;
    data['profile image'] = this.profileImage;
    return data;
  }
}
