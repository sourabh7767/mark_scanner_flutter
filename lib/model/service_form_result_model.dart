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
  Null? cFax;
  String? vYear;
  String? vMake;
  String? vLicno;
  String? vVin;
  String? v_modal;
  String? Ro_num;
  String? vColor;
  String? vEngine;
  String? vMilege;
  int? isEmailSent;
  String? services;
  int? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.userId,
        this.invoiceId,
        this.shopId,
        this.shopName,
        this.shopEmail,
        this.shopNumber,
        this.cName,
        this.cEmail,
        this.cAddress,
        this.v_modal,
        this.cPhone,
        this.cFax,
        this.vYear,
        this.vMake,
        this.vLicno,
        this.vVin,
        this.vColor,
        this.Ro_num,
        this.vEngine,
        this.vMilege,
        this.isEmailSent,
        this.services,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    invoiceId = json['invoice_id'];
    shopId = json['shop_id'];
    shopName = json['shop_name'];
    shopEmail = json['shop_email'];
    v_modal = json['v_modal'];
    shopNumber = json['shop_number'];
    cName = json['c_name'];
    cEmail = json['c_email'];
    cAddress = json['c_address'];
    cPhone = json['c_phone'];
    cFax = json['c_fax'];
    vYear = json['v_year'];
    vMake = json['v_make'];
    vLicno = json['v_licno'];
    vVin = json['v_vin'];
    Ro_num = json['Ro_num'];
    vColor = json['v_color'];
    vEngine = json['v_engine'];
    vMilege = json['v_milege'];
    isEmailSent = json['is_email_sent'];
    services = json['services'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['invoice_id'] = this.invoiceId;
    data['shop_id'] = this.shopId;
    data['shop_name'] = this.shopName;
    data['shop_email'] = this.shopEmail;
    data['shop_number'] = this.shopNumber;
    data['c_name'] = this.cName;
    data['c_email'] = this.cEmail;
    data['v_modal'] = this.v_modal;
    data['Ro_num'] = this.Ro_num;
    data['c_address'] = this.cAddress;
    data['c_phone'] = this.cPhone;
    data['c_fax'] = this.cFax;
    data['v_year'] = this.vYear;
    data['v_make'] = this.vMake;
    data['v_licno'] = this.vLicno;
    data['v_vin'] = this.vVin;
    data['v_color'] = this.vColor;
    data['v_engine'] = this.vEngine;
    data['v_milege'] = this.vMilege;
    data['is_email_sent'] = this.isEmailSent;
    data['services'] = this.services;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}