class UpdatePasswordModels {

  bool? status;
  String? message;
  updatePasswordData? data;

  UpdatePasswordModels.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? updatePasswordData.fromJson(json['data']) : null ;
  }

}

class updatePasswordData {

  String? current_password;
  String? new_password;
  String? ConfirmPassword;

  updatePasswordData.fromJson(Map<String, dynamic> json)
  {
    current_password = json['current_password'];
    new_password = json['new_password'];
    ConfirmPassword = json['new_password'];

  }

}