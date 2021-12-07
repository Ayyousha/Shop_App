class UpdateAddressModel {

  bool? status;
  String? message;
  UpdateAddressData? data;
  UpdateAddressModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = UpdateAddressData.fromJson(json['data']);
  }

}

class UpdateAddressData {

  int? id;
  String? name;
  String? city;
  String? region;
  String? details;

  UpdateAddressData.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
  }

}