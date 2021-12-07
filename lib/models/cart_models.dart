class CartsModels {

  bool? status;
  String? message;
  Data? data;

  CartsModels.fromJson(Map<String, dynamic> json)
  {
    status = json["status"];
    message = json["message"]?.toString();
    data = (json["data"] != null) ? Data.fromJson(json["data"]) : null;
  }

}

class Data {

  List<CartsData> cart_items = [];
  dynamic sub_total;
  dynamic total;

  Data.fromJson(Map<String, dynamic> json)
  {
   json['cart_items'].forEach((element) {
     cart_items.add(CartsData.fromJson(element));
   });
   sub_total = json['sub_total'];
   total = json['total'];
  }

}

class CartsData {

  int? id;
  int? quantity;
  Products? product;

  CartsData.fromJson(Map<String, dynamic> json)
  {
    id = json["id"];
    quantity = json["quantity"];
    product = (json["product"] != null) ? Products.fromJson(json["product"]) : null;
  }

}

class Products {

  int? id;
  dynamic price;
  dynamic old_price;
  dynamic? discount;
  String? image;
  String? name;
  String? description;
  String? markName;
  bool? inFavorites;
  bool? inCart;
  List<String> images = [] ;

  Products.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    price = json["price"]?.toInt();
    old_price = json["old_price"]?.toInt();
    discount = json["discount"]?.toInt();
    image = json["image"]?.toString();
    name = json["name"]?.toString();
    description = json["description"]?.toString();
    markName = Name[id!];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    images = json['images'].cast<String>();

  }

  Map<int,String> Name = {
    52: 'Apple',
    55: 'Apple',
    53: 'JBL',
    54: 'Samsung',
    56: 'Nikon',
    57: 'Kingston',
    58: 'Stark',
  };

}

