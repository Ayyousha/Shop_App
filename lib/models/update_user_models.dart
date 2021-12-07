class UpdateUsersModels {

  bool? status;
  String? message;
  updateUsersData? data;

  UpdateUsersModels.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? updateUsersData.fromJson(json['data']) : null ;
  }

}

class updateUsersData {

  String? name;
  String? email;
  String? phone;
  String? image;
  String? password;

  updateUsersData.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    password = json['password'];
  }

}