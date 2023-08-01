class MyCartListModel {
  bool? status;
  String? message;
  Data? data;

  MyCartListModel({this.status, this.message, this.data});

  MyCartListModel.fromJson(Map<String, dynamic> json) {
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
  int? orderCount;
  List<CartItems>? cartItems;
  CartPaymentSummary? cartPaymentSummary;
  OrderAddress? orderAddress;

  Data({this.orderCount,this.cartItems, this.cartPaymentSummary, this.orderAddress});

  Data.fromJson(Map<String, dynamic> json) {
    orderCount = json['orderCount'];
    if (json['cartItems'] != null) {
      cartItems = <CartItems>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
    cartPaymentSummary = json['cartPaymentSummary'] != null
        ? new CartPaymentSummary.fromJson(json['cartPaymentSummary'])
        : null;
    orderAddress = json['orderAddress'] != null
        ? new OrderAddress.fromJson(json['orderAddress'])
        : null;
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderCount'] = this.orderCount;
    if (this.cartItems != null) {
      data['cartItems'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    if (this.cartPaymentSummary != null) {
      data['cartPaymentSummary'] = this.cartPaymentSummary!.toJson();
    }
    if (this.orderAddress != null) {
      data['orderAddress'] = this.orderAddress!.toJson();
    }
    return data;
  }
}

class CartItems {
  dynamic id;
  dynamic productId;
  dynamic name;
  dynamic spiciness;
  dynamic price;
  dynamic cartItemQty;
  dynamic distance;
  dynamic totalPrice;
  dynamic image;

  CartItems(
      {this.id,
        this.productId,
        this.name,
        this.spiciness,
        this.price,
        this.cartItemQty,
        this.distance,
        this.totalPrice,
        this.image});

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    name = json['name'];
    spiciness = json['spiciness'];
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
    data['spiciness'] = this.spiciness;
    data['price'] = this.price;
    data['cart_item_qty'] = this.cartItemQty;
    data['distance'] = this.distance;
    data['total_price'] = this.totalPrice;
    data['image'] = this.image;
    return data;
  }
}

class CartPaymentSummary {
  dynamic subTotal;
  dynamic couponDiscount;
  dynamic couponCode;
  dynamic orderCount;
  dynamic freeDeliveryMinOrderValue;
  dynamic deliveryCharge;
  dynamic serviceCharge;
  dynamic packingFee;
  dynamic tax1;
  dynamic tax2;
  dynamic taxAndFee;
  dynamic total;

  CartPaymentSummary(
      {this.subTotal,
        this.couponDiscount,
        this.couponCode,
        this.orderCount,
        this.freeDeliveryMinOrderValue,
        this.deliveryCharge,
        this.serviceCharge,
        this.packingFee,
        this.tax1,
        this.tax2,
        this.taxAndFee,
        this.total});

  CartPaymentSummary.fromJson(Map<String, dynamic> json) {
    subTotal = json['subTotal'];
    couponDiscount = json['couponDiscount'];
    couponCode = json['couponCode'];
    orderCount = json['orderCount'];
    freeDeliveryMinOrderValue = json['free_delivery_min_order_value'];
    deliveryCharge = json['deliveryCharge'];
    serviceCharge = json['serviceCharge'];
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
    data['orderCount'] = this.orderCount;
    data['free_delivery_min_order_value'] = this.freeDeliveryMinOrderValue;
    data['deliveryCharge'] = this.deliveryCharge;
    data['serviceCharge'] = this.serviceCharge;
    data['packingFee'] = this.packingFee;
    data['tax_1'] = this.tax1;
    data['tax_2'] = this.tax2;
    data['tax_and_fee'] = this.taxAndFee;
    data['total'] = this.total;
    return data;
  }
}

class OrderAddress {
  dynamic id;
  dynamic userId;
  dynamic latitude;
  dynamic longitude;
  dynamic location;
  dynamic flatNo;
  dynamic landmark;
  dynamic addressType;
  dynamic createdAt;
  dynamic pinCode;
  dynamic updatedAt;
  dynamic deletedAt;

  OrderAddress(
      {this.id,
        this.userId,
        this.latitude,
        this.longitude,
        this.location,
        this.flatNo,
        this.landmark,
        this.pinCode,
        this.addressType,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  OrderAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    pinCode = json['pin_code'];
    flatNo = json['flat_no'];
    landmark = json['landmark'];
    addressType = json['address_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['flat_no'] = this.flatNo;
    data['pin_code'] = this.pinCode;
    data['landmark'] = this.landmark;
    data['address_type'] = this.addressType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
