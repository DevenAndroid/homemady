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
  dynamic deliveryDistance;
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
        this.deliveryDistance,
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
    deliveryDistance = json['delivery_distance'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    vendor =
    json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null;
    driver = json['driver'];
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    orderType = json['order_type'];
    deliveryType = json['delivery_type'];
    deliveryStatus = json['delivery_status'];
    itemCount = json['item_count'];
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
    image = json['image'];
    placedAt = json['placed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['item_total'] = itemTotal;
    data['surcharge'] = surcharge;
    data['tax'] = tax;
    data['delivery_distance'] = deliveryDistance;
    data['delivery_charges'] = deliveryCharges;
    data['packing_fee'] = packingFee;
    data['coupon_discount'] = couponDiscount;
    data['grand_total'] = grandTotal;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (vendor != null) {
      data['vendor'] = vendor!.toJson();
    }
    data['driver'] = driver;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['order_type'] = orderType;
    data['delivery_type'] = deliveryType;
    data['delivery_status'] = deliveryStatus;
    data['item_count'] = itemCount;
    if (orderItems != null) {
      data['order_items'] = orderItems!.map((v) => v.toJson()).toList();
    }
    data['image'] = image;
    data['placed_at'] = placedAt;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_driver'] = isDriver;
    data['is_vendor'] = isVendor;
    data['marketing_balance'] = marketingBalance;
    data['wallet_balance'] = walletBalance;
    data['earned_balance'] = earnedBalance;
    data['name'] = name;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['email'] = email;
    data['otp'] = otp;
    data['otp_created_at'] = otpCreatedAt;
    data['otp_verified'] = otpVerified;
    data['profile_image'] = profileImage;
    data['social_profile_image'] = socialProfileImage;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['location'] = location;
    data['default_address'] = defaultAddress;
    data['referal_code'] = referalCode;
    data['device_token'] = deviceToken;
    data['device_id'] = deviceId;
    data['is_driver_online'] = isDriverOnline;
    data['is_vendor_online'] = isVendorOnline;
    data['delivery_range'] = deliveryRange;
    data['self_delivery'] = selfDelivery;
    data['collection_status'] = collectionStatus;
    data['sustainable_packaging_status'] = sustainablePackagingStatus;
    data['admin_commission_type'] = adminCommissionType;
    data['admin_commission'] = adminCommission;
    data['as_driver_verified'] = asDriverVerified;
    data['as_vendor_verified'] = asVendorVerified;
    data['featured_store'] = featuredStore;
    data['email_verified_at'] = emailVerifiedAt;
    data['status'] = status;
    data['is_profile_complete'] = isProfileComplete;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    data['secondarycategory_id'] = secondarycategoryId;
    data['tertiarycategory_id'] = tertiarycategoryId;
    data['collection_id'] = collectionId;
    data['store_name'] = storeName;
    data['number'] = number;
    data['store_image'] = storeImage;
    data['description'] = description;
    data['lat'] = lat;
    data['long'] = long;
    data['location'] = location;
    data['address'] = address;
    data['pps_no'] = ppsNo;
    data['pps_card_image'] = ppsCardImage;
    data['city'] = city;
    data['pin_code'] = pinCode;
    data['address_type'] = addressType;
    data['remark'] = remark;
    data['status'] = status;
    data['delivery_type'] = deliveryType;
    data['delivery_time'] = deliveryTime;
    data['has_file'] = hasFile;
    data['days'] = days;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['location'] = location;
    data['flat_no'] = flatNo;
    data['landmark'] = landmark;
    data['note'] = note;
    data['pin_code'] = pinCode;
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

  OrderItems(
      {this.id,
        this.productId,
        this.productName,
        this.productImage,
        this.price,
        this.qty,
        this.sizeQuantity,
        this.sizeId,
        this.totalPrice,
        this.status});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    price = json['price'];
    qty = json['qty'];
    sizeQuantity = json['size_quantity'];
    sizeId = json['size_id'];
    totalPrice = json['total_price'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_image'] = productImage;
    data['price'] = price;
    data['qty'] = qty;
    data['size_quantity'] = sizeQuantity;
    data['size_id'] = sizeId;
    data['total_price'] = totalPrice;
    data['status'] = status;
    return data;
  }
}
