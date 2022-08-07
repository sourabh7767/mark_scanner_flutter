class ServiceFormModel {
  String? cName;
  String? cEmail;
  String? cAddress;
  String? cPhone;
  String? vYear;
  String? vMake;
  String? vLicno;
  String? vColor;
  String? vEngine;
  String? vMilege;
  String? vVin;
  String? status;
  String? shopId;
  String? services;
  String? id;

  ServiceFormModel(
      {this.cName,
        this.cEmail,
        this.cAddress,
        this.cPhone,
        this.vYear,
        this.vMake,
        this.vLicno,
        this.vColor,
        this.vEngine,
        this.vMilege,
        this.vVin,
        this.status,
        this.shopId,
        this.services,
        this.id});

  ServiceFormModel.fromJson(Map<String, dynamic> json) {
    cName = json['c_name'];
    cEmail = json['c_email'];
    cAddress = json['c_address'];
    cPhone = json['c_phone'];
    vYear = json['v_year'];
    vMake = json['v_make'];
    vLicno = json['v_licno'];
    vColor = json['v_color'];
    vEngine = json['v_engine'];
    vMilege = json['v_milege'];
    vVin = json['v_vin'];
    status = json['status'];
    shopId = json['shop_id'];
    services = json['services'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['c_name'] = this.cName;
    data['c_email'] = this.cEmail;
    data['c_address'] = this.cAddress;
    data['c_phone'] = this.cPhone;
    data['v_year'] = this.vYear;
    data['v_make'] = this.vMake;
    data['v_licno'] = this.vLicno;
    data['v_color'] = this.vColor;
    data['v_engine'] = this.vEngine;
    data['v_milege'] = this.vMilege;
    data['v_vin'] = this.vVin;
    data['status'] = this.status;
    data['shop_id'] = this.shopId;
    data['services'] = this.services;
    data['id'] = this.id;
    return data;
  }
}
