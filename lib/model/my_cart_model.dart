class MyCartListModel {
  bool? status;
  String? message;
  Data? data;

  MyCartListModel({this.status, this.message, this.data});

  MyCartListModel.fromJson(Map<String, dynamic> json) {
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
        cartItems!.add(CartItems.fromJson(v));
      });
    }
    cartPaymentSummary = json['cartPaymentSummary'] != null
        ? CartPaymentSummary.fromJson(json['cartPaymentSummary'])
        : null;
    orderAddress = json['orderAddress'] != null
        ? OrderAddress.fromJson(json['orderAddress'])
        : null;
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderCount'] = orderCount;
    if (cartItems != null) {
      data['cartItems'] = cartItems!.map((v) => v.toJson()).toList();
    }
    if (cartPaymentSummary != null) {
      data['cartPaymentSummary'] = cartPaymentSummary!.toJson();
    }
    if (orderAddress != null) {
      data['orderAddress'] = orderAddress!.toJson();
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
  dynamic subTitle;
  dynamic cartItemQty;
  dynamic distance;
  dynamic totalPrice;
  dynamic image;
  dynamic productQty;
  bool? collectionStatus;
  bool? deliveryStatus;
  bool? selfDelivery;

  int productCount = 0;
  CartItems(
      {this.id,
        this.productId,
        this.name,
        this.spiciness,
        this.price,
        this.selfDelivery,
        this.cartItemQty,
        this.distance,
        this.deliveryStatus,
        this.subTitle,
        this.totalPrice,
        this.collectionStatus,
        this.productQty,
        this.image});

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    name = json['name'];
    spiciness = json['spiciness'];
    subTitle = json['subTitle'];
    price = json['price'];
    cartItemQty = json['cart_item_qty'];
    distance = json['distance'];
    totalPrice = json['total_price'];
    image = json['image'];
    productQty = json['product_qty'];
    selfDelivery = json['self_delivery'];
    collectionStatus = json['collection_status'];
    deliveryStatus = json['delivery_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['name'] = name;
    data['subTitle'] = subTitle;
    data['spiciness'] = spiciness;
    data['price'] = price;
    data['self_delivery'] = selfDelivery;
    data['cart_item_qty'] = cartItemQty;
    data['distance'] = distance;
    data['total_price'] = totalPrice;
    data['image'] = image;
    data['product_qty'] = productQty;
    data['collection_status'] = collectionStatus;
    data['delivery_status'] = deliveryStatus;
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
  dynamic minOrderCharge;
  dynamic tax1;
  dynamic tax2;
  dynamic taxAndFee;
  dynamic total;
  dynamic tipAmount;

  CartPaymentSummary(
      {this.subTotal,
        this.couponDiscount,
        this.couponCode,
        this.orderCount,
        this.minOrderCharge,
        this.freeDeliveryMinOrderValue,
        this.deliveryCharge,
        this.serviceCharge,
        this.packingFee,
        this.tax1,
        this.tax2,
        this.taxAndFee,
        this.tipAmount,
        this.total});

  CartPaymentSummary.fromJson(Map<String, dynamic> json) {
    subTotal = json['subTotal'];
    couponDiscount = json['couponDiscount'];
    couponCode = json['couponCode'];
    orderCount = json['orderCount'];
    tipAmount = json['tipAmount'];
    freeDeliveryMinOrderValue = json['free_delivery_min_order_value'];
    deliveryCharge = json['deliveryCharge'];
    serviceCharge = json['serviceCharge'];
    packingFee = json['packingFee'];
    minOrderCharge = json['min_order_charge'];
    tax1 = json['tax_1'];
    tax2 = json['tax_2'];
    taxAndFee = json['tax_and_fee'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subTotal'] = subTotal;
    data['couponDiscount'] = couponDiscount;
    data['couponCode'] = couponCode;
    data['orderCount'] = orderCount;
    data['tipAmount'] = tipAmount;
    data['free_delivery_min_order_value'] = freeDeliveryMinOrderValue;
    data['deliveryCharge'] = deliveryCharge;
    data['min_order_charge'] = minOrderCharge;
    data['serviceCharge'] = serviceCharge;
    data['packingFee'] = packingFee;
    data['tax_1'] = tax1;
    data['tax_2'] = tax2;
    data['tax_and_fee'] = taxAndFee;
    data['total'] = total;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['location'] = location;
    data['flat_no'] = flatNo;
    data['pin_code'] = pinCode;
    data['landmark'] = landmark;
    data['address_type'] = addressType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
