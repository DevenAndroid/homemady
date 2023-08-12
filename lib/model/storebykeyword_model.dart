class StorebyKeywords {
  bool? status;
  String? message;
  Data? data;

  StorebyKeywords({this.status, this.message, this.data});

  StorebyKeywords.fromJson(Map<String, dynamic> json) {
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
  List<ProductOption>? productOption;

  Data({this.productOption});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['ProductOption'] != null) {
      productOption = <ProductOption>[];
      json['ProductOption'].forEach((v) {
        productOption!.add(new ProductOption.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productOption != null) {
      data['ProductOption'] =
          this.productOption!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductOption {
  int? id;
  String? title;

  ProductOption({this.id, this.title});

  ProductOption.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
