class OrderDetailsModel {
  bool? status;
  String? message;
  OrderDetail? orderDetail;
  String vendorID ="";

  OrderDetailsModel({this.status, this.message, this.orderDetail});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    orderDetail = json['data'] != null ? OrderDetail.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (orderDetail != null) {
      data['data'] = orderDetail!.toJson();
    }
    return data;
  }
}

class OrderDetail {

  String vendorID ="";
  dynamic orderId;
  dynamic itemTotal;
  dynamic tax;
  dynamic deliveryCharges;
  dynamic packingFee;
  dynamic tipAmount;
  CouponDiscount? couponDiscount;
  dynamic serviceCharge;
  dynamic grandTotal;
  dynamic deliveryType;
  dynamic minOrderCharge;
  dynamic specialRequets;
  dynamic deliveryTime;
  dynamic instructionForDelivery;
  User? user;
  Vendor? vendor;
  Driver? driver;
  Address? address;
  dynamic orderType;
  dynamic deliveryStatus;
  dynamic feedback;
  List<OrderItems>? orderItems;
  dynamic placedAt;

  OrderDetail(
      {this.orderId,
        this.itemTotal,
        this.tax,
        this.deliveryCharges,
        this.tipAmount,
        this.packingFee,
        this.couponDiscount,
        this.grandTotal,
        this.deliveryType,
        this.minOrderCharge,
        this.user,
        this.vendor,
        this.specialRequets,
        this.serviceCharge,
        this.driver,
        this.address,
        this.deliveryTime,
        this.instructionForDelivery,
        this.orderType,
        this.deliveryStatus,
        this.feedback,
        this.orderItems,
        this.placedAt});

