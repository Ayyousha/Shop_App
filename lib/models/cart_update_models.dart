import 'cart_models.dart';

class CartsUpdateModels {

  bool? status;
  String? message;
  Data? data;

  CartsUpdateModels.fromJson(Map<String, dynamic> json)
  {
    status = json["status"];
    message = json["message"]?.toString();
    data = (json["data"] != null) ? Data.fromJson(json["data"]) : null;
  }

}







