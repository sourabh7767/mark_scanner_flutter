class ServicesListModel {
  List<ServicesData>? services;

  ServicesListModel({this.services});

  ServicesListModel.fromJson(Map<String, dynamic> json) {
    if (json['Services'] != null) {
      services= <ServicesData>[];
      json['Services'].forEach((v) {
        services!.add(new ServicesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services!= null) {
      data['Services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServicesData {
  String? id;
  String? quantity;
  String? amount;

  ServicesData({this.id, this.quantity, this.amount});

  ServicesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['amount'] = this.amount;
    return data;
  }
}
