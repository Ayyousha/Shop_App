class AddOrdersModels {

  bool? status;
  String? message;
  AddOrdersData? data;

  AddOrdersModels.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? AddOrdersData.fromJson(json['data']) : null ;
  }

}

class AddOrdersData {

  String? payment_method;
  dynamic? cost;
  dynamic? vat;
  dynamic? discount;
  dynamic? points;
  dynamic? total;
  int? id;

  AddOrdersData.fromJson(Map<String, dynamic> json)
  {
    payment_method = json['payment_method'];
    cost = json['cost'];
    vat = json['vat'];
    discount = json['discount'];
    points = json['points'];
    total = json['total'];
    id = json['id'];
  }

}