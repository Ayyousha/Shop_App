import 'package:moon/models/get_order_models.dart';

class CancelOrderModel
{

  bool? status;
  String? message;
  GetOrderData? data;

  CancelOrderModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? GetOrderData.fromJson(json['data']) : null ;
  }
}