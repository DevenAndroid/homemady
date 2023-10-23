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
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['name'] = name;
    data['price'] = price;
    data['cart_item_qty'] = cartItemQty;
    data['total_price'] = totalPrice;
    data['image'] = image;
    return data;
  }
}
