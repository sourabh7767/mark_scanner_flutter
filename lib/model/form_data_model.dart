class FormDataModel {
  int? statusCode;
  String? status;
  String? message;
  Data? data;

  FormDataModel({this.statusCode, this.status, this.message, this.data});

  FormDataModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<ShopDetails>? shopDetails;
  List<Services>? services;

  Data({this.shopDetails, this.services});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['shop_details'] != null) {
      shopDetails = <ShopDetails>[];
      json['shop_details'].forEach((v) {
        shopDetails!.add(new ShopDetails.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shopDetails != null) {
      data['shop_details'] = this.shopDetails!.map((v) => v.toJson()).toList();
    }
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopDetails {
  int? id;
  String? name;
  String? email;
  String? dialCode;
  String? iso;
  String? number;
  String? createdAt;
  String? updatedAt;

  ShopDetails(
      {this.id,
        this.name,
        this.email,
        this.dialCode,
        this.iso,
        this.number,
        this.createdAt,
        this.updatedAt});

  ShopDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    dialCode = json['dial_code'];
    iso = json['iso'];
    number = json['number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['dial_code'] = this.dialCode;
    data['iso'] = this.iso;
    data['number'] = this.number;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Services {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Services({this.id, this.name, this.createdAt, this.updatedAt});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
