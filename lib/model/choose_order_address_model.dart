class ChooseOrderAddressModel {
  bool? status;
  String? message;
  Data? data;

  ChooseOrderAddressModel({this.status, this.message, this.data});

  ChooseOrderAddressModel.fromJson(Map<String, dynamic> json) {
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
  List<Address>? address;

  Data({this.address});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Address'] != null) {
      address = <Address>[];
      json['Address'].forEach((v) {
        address!.add(new Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['Address'] = this.address!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['flat_no'] = this.flatNo;
    data['note'] = this.note;
    data['pin_code'] = this.pinCode;
    data['landmark'] = this.landmark;
    data['address_type'] = this.addressType;
    return data;
  }
}
