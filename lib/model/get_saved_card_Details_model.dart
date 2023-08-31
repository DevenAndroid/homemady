class GetSavedCardDetails {
  bool? status;
  String? message;
  List<Data>? data;

  GetSavedCardDetails({this.status, this.message, this.data});

  GetSavedCardDetails.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? object;
  Null? addressCity;
  String? addressCountry;
  Null? addressLine1;
  Null? addressLine1Check;
  Null? addressLine2;
  Null? addressState;
  String? addressZip;
  String? addressZipCheck;
  String? brand;
  String? country;
  String? customer;
  String? cvcCheck;
  Null? dynamicLast4;
  int? expMonth;
  int? expYear;
  String? fingerprint;
  String? funding;
  String? last4;
  List<Null>? metadata;
  Null? name;
  Null? tokenizationMethod;
  Null? wallet;

  Data(
      {this.id,
        this.object,
        this.addressCity,
        this.addressCountry,
        this.addressLine1,
        this.addressLine1Check,
        this.addressLine2,
        this.addressState,
        this.addressZip,
        this.addressZipCheck,
        this.brand,
        this.country,
        this.customer,
        this.cvcCheck,
        this.dynamicLast4,
        this.expMonth,
        this.expYear,
        this.fingerprint,
        this.funding,
        this.last4,
        this.metadata,
        this.name,
        this.tokenizationMethod,
        this.wallet});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    addressCity = json['address_city'];
    addressCountry = json['address_country'];
    addressLine1 = json['address_line1'];
    addressLine1Check = json['address_line1_check'];
    addressLine2 = json['address_line2'];
    addressState = json['address_state'];
    addressZip = json['address_zip'];
    addressZipCheck = json['address_zip_check'];
    brand = json['brand'];
    country = json['country'];
    customer = json['customer'];
    cvcCheck = json['cvc_check'];
    dynamicLast4 = json['dynamic_last4'];
    expMonth = json['exp_month'];
    expYear = json['exp_year'];
    fingerprint = json['fingerprint'];
    funding = json['funding'];
    last4 = json['last4'];
    if (json['metadata'] != null) {
      metadata = <Null>[];
      json['metadata'].forEach((v) {
       // metadata!.add(new Null.fromJson(v));
      });
    }
    name = json['name'];
    tokenizationMethod = json['tokenization_method'];
    wallet = json['wallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['object'] = this.object;
    data['address_city'] = this.addressCity;
    data['address_country'] = this.addressCountry;
    data['address_line1'] = this.addressLine1;
    data['address_line1_check'] = this.addressLine1Check;
    data['address_line2'] = this.addressLine2;
    data['address_state'] = this.addressState;
    data['address_zip'] = this.addressZip;
    data['address_zip_check'] = this.addressZipCheck;
    data['brand'] = this.brand;
    data['country'] = this.country;
    data['customer'] = this.customer;
    data['cvc_check'] = this.cvcCheck;
    data['dynamic_last4'] = this.dynamicLast4;
    data['exp_month'] = this.expMonth;
    data['exp_year'] = this.expYear;
    data['fingerprint'] = this.fingerprint;
    data['funding'] = this.funding;
    data['last4'] = this.last4;
    if (this.metadata != null) {
     // data['metadata'] = this.metadata!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['tokenization_method'] = this.tokenizationMethod;
    data['wallet'] = this.wallet;
    return data;
  }
}
