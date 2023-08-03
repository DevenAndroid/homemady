class OrderDetailsModel {
  bool? status;
  String? message;
  Data? data;

  OrderDetailsModel({this.status, this.message, this.data});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
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
  dynamic orderId;
  dynamic itemTotal;
  dynamic tax;
  dynamic deliveryCharges;
  dynamic packingFee;
  dynamic couponDiscount;
  dynamic serviceCharge;
  dynamic grandTotal;
  User? user;
  Vendor? vendor;
  Driver? driver;
  dynamic address;
  dynamic orderType;
  dynamic deliveryStatus;
  List<OrderItems>? orderItems;
  dynamic placedAt;

  Data(
      {this.orderId,
        this.itemTotal,
        this.tax,
        this.deliveryCharges,
        this.packingFee,
        this.couponDiscount,
        this.grandTotal,
        this.user,
        this.vendor,
        this.serviceCharge,
        this.driver,
        this.address,
        this.orderType,
        this.deliveryStatus,
        this.orderItems,
        this.placedAt});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    itemTotal = json['item_total'];
    tax = json['tax'];
    deliveryCharges = json['delivery_charges'];
    packingFee = json['packing_fee'];
    couponDiscount = json['coupon_discount'];
    serviceCharge = json['service_charge'];
    grandTotal = json['grand_total'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    vendor =
    json['vendor'] != null ? new Vendor.fromJson(json['vendor']) : null;
    user = json['driver'] != null ? new User.fromJson(json['driver']) : null;
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    orderType = json['order_type'];
    deliveryStatus = json['delivery_status'];
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
    placedAt = json['placed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['item_total'] = this.itemTotal;
    data['tax'] = this.tax;
    data['service_charge'] = this.serviceCharge;
    data['delivery_charges'] = this.deliveryCharges;
    data['packing_fee'] = this.packingFee;
    data['coupon_discount'] = this.couponDiscount;
    data['grand_total'] = this.grandTotal;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.vendor != null) {
      data['vendor'] = this.vendor!.toJson();
    }
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['order_type'] = this.orderType;
    data['delivery_status'] = this.deliveryStatus;
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    data['placed_at'] = this.placedAt;
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
    data['phone'] = this.phone;
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

class Driver {
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
    data['phone'] = this.phone;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeId'] = this.storeId;
    data['id'] = this.id;
    data['store_name'] = this.storeName;
    data['number'] = this.number;
    data['pps_no'] = this.ppsNo;
    data['category'] = this.category;
    data['secondarycategory'] = this.secondarycategory;
    data['tertiarycategory'] = this.tertiarycategory;
    data['collection'] = this.collection;
    data['phone'] = this.phone;
    data['storeImage'] = this.storeImage;
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['delivery_range'] = this.deliveryRange;
    data['pps_card_image'] = this.ppsCardImage;
    data['remark'] = this.remark;
    data['status'] = this.status;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['flat_no'] = this.flatNo;
    data['landmark'] = this.landmark;
    data['address_type'] = this.addressType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class OrderItems {
  dynamic id;
  dynamic productId;
  dynamic productName;
  dynamic price;
  dynamic qty;
  dynamic sizeQuantity;
  dynamic totalPrice;
  dynamic status;
  dynamic specialRequets;

  OrderItems(
      {this.id,
        this.productId,
        this.productName,
        this.price,
        this.qty,
        this.sizeQuantity,
        this.totalPrice,
        this.status,
        this.specialRequets});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    price = json['price'];
    sizeQuantity = json['size_quantity'];
    qty = json['qty'];
    totalPrice = json['total_price'];
    status = json['status'];
    specialRequets = json['special_requets'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['price'] = this.price;
    data['size_quantity'] = this.sizeQuantity;
    data['qty'] = this.qty;
    data['total_price'] = this.totalPrice;
    data['status'] = this.status;
    data['special_requets'] = this.specialRequets;
    return data;
  }
}
