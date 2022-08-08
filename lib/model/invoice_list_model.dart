class InvoiceListModel {
  int? statusCode;
  String? status;
  String? message;
  List<Invoice>? data;

  InvoiceListModel({this.statusCode, this.status, this.message, this.data});

  InvoiceListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Invoice>[];
      json['data'].forEach((v) {
        data!.add(new Invoice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Invoice {
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
  String? Ro_num;
  String? vMake;
  String? vLicno;
  String? vVin;
  String? vColor;
  String? vEngine;
  String? vMilege;
  int? isEmailSent;
  String? services;
  int? status;
  String? createdAt;
  String? v_modal;
  String? updatedAt;

  Invoice(
      {this.id,
        this.userId,
        this.invoiceId,
        this.shopId,
        this.shopName,
        this.shopEmail,
        this.shopNumber,
        this.v_modal,
        this.cName,
        this.cEmail,
        this.cAddress,
        this.cPhone,
        this.cFax,
        this.vYear,
        this.vMake,
        this.vLicno,
        this.vVin,
        this.Ro_num,
        this.vColor,
        this.vEngine,
        this.vMilege,
        this.isEmailSent,
        this.services,
        this.status,
        this.createdAt,
        this.updatedAt});

  Invoice.fromJson(Map<String, dynamic> json) {
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
    v_modal = json['c_address'];
    cPhone = json['v_modal'];
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
    data['c_address'] = this.cAddress;
    data['c_phone'] = this.cPhone;
    data['c_fax'] = this.cFax;
    data['Ro_num'] = this.Ro_num;
    data['v_modal'] = this.v_modal;
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
