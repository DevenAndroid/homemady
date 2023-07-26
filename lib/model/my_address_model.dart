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
        data!.add(new AddressData.fromJson(v));
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

class AddressData {
  int? id;
  int? userId;
  String? name;
  String? latitude;
  String? longitude;
  String? location;
  String? flatNo;
  String? landmark;
  String? addressType;
  String? note;
  String? pinCode;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['flat_no'] = this.flatNo;
    data['landmark'] = this.landmark;
    data['address_type'] = this.addressType;
    data['note'] = this.note;
    data['pin_code'] = this.pinCode;
    return data;
  }
}
