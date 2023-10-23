import 'my_order_model.dart';

class CheckoutOrderModel {
  bool? status;
  String? message;
  Data? data;

  CheckoutOrderModel({this.status, this.message, this.data});

  CheckoutOrderModel.fromJson(Map<String, dynamic> json) {
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
  OrderDetail? orderDetail;
  dynamic orderId;
  dynamic itemTotal;
  dynamic tax;
  dynamic deliveryCharges;
  dynamic packingFee;
  dynamic couponDiscount;
  dynamic grandTotal;
  dynamic user;
 /* Null? vendor;
  Null? driver;*/
  dynamic address;
  dynamic orderType;
  dynamic deliveryStatus;
  List<OrderItems>? orderItems;
  dynamic placedAt;

  Data(
      {this.orderDetail,
        this.orderId,
        this.itemTotal,
        this.tax,
        this.deliveryCharges,
        this.packingFee,
        this.couponDiscount,
        this.grandTotal,
        this.user,
       // this.vendor,
       // this.driver,
        this.address,
        this.orderType,
        this.deliveryStatus,
        this.orderItems,
        this.placedAt});

  Data.fromJson(Map<String, dynamic> json) {
    orderDetail = json['orderDetail'] != null
        ? OrderDetail.fromJson(json['orderDetail'])
        : null;
    orderId = json['order_id'];
    itemTotal = json['item_total'];
    tax = json['tax'];
    deliveryCharges = json['delivery_charges'];
    packingFee = json['packing_fee'];
    couponDiscount = json['coupon_discount'];
    grandTotal = json['grand_total'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
   // vendor = json['vendor'];
   // driver = json['driver'];
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    orderType = json['order_type'];
    deliveryStatus = json['delivery_status'];
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
    placedAt = json['placed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderDetail != null) {
      data['orderDetail'] = orderDetail!.toJson();
    }
    data['order_id'] = orderId;
    data['item_total'] = itemTotal;
    data['tax'] = tax;
    data['delivery_charges'] = deliveryCharges;
    data['packing_fee'] = packingFee;
    data['coupon_discount'] = couponDiscount;
    data['grand_total'] = grandTotal;
    if (user != null) {
      data['user'] = user!.toJson();
    }
   // data['vendor'] = this.vendor;
   // data['driver'] = this.driver;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['order_type'] = orderType;
    data['delivery_status'] = deliveryStatus;
    if (orderItems != null) {
      data['order_items'] = orderItems!.map((v) => v.toJson()).toList();
    }
    data['placed_at'] = placedAt;
    return data;
  }
}

class OrderDetail {
  dynamic orderId;
  dynamic itemTotal;
  dynamic muncipalTax;
  dynamic stateTax;
  dynamic grandTotal;
  User? user;
  Vendor? vendor;
  dynamic orderType;
  dynamic deliveryStatus;
  List<OrderItems>? orderItems;
  dynamic placedAt;

  OrderDetail(
      {this.orderId,
        this.itemTotal,
        this.muncipalTax,
        this.stateTax,
        this.grandTotal,
        this.user,
        this.vendor,
        this.orderType,
        this.deliveryStatus,
        this.orderItems,
        this.placedAt});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    itemTotal = json['item_total'];
    muncipalTax = json['muncipal_tax'];
    stateTax = json['state_tax'];
    grandTotal = json['grand_total'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    vendor =
    json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null;
    orderType = json['order_type'];
    deliveryStatus = json['delivery_status'];
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
    placedAt = json['placed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['item_total'] = itemTotal;
    data['muncipal_tax'] = muncipalTax;
    data['state_tax'] = stateTax;
    data['grand_total'] = grandTotal;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (vendor != null) {
      data['vendor'] = vendor!.toJson();
    }
    data['order_type'] = orderType;
    data['delivery_status'] = deliveryStatus;
    if (orderItems != null) {
      data['order_items'] = orderItems!.map((v) => v.toJson()).toList();
    }
    data['placed_at'] = placedAt;
    return data;
  }
}

class User {
  dynamic id;
  bool? isDriver;
  bool? isVendor;
 dynamic latitude;
 dynamic longitude;
 dynamic location;
 dynamic name;
 dynamic lastName;
 dynamic email;
 dynamic phone;
 dynamic walletBalance;
 dynamic earnedBalance;
 dynamic profileImage;
 dynamic referalCode;
  bool? isDriverOnline;
  bool? isVendorOnline;
  dynamic deliveryRange;
  bool? selfDelivery;
  bool? asDriverVerified;
  bool? asVendorVerified;
  bool? isProfileComplete;

  User(
      {this.id,
        this.isDriver,
        this.isVendor,
        this.latitude,
        this.longitude,
        this.location,
        this.name,
        this.lastName,
        this.email,
        this.phone,
        this.walletBalance,
        this.earnedBalance,
        this.profileImage,
        this.referalCode,
        this.isDriverOnline,
        this.isVendorOnline,
        this.deliveryRange,
        this.selfDelivery,
        this.asDriverVerified,
        this.asVendorVerified,
        this.isProfileComplete});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isDriver = json['is_driver'];
    isVendor = json['is_vendor'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    name = json['name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    walletBalance = json['wallet_balance'];
    earnedBalance = json['earned_balance'];
    profileImage = json['profile_image'];
    referalCode = json['referal_code'];
    isDriverOnline = json['is_driver_online'];
    isVendorOnline = json['is_vendor_online'];
    deliveryRange = json['delivery_range'];
    selfDelivery = json['self_delivery'];
    asDriverVerified = json['as_driver_verified'];
    asVendorVerified = json['as_vendor_verified'];
    isProfileComplete = json['is_profile_complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_driver'] = isDriver;
    data['is_vendor'] = isVendor;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['location'] = location;
    data['name'] = name;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['wallet_balance'] = walletBalance;
    data['earned_balance'] = earnedBalance;
    data['profile_image'] = profileImage;
    data['referal_code'] = referalCode;
    data['is_driver_online'] = isDriverOnline;
    data['is_vendor_online'] = isVendorOnline;
    data['delivery_range'] = deliveryRange;
    data['self_delivery'] = selfDelivery;
    data['as_driver_verified'] = asDriverVerified;
    data['as_vendor_verified'] = asVendorVerified;
    data['is_profile_complete'] = isProfileComplete;
    return data;
  }
}

class Address {
  dynamic id;
  dynamic userId;
  dynamic latitude;
  dynamic longitude;
  dynamic location;
  dynamic flatNo;
  dynamic landmark;
  dynamic addressType;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  Address(
      {this.id,
        this.userId,
        this.latitude,
        this.longitude,
        this.location,
        this.flatNo,
        this.landmark,
        this.addressType,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
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
    data['landmark'] = landmark;
    data['address_type'] = addressType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class OrderItems {
  dynamic id;
  dynamic productId;
  dynamic productName;
  dynamic price;
  dynamic qty;
  dynamic totalPrice;
  dynamic status;
  dynamic specialRequets;

  OrderItems(
      {this.id,
        this.productId,
        this.productName,
        this.price,
        this.qty,
        this.totalPrice,
        this.status,
        this.specialRequets});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    price = json['price'];
    qty = json['qty'];
    totalPrice = json['total_price'];
    status = json['status'];
    specialRequets = json['special_requets'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['price'] = price;
    data['qty'] = qty;
    data['total_price'] = totalPrice;
    data['status'] = status;
    data['special_requets'] = specialRequets;
    return data;
  }
}
