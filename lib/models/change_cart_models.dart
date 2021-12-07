class ChangeCartsModels {

  bool? status;
  String? message;

  ChangeCartsModels.fromJson(Map<String, dynamic> json)
  {
    status = json["status"];
    message = json["message"]?.toString();
  }

}




