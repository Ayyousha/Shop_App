class UsersModels {

  bool? status;
  usersData? data;

  UsersModels.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = json['data'] != null ? usersData.fromJson(json['data']) : null ;
  }

}

class usersData {

  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  dynamic point;
  dynamic credit;
  String? token;

  usersData.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    point = json['point'];
    credit = json['credit'];
    token = json['token'];
  }

}