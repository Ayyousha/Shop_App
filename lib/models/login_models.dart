class LoginModels {

  bool? status;
  String? message;
  loginUserData? data;

  LoginModels.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? loginUserData.fromJson(json['data']) : null ;
  }

}

class loginUserData {

  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

  loginUserData.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
  }

}