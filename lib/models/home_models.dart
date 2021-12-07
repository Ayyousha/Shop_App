
class HomeModels
{

  bool? status;
  HomeData? data;

  HomeModels.fromJson(Map<String , dynamic> json)
  {
    status = json['status'];
    data = json['data'] != null ? HomeData.fromJson(json['data']) : null ;
  }

}

 class HomeData
 {

  List<BannersModels> banners = [];
  List<ProductsModels> Products = [];

  HomeData.fromJson(Map<String , dynamic> json)
  {
    json['banners'].forEach((element)
    {
      banners.add(BannersModels.fromJson(element));
    });

    json['products'].forEach((element)
    {
      Products.add(ProductsModels.fromJson(element));
    });
  }

}

 class BannersModels
 {

  int? id;
  String? image;

  BannersModels.fromJson(Map<String , dynamic> json)
  {
    id = json['id'];
    image = json['image'];
  }
 }

class ProductsModels
{

  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;
  String? markName;
  String? description;
  bool? inFavorites;
  bool? inCart;
  List<String> images = [] ;

  ProductsModels.fromJson(Map<String , dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    markName = Name[id!];
    description = json['description'];
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

