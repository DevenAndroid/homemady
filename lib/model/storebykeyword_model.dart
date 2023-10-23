class StorebyKeywords {
  bool? status;
  String? message;
  Data? data;

  StorebyKeywords({this.status, this.message, this.data});

  StorebyKeywords.fromJson(Map<String, dynamic> json) {
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
  List<ProductOption>? productOption;

  Data({this.productOption});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['ProductOption'] != null) {
      productOption = <ProductOption>[];
      json['ProductOption'].forEach((v) {
        productOption!.add(ProductOption.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productOption != null) {
      data['ProductOption'] =
          productOption!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}
