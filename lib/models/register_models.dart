
class RegisterModels {

  bool? status;
  String? message;
  registerUserData? data;

  RegisterModels.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? registerUserData.fromJson(json['data']) : null ;
  }

}

class registerUserData {

  String? name;
  String? email;
  String? phone;
  String? id;
  String? image;
  String? token;

  registerUserData.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }

}