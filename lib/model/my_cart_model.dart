class MyCartModel {
  bool? status;
  String? message;
  Data? data;

  MyCartModel({this.status, this.message, this.data});

  MyCartModel.fromJson(Map<String, dynamic> json) {
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
  List<CartItems>? cartItems;
  CartPaymentSummary? cartPaymentSummary;
  Null? orderAddress;

  Data({this.cartItems, this.cartPaymentSummary, this.orderAddress});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cartItems'] != null) {
      cartItems = <CartItems>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
    cartPaymentSummary = json['cartPaymentSummary'] != null
        ? new CartPaymentSummary.fromJson(json['cartPaymentSummary'])
        : null;
    orderAddress = json['orderAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartItems != null) {
      data['cartItems'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    if (this.cartPaymentSummary != null) {
      data['cartPaymentSummary'] = this.cartPaymentSummary!.toJson();
    }
    data['orderAddress'] = this.orderAddress;
    return data;
  }
}

class CartItems {
  int? id;
  int? productId;
  String? name;
  int? price;
  int? cartItemQty;
  int? distance;
  int? totalPrice;
  String? image;

  CartItems(
      {this.id,
        this.productId,
        this.name,
        this.price,
        this.cartItemQty,
        this.distance,
        this.totalPrice,
        this.image});

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    name = json['name'];
    price = json['price'];
    cartItemQty = json['cart_item_qty'];
    distance = json['distance'];
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
    data['distance'] = this.distance;
    data['total_price'] = this.totalPrice;
    data['image'] = this.image;
    return data;
  }
}

class CartPaymentSummary {
  int? subTotal;
  int? couponDiscount;
  String? couponCode;
  String? driverCommission;
  String? freeDeliveryMinOrderValue;
  int? deliveryCharge;
  String? surCharge;
  int? tipAmount;
  String? packingFee;
  Null? tax1;
  Null? tax2;
  int? taxAndFee;
  int? total;

  CartPaymentSummary(
      {this.subTotal,
        this.couponDiscount,
        this.couponCode,
        this.driverCommission,
        this.freeDeliveryMinOrderValue,
        this.deliveryCharge,
        this.surCharge,
        this.tipAmount,
        this.packingFee,
        this.tax1,
        this.tax2,
        this.taxAndFee,
        this.total});

  CartPaymentSummary.fromJson(Map<String, dynamic> json) {
    subTotal = json['subTotal'];
    couponDiscount = json['couponDiscount'];
    couponCode = json['couponCode'];
    driverCommission = json['driver_commission'];
    freeDeliveryMinOrderValue = json['free_delivery_min_order_value'];
    deliveryCharge = json['deliveryCharge'];
    surCharge = json['surCharge'];
    tipAmount = json['tipAmount'];
    packingFee = json['packingFee'];
    tax1 = json['tax_1'];
    tax2 = json['tax_2'];
    taxAndFee = json['tax_and_fee'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subTotal'] = this.subTotal;
    data['couponDiscount'] = this.couponDiscount;
    data['couponCode'] = this.couponCode;
    data['driver_commission'] = this.driverCommission;
    data['free_delivery_min_order_value'] = this.freeDeliveryMinOrderValue;
    data['deliveryCharge'] = this.deliveryCharge;
    data['surCharge'] = this.surCharge;
    data['tipAmount'] = this.tipAmount;
    data['packingFee'] = this.packingFee;
    data['tax_1'] = this.tax1;
    data['tax_2'] = this.tax2;
    data['tax_and_fee'] = this.taxAndFee;
    data['total'] = this.total;
    return data;
  }
}
