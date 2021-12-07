import 'package:moon/models/home_models.dart';

class CategoryDetailsModel {

  bool? status;
  CategoryData? data;

  CategoryDetailsModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = CategoryData.fromJson(json['data']);
  }

}

class CategoryData {

  int? total;

  List<ProductsModels> products = [];
  CategoryData.fromJson(Map<String, dynamic> json)
  {
    total = json["total"];
    json["data"].forEach((element)
    {
      products.add(ProductsModels.fromJson(element));
    });
  }

}