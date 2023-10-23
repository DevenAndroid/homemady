class MyAddressModel {
  bool? status;
  String? message;
  List<AddressData>? data;

  MyAddressModel({this.status, this.message, this.data});

  MyAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AddressData>[];
      json['data'].forEach((v) {
        data!.add(AddressData.fromJson(v));
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

class AddressData {
  dynamic id;
  dynamic userId;
  dynamic name;
  dynamic latitude;
  dynamic longitude;
  dynamic location;
  dynamic flatNo;
  dynamic landmark;
  dynamic addressType;
  dynamic note;
  dynamic pinCode;

  AddressData(
      {this.id,
        this.userId,
        this.name,
        this.latitude,
        this.longitude,
        this.location,
        this.flatNo,
        this.landmark,
        this.pinCode,
        this.note,
        this.addressType});

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    flatNo = json['flat_no'];
    landmark = json['landmark'];
    addressType = json['address_type'];
    note = json['note'];
    pinCode = json['pin_code'];
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
    data['landmark'] = landmark;
    data['address_type'] = addressType;
    data['note'] = note;
    data['pin_code'] = pinCode;
    return data;
  }
}
