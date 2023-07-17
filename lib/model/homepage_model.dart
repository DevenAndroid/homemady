class HomePageModel {
  bool? status;
  String? message;
  Data? data;

  HomePageModel({this.status, this.message, this.data});

  HomePageModel.fromJson(Map<String, dynamic> json) {
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
  List<SliderData>? sliderData;
  List<Stores>? stores;

  Data({this.sliderData, this.stores});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Slider Data'] != null) {
      sliderData = <SliderData>[];
      json['Slider Data'].forEach((v) {
        sliderData!.add(new SliderData.fromJson(v));
      });
    }
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(new Stores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sliderData != null) {
      data['Slider Data'] = this.sliderData!.map((v) => v.toJson()).toList();
    }
    if (this.stores != null) {
      data['stores'] = this.stores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SliderData {
  int? id;
  String? title;
  String? link;
  String? image;

  SliderData({this.id, this.title, this.link, this.image});

  SliderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    link = json['link'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['link'] = this.link;
    data['image'] = this.image;
    return data;
  }
}

class Stores {
  int? id;
  String? name;
  String? distance;
  String? image;
  //List<Null>? award;
  String? rating;
  String? countReviewData;
  String? cookName;
  String? profileImage;

  Stores(
      {this.id,
        this.name,
        this.distance,
        this.image,
       // this.award,
        this.rating,
        this.countReviewData,
        this.cookName,
        this.profileImage});

  Stores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    distance = json['distance'];
    image = json['image'];
   /* if (json['award'] != null) {
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
    /*if (this.award != null) {
      data['award'] = this.award!.map((v) => v.toJson()).toList();
    }*/
    data['rating'] = this.rating;
    data['count_review_Data'] = this.countReviewData;
    data['Cook name'] = this.cookName;
    data['profile image'] = this.profileImage;
    return data;
  }
}
