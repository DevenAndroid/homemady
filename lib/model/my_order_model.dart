class MyOrderModel {
  bool? status;
  String? message;
  List<Data>? data;

  MyOrderModel({this.status, this.message, this.data});

  MyOrderModel.fromJson(Map<String, dynamic> json) {
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
  dynamic orderId;
  dynamic itemTotal;
  dynamic surcharge;
  dynamic tax;
  dynamic deliveryCharges;
  dynamic packingFee;
  dynamic couponDiscount;
  dynamic grandTotal;
  dynamic user;
  dynamic vendor;
  dynamic driver;
  dynamic address;
  dynamic orderType;
  dynamic deliveryType;
  dynamic deliveryStatus;
  dynamic itemCount;
  List<OrderItems>? orderItems;
  dynamic image;
  dynamic placedAt;

  Data(
      {this.orderId,
        this.itemTotal,
        this.surcharge,
        this.tax,
        this.deliveryCharges,
        this.packingFee,
        this.couponDiscount,
        this.grandTotal,
        this.user,
        this.vendor,
        this.driver,
        this.address,
        this.orderType,
        this.deliveryType,
        this.deliveryStatus,
        this.itemCount,
        this.orderItems,
        this.image,
        this.placedAt});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    itemTotal = json['item_total'];
    surcharge = json['surcharge'];
    tax = json['tax'];
    deliveryCharges = json['delivery_charges'];
    packingFee = json['packing_fee'];
    couponDiscount = json['coupon_discount'];
    grandTotal = json['grand_total'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    vendor =
    json['vendor'] != null ? new Vendor.fromJson(json['vendor']) : null;
    driver = json['driver'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    orderType = json['order_type'];
    deliveryType = json['delivery_type'];
    deliveryStatus = json['delivery_status'];
    itemCount = json['item_count'];
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
    image = json['image'];
    placedAt = json['placed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['item_total'] = this.itemTotal;
    data['surcharge'] = this.surcharge;
    data['tax'] = this.tax;
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
    data['driver'] = this.driver;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['order_type'] = this.orderType;
    data['delivery_type'] = this.deliveryType;
    data['delivery_status'] = this.deliveryStatus;
    data['item_count'] = this.itemCount;
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    data['placed_at'] = this.placedAt;
    return data;
  }
}

class User {
  dynamic id;
  dynamic isDriver;
  dynamic isVendor;
  dynamic marketingBalance;
  dynamic walletBalance;
  dynamic earnedBalance;
  dynamic name;
  dynamic lastName;
  dynamic phone;
  dynamic email;
  dynamic otp;
  dynamic otpCreatedAt;
  dynamic otpVerified;
  dynamic profileImage;
  dynamic socialProfileImage;
  dynamic latitude;
  dynamic longitude;
  dynamic location;
  dynamic defaultAddress;
  dynamic referalCode;
  dynamic deviceToken;
  dynamic deviceId;
  dynamic isDriverOnline;
  dynamic isVendorOnline;
  dynamic deliveryRange;
  dynamic selfDelivery;
  dynamic collectionStatus;
  dynamic sustainablePackagingStatus;
  dynamic adminCommissionType;
  dynamic adminCommission;
  dynamic asDriverVerified;
  dynamic asVendorVerified;
  dynamic featuredStore;
  dynamic emailVerifiedAt;
  dynamic status;
  dynamic isProfileComplete;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  User(
      {this.id,
        this.isDriver,
        this.isVendor,
        this.marketingBalance,
        this.walletBalance,
        this.earnedBalance,
        this.name,
        this.lastName,
        this.phone,
        this.email,
        this.otp,
        this.otpCreatedAt,
        this.otpVerified,
        this.profileImage,
        this.socialProfileImage,
        this.latitude,
        this.longitude,
        this.location,
        this.defaultAddress,
        this.referalCode,
        this.deviceToken,
        this.deviceId,
        this.isDriverOnline,
        this.isVendorOnline,
        this.deliveryRange,
        this.selfDelivery,
        this.collectionStatus,
        this.sustainablePackagingStatus,
        this.adminCommissionType,
        this.adminCommission,
        this.asDriverVerified,
        this.asVendorVerified,
        this.featuredStore,
        this.emailVerifiedAt,
        this.status,
        this.isProfileComplete,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isDriver = json['is_driver'];
    isVendor = json['is_vendor'];
    marketingBalance = json['marketing_balance'];
    walletBalance = json['wallet_balance'];
    earnedBalance = json['earned_balance'];
    name = json['name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    otp = json['otp'];
    otpCreatedAt = json['otp_created_at'];
    otpVerified = json['otp_verified'];
    profileImage = json['profile_image'];
    socialProfileImage = json['social_profile_image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    defaultAddress = json['default_address'];
    referalCode = json['referal_code'];
    deviceToken = json['device_token'];
    deviceId = json['device_id'];
    isDriverOnline = json['is_driver_online'];
    isVendorOnline = json['is_vendor_online'];
    deliveryRange = json['delivery_range'];
    selfDelivery = json['self_delivery'];
    collectionStatus = json['collection_status'];
    sustainablePackagingStatus = json['sustainable_packaging_status'];
    adminCommissionType = json['admin_commission_type'];
    adminCommission = json['admin_commission'];
    asDriverVerified = json['as_driver_verified'];
    asVendorVerified = json['as_vendor_verified'];
    featuredStore = json['featured_store'];
    emailVerifiedAt = json['email_verified_at'];
    status = json['status'];
    isProfileComplete = json['is_profile_complete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_driver'] = this.isDriver;
    data['is_vendor'] = this.isVendor;
    data['marketing_balance'] = this.marketingBalance;
    data['wallet_balance'] = this.walletBalance;
    data['earned_balance'] = this.earnedBalance;
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['otp'] = this.otp;
    data['otp_created_at'] = this.otpCreatedAt;
    data['otp_verified'] = this.otpVerified;
    data['profile_image'] = this.profileImage;
    data['social_profile_image'] = this.socialProfileImage;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['default_address'] = this.defaultAddress;
    data['referal_code'] = this.referalCode;
    data['device_token'] = this.deviceToken;
    data['device_id'] = this.deviceId;
    data['is_driver_online'] = this.isDriverOnline;
    data['is_vendor_online'] = this.isVendorOnline;
    data['delivery_range'] = this.deliveryRange;
    data['self_delivery'] = this.selfDelivery;
    data['collection_status'] = this.collectionStatus;
    data['sustainable_packaging_status'] = this.sustainablePackagingStatus;
    data['admin_commission_type'] = this.adminCommissionType;
    data['admin_commission'] = this.adminCommission;
    data['as_driver_verified'] = this.asDriverVerified;
    data['as_vendor_verified'] = this.asVendorVerified;
    data['featured_store'] = this.featuredStore;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['status'] = this.status;
    data['is_profile_complete'] = this.isProfileComplete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Vendor {
  dynamic id;
  dynamic userId;
  dynamic categoryId;
  dynamic secondarycategoryId;
  dynamic tertiarycategoryId;
  dynamic collectionId;
  dynamic storeName;
  dynamic number;
  dynamic storeImage;
  dynamic description;
  dynamic lat;
  dynamic long;
  dynamic location;
  dynamic address;
  dynamic ppsNo;
  dynamic ppsCardImage;
  dynamic city;
  dynamic pinCode;
  dynamic addressType;
  dynamic remark;
  dynamic status;
  dynamic deliveryType;
  dynamic deliveryTime;
  dynamic hasFile;
  dynamic days;
  dynamic createdAt;
  dynamic updatedAt;

  Vendor(
      {this.id,
        this.userId,
        this.categoryId,
        this.secondarycategoryId,
        this.tertiarycategoryId,
        this.collectionId,
        this.storeName,
        this.number,
        this.storeImage,
        this.description,
        this.lat,
        this.long,
        this.location,
        this.address,
        this.ppsNo,
        this.ppsCardImage,
        this.city,
        this.pinCode,
        this.addressType,
        this.remark,
        this.status,
        this.deliveryType,
        this.deliveryTime,
        this.hasFile,
        this.days,
        this.createdAt,
        this.updatedAt});

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    secondarycategoryId = json['secondarycategory_id'];
    tertiarycategoryId = json['tertiarycategory_id'];
    collectionId = json['collection_id'];
    storeName = json['store_name'];
    number = json['number'];
    storeImage = json['store_image'];
    description = json['description'];
    lat = json['lat'];
    long = json['long'];
    location = json['location'];
    address = json['address'];
    ppsNo = json['pps_no'];
    ppsCardImage = json['pps_card_image'];
    city = json['city'];
    pinCode = json['pin_code'];
    addressType = json['address_type'];
    remark = json['remark'];
    status = json['status'];
    deliveryType = json['delivery_type'];
    deliveryTime = json['delivery_time'];
    hasFile = json['has_file'];
    days = json['days'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['secondarycategory_id'] = this.secondarycategoryId;
    data['tertiarycategory_id'] = this.tertiarycategoryId;
    data['collection_id'] = this.collectionId;
    data['store_name'] = this.storeName;
    data['number'] = this.number;
    data['store_image'] = this.storeImage;
    data['description'] = this.description;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['location'] = this.location;
    data['address'] = this.address;
    data['pps_no'] = this.ppsNo;
    data['pps_card_image'] = this.ppsCardImage;
    data['city'] = this.city;
    data['pin_code'] = this.pinCode;
    data['address_type'] = this.addressType;
    data['remark'] = this.remark;
    data['status'] = this.status;
    data['delivery_type'] = this.deliveryType;
    data['delivery_time'] = this.deliveryTime;
    data['has_file'] = this.hasFile;
    data['days'] = this.days;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
  dynamic note;
  dynamic pinCode;
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
        this.note,
        this.pinCode,
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
    note = json['note'];
    pinCode = json['pin_code'];
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
    data['note'] = this.note;
    data['pin_code'] = this.pinCode;
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
  dynamic sizeQuantity;
  dynamic sizeId;
  dynamic totalPrice;
  dynamic status;

  OrderItems(
      {this.id,
        this.productId,
        this.productName,
        this.price,
        this.sizeQuantity,
        this.sizeId,
        this.totalPrice,
        this.status});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    price = json['price'];
    sizeQuantity = json['size_quantity'];
    sizeId = json['size_id'];
    totalPrice = json['total_price'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['price'] = this.price;
    data['size_quantity'] = this.sizeQuantity;
    data['size_id'] = this.sizeId;
    data['total_price'] = this.totalPrice;
    data['status'] = this.status;
    return data;
  }
}
