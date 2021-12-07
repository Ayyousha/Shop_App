class FavoritesModels {

  bool? status;
  String? message;
  Data? data;

  FavoritesModels.fromJson(Map<String, dynamic> json)
  {
    status = json["status"];
    message = json["message"]?.toString();
    data = (json["data"] != null) ? Data.fromJson(json["data"]) : null;
  }

}

class Data {

  int? currentPage;
  List<FavoritesData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data.fromJson(Map<String, dynamic> json)
  {
    currentPage = json["current_page"]?.toInt();
    if (json["data"] != null) {
      final v = json["data"];
      final arr0 = <FavoritesData>[];
      v.forEach((v) {
        arr0.add(FavoritesData.fromJson(v));
      });
      this.data = arr0;
    }
    firstPageUrl = json["first_page_url"]?.toString();
    from = json["from"]?.toInt();
    lastPage = json["last_page"]?.toInt();
    lastPageUrl = json["last_page_url"]?.toString();
    nextPageUrl = json["next_page_url"]?.toString();
    path = json["path"]?.toString();
    perPage = json["per_page"]?.toInt();
    prevPageUrl = json["prev_page_url"]?.toString();
    to = json["to"]?.toInt();
    total = json["total"]?.toInt();
  }

}

class FavoritesData {

  int? id;
  Product? product;

  FavoritesData.fromJson(Map<String, dynamic> json)
  {
    id = json["id"]?.toInt();
    product = (json["product"] != null) ? Product.fromJson(json["product"]) : null;
  }

}

class Product {

  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    price = json["price"]?.toInt();
    oldPrice = json["old_price"]?.toInt();
    discount = json["discount"]?.toInt();
    image = json["image"]?.toString();
    name = json["name"]?.toString();
    description = json["description"]?.toString();
  }

}





