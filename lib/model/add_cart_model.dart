class AddCartModel {
  bool? status;
  String? message;
  List<Data>? data;

  AddCartModel({this.status, this.message, this.data});

  AddCartModel.fromJson(Map<String, dynamic> json) {
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
  dynamic productId;
  dynamic  name;
  dynamic price;
  dynamic cartItemQty;
  dynamic totalPrice;
  dynamic image;
  Data(
      {this.id,
        this.productId,
        this.name,
        this.price,
        this.cartItemQty,
        this.totalPrice,
        this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    name = json['name'];
    price = json['price'];
    cartItemQty = json['cart_item_qty'];
    totalPrice = json['total_price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['cart_item_qty'] = this.cartItemQty;
    data['total_price'] = this.totalPrice;
    data['image'] = this.image;
    return data;
  }
}
