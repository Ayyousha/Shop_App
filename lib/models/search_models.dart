
class SearchModels {

  bool? status;
  SearchData? data;


  SearchModels.fromJson(Map<String , dynamic> json)
  {
    status = json['status'];

    data = json['data'] != null ? SearchData.fromJson(json['data']) : null ;
  }

}

class SearchData {

  dynamic total;
  List<SearchProductsModels> data = [];

  SearchData.fromJson(Map<String , dynamic> json)
  {
    total = json['total'];
    json['data'].forEach((element)
    {
      data.add(SearchProductsModels.fromJson(element));
    });
  }

}

class SearchProductsModels {

  int? id;
  dynamic price;
  String? image;
  String? name;
  String? markName;
  String? description;
  bool? inFavorites;
  bool? inCart;
  List<String> images = [] ;

  SearchProductsModels.fromJson(Map<String , dynamic> json)
  {
    id = json['id'];
    price = json['price'];
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

