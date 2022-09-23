class ServiceFormResultModel {
  int? statusCode;
  String? status;
  String? message;
  Data? data;

  ServiceFormResultModel(
      {this.statusCode, this.status, this.message, this.data});

  ServiceFormResultModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? userId;
  String? invoiceId;
  int? shopId;
  String? shopName;
  String? shopEmail;
  String? shopNumber;
  String? cName;
  String? cEmail;
  String? cAddress;
  String? cPhone;
  String? cFax;
  String? vYear;
  String? vMake;
  String? vModal;
  String? vLicno;
  String? vVin;
  String? vColor;
  String? vEngine;
  String? vMilege;
  int? isEmailSent;
  String? roNum;
  String? total;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<Services>? services;
  List<Images>? images;


  Data(
      {this.id,
        this.userId,
        this.invoiceId,
        this.shopId,
        this.shopName,
        this.shopEmail,
        this.images,
        this.shopNumber,
        this.cName,
        this.cEmail,
        this.cAddress,
        this.cPhone,
        this.cFax,
        this.vYear,
        this.vMake,
        this.vModal,
        this.vLicno,
        this.vVin,
        this.vColor,
        this.vEngine,
        this.vMilege,
        this.isEmailSent,
        this.roNum,
        this.total,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.services});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    invoiceId = json['invoice_id'];
    shopId = json['shop_id'];
    shopName = json['shop_name'];
    shopEmail = json['shop_email'];
    shopNumber = json['shop_number'];
    cName = json['c_name'];
    cEmail = json['c_email'];
    cAddress = json['c_address'];
    cPhone = json['c_phone'];
    cFax = json['c_fax'];
    vYear = json['v_year'];
    vMake = json['v_make'];
    vModal = json['v_modal'];
    vLicno = json['v_licno'];
    vVin = json['v_vin'];
    vColor = json['v_color'];
    vEngine = json['v_engine'];
    vMilege = json['v_milege'];
    isEmailSent = json['is_email_sent'];
    roNum = json['Ro_num'];
    total = json['total'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? "";
    data['user_id'] = this.userId ?? "";
    data['invoice_id'] = this.invoiceId ?? "";
    data['shop_id'] = this.shopId ?? "";
    data['shop_name'] = this.shopName ?? "";
    data['shop_email'] = this.shopEmail ?? "";
    data['shop_number'] = this.shopNumber ?? "";
    data['c_name'] = this.cName ?? "";
    data['c_email'] = this.cEmail ?? "";
    data['c_address'] = this.cAddress ?? "";
    data['c_phone'] = this.cPhone ?? "";
    data['c_fax'] = this.cFax ?? "";
    data['v_year'] = this.vYear ?? "";
    data['v_make'] = this.vMake ?? "";
    data['v_modal'] = this.vModal ?? "";
    data['v_licno'] = this.vLicno ?? "";
    data['v_vin'] = this.vVin ?? "";
    data['v_color'] = this.vColor ?? "";
    data['v_engine'] = this.vEngine ?? "";
    data['v_milege'] = this.vMilege ?? "";
    data['is_email_sent'] = this.isEmailSent ?? "";
    data['Ro_num'] = this.roNum ?? "";
    data['total'] = this.total ?? "";
    data['status'] = this.status ?? "";
    data['created_at'] = this.createdAt ?? "";
    data['updated_at'] = this.updatedAt ?? "";
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Services {
  int? id;
  int? invoiceId;
  String? description;
  String? amount;
  int? quantity;
  String? code;
  int? type;
  int? serviceId;
  String? createdAt;
  String? updatedAt;

  Services(
      {this.id,
        this.invoiceId,
        this.description,
        this.amount,
        this.quantity,
        this.code,
        this.type,
        this.serviceId,
        this.createdAt,
        this.updatedAt});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceId = json['invoice_id'];
    description = json['description'];
    amount = json['amount'];
    quantity = json['quantity'];
    code = json['code'];
    type = json['type'];
    serviceId = json['service_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? "";
    data['invoice_id'] = this.invoiceId ?? "";
    data['description'] = this.description ?? "";
    data['amount'] = this.amount ?? "";
    data['quantity'] = this.quantity ?? "";
    data['code'] = this.code ?? "";
    data['type'] = this.type ?? "";
    data['service_id'] = this.serviceId ?? "";
    data['created_at'] = this.createdAt ?? "";
    data['updated_at'] = this.updatedAt ?? "";
    return data;
  }
}
class Images {
  int? id;
  int? invoiceId;
  String? image;

  Images({this.id, this.invoiceId, this.image});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceId = json['invoice_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_id'] = this.invoiceId;
    data['image'] = this.image;
    return data;
  }
}

