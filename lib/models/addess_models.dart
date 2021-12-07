class AddressModels {

  bool? status;
  String? message;
  GetAddressData? data;

  AddressModels.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = GetAddressData.fromJson(json['data']);
  }

}

class GetAddressData {

  List<AddressData> data = [];

  GetAddressData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element)
    {
      data.add(AddressData.fromJson(element));
    });
    // data = List.from(json['data']).map((e) => AddressData.fromJson(e)).toList();
  }
}

class AddressData {

  int? id;
  String? name;
  String? city;
  String? region;
  String? details;

  AddressData.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
  }

}