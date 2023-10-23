class ChooseOrderAddressModel {
  bool? status;
  String? message;
  Data? data;

  ChooseOrderAddressModel({this.status, this.message, this.data});

  ChooseOrderAddressModel.fromJson(Map<String, dynamic> json) {
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
  List<Address>? address;

  Data({this.address});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Address'] != null) {
      address = <Address>[];
      json['Address'].forEach((v) {
        address!.add(Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (address != null) {
      data['Address'] = address!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  dynamic id;
  dynamic userId;
  dynamic name;
  dynamic latitude;
  dynamic longitude;
  dynamic location;
  dynamic flatNo;
  dynamic note;
  dynamic pinCode;
  dynamic landmark;
  dynamic addressType;

  Address(
      {this.id,
        this.userId,
        this.name,
        this.latitude,
        this.longitude,
        this.location,
        this.flatNo,
        this.note,
        this.pinCode,
        this.landmark,
        this.addressType});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    flatNo = json['flat_no'];
    note = json['note'];
    pinCode = json['pin_code'];
    landmark = json['landmark'];
    addressType = json['address_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['location'] = location;
    data['flat_no'] = flatNo;
    data['note'] = note;
    data['pin_code'] = pinCode;
    data['landmark'] = landmark;
    data['address_type'] = addressType;
    return data;
  }
}