  OrderDetail.fromJson(Map<dynamic, dynamic> json) {
    orderId = json['order_id'];
    itemTotal = json['item_total'];
    tax = json['tax'];
    deliveryCharges = json['delivery_charges'];
    tipAmount = json['tip_amount'];
    deliveryType = json['delivery_type'];
    minOrderCharge = json['min_order_charge'];
    deliveryTime = json['delivery_time'];
    packingFee = json['packing_fee'];
    couponDiscount = json['coupon_discount'] != null
        ? CouponDiscount.fromJson(json['coupon_discount'])
        : null;
    minOrderCharge = json['min_order_charge'];
    serviceCharge = json['service_charge'];
    specialRequets = json['special_requets'];
    instructionForDelivery = json['instruction_for_delivery'];
    grandTotal = json['grand_total'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    vendor =
    json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null;
    driver =
    json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    user = json['driver'] != null ? User.fromJson(json['driver']) : null;
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
    feedback = json['feedback'];
    placedAt = json['placed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['item_total'] = itemTotal;
    data['tax'] = tax;
    data['service_charge'] = serviceCharge;
    data['delivery_charges'] = deliveryCharges;
    data['min_order_charge'] = minOrderCharge;
    data['tip_amount'] = tipAmount;
    data['delivery_time'] = deliveryTime;
    data['special_requets'] = specialRequets;
    data['packing_fee'] = packingFee;
    data['delivery_type'] = deliveryType;
    data['min_order_charge'] = minOrderCharge;
    if (couponDiscount != null) {
      data['coupon_discount'] = couponDiscount!.toJson();
    }
    data['grand_total'] = grandTotal;
    data['instruction_for_delivery'] = instructionForDelivery;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (vendor != null) {
      data['vendor'] = vendor!.toJson();
    }
    if (driver != null) {
      data['driver'] = driver!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['order_type'] = orderType;
    data['delivery_status'] = deliveryStatus;
    data['feedback'] = feedback;
    if (orderItems != null) {
      data['order_items'] = orderItems!.map((v) => v.toJson()).toList();
    }
    data['placed_at'] = placedAt;
    return data;
  }
}
class CouponDiscount {
  dynamic id;
  dynamic userId;
  dynamic couponCode;
  dynamic discountType;
  dynamic discountedPrice;
  dynamic createdAt;
  dynamic updatedAt;

  CouponDiscount(
      {this.id,
        this.userId,
        this.couponCode,
        this.discountType,
        this.discountedPrice,
        this.createdAt,
        this.updatedAt});

  CouponDiscount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    couponCode = json['coupon_code'];
    discountType = json['discount_type'];
    discountedPrice = json['discounted_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['coupon_code'] = couponCode;
    data['discount_type'] = discountType;
    data['discounted_price'] = discountedPrice;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
  int? deliveryRange;
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

class Driver {
  int? id;
  bool? isDriver;
  bool? isVendor;
  String? latitude;
  String? longitude;
  String? location;
  String? name;
  String? lastName;
  String? email;
  String? countryCode;
  String? phone;
  // List<Null>? defaultAddress;
  String? walletBalance;
  String? earnedBalance;
  String? profileImage;
  String? referalCode;
  bool? isDriverOnline;
  bool? isVendorOnline;
  int? deliveryRange;
  bool? selfDelivery;
  bool? asDriverVerified;
  bool? asVendorVerified;
  bool? isProfileComplete;

  Driver(
      {this.id,
        this.isDriver,
        this.isVendor,
        this.latitude,
        this.longitude,
        this.location,
        this.name,
        this.lastName,
        this.email,
        this.countryCode,
        this.phone,
        // this.defaultAddress,
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

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isDriver = json['is_driver'];
    isVendor = json['is_vendor'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    name = json['name'];
    lastName = json['last_name'];
    email = json['email'];
    countryCode = json['country_code'];
    phone = json['phone'];
    // if (json['default_address '] != null) {
    //   defaultAddress = <Null>[];
    //   json['default_address '].forEach((v) {
    //     defaultAddress!.add(new Null.fromJson(v));
    //   });
    // }
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_driver'] = this.isDriver;
    data['is_vendor'] = this.isVendor;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    // if (this.defaultAddress != null) {
    //   data['default_address '] =
    //       this.defaultAddress!.map((v) => v.toJson()).toList();
    // }
    data['wallet_balance'] = this.walletBalance;
    data['earned_balance'] = this.earnedBalance;
    data['profile_image'] = this.profileImage;
    data['referal_code'] = this.referalCode;
    data['is_driver_online'] = this.isDriverOnline;
    data['is_vendor_online'] = this.isVendorOnline;
    data['delivery_range'] = this.deliveryRange;
    data['self_delivery'] = this.selfDelivery;
    data['as_driver_verified'] = this.asDriverVerified;
    data['as_vendor_verified'] = this.asVendorVerified;
    data['is_profile_complete'] = this.isProfileComplete;
    return data;
  }
}

class Vendor {
  dynamic storeId;
  dynamic id;
  dynamic storeName;
  dynamic number;
  dynamic ppsNo;
  dynamic category;
  dynamic secondarycategory;
  dynamic tertiarycategory;
  dynamic collection;
  dynamic phone;
  dynamic storeImage;
  dynamic location;
  dynamic latitude;
  dynamic longitude;
  dynamic deliveryRange;
  dynamic ppsCardImage;
  dynamic remark;
  bool? status;

  Vendor(
      {this.storeId,
        this.id,
        this.storeName,
        this.number,
        this.ppsNo,
        this.category,
        this.secondarycategory,
        this.tertiarycategory,
        this.collection,
        this.phone,
        this.storeImage,
        this.location,
        this.latitude,
        this.longitude,
        this.deliveryRange,
        this.ppsCardImage,
        this.remark,
        this.status});

  Vendor.fromJson(Map<String, dynamic> json) {
    storeId = json['storeId'];
    id = json['id'];
    storeName = json['store_name'];
    number = json['number'];
    ppsNo = json['pps_no'];
    category = json['category'];
    secondarycategory = json['secondarycategory'];
    tertiarycategory = json['tertiarycategory'];
    collection = json['collection'];
    phone = json['phone'];
    storeImage = json['storeImage'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    deliveryRange = json['delivery_range'];
    ppsCardImage = json['pps_card_image'];
    remark = json['remark'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storeId'] = storeId;
    data['id'] = id;
    data['store_name'] = storeName;
    data['number'] = number;
    data['pps_no'] = ppsNo;
    data['category'] = category;
    data['secondarycategory'] = secondarycategory;
    data['tertiarycategory'] = tertiarycategory;
    data['collection'] = collection;
    data['phone'] = phone;
    data['storeImage'] = storeImage;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['delivery_range'] = deliveryRange;
    data['pps_card_image'] = ppsCardImage;
    data['remark'] = remark;
    data['status'] = status;
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
  dynamic productImage;
  dynamic price;
  dynamic qty;
  dynamic sizeQuantity;
  dynamic sizeId;
  dynamic totalPrice;
  dynamic status;
  dynamic specialRequets;

  OrderItems(
      {this.id,
        this.productId,
        this.productName,
        this.price,
        this.qty,
        this.productImage,
        this.sizeQuantity,
        this.sizeId,
        this.totalPrice,
        this.status,
        this.specialRequets});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    price = json['price'];
    sizeId = json['size_id'];
    sizeQuantity = json['size_quantity'];
    qty = json['qty'];
    productImage = json['product_image'];
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
    data['product_image'] = productImage;
    data['size_id'] = sizeId;
    data['size_quantity'] = sizeQuantity;
    data['qty'] = qty;
    data['total_price'] = totalPrice;
    data['status'] = status;
    data['special_requets'] = specialRequets;
    return data;
  }
}
