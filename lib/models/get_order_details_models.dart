
class GetOrderDetailsModels {

  bool? status;
  OrderDetailsData? data;

  GetOrderDetailsModels.fromJson(Map<String , dynamic> json)
  {
    status = json['status'];
    data = OrderDetailsData.fromJson(json['data']);

  }

}

class OrderDetailsData {

  int? id;
  dynamic cost;
  dynamic discount;
  dynamic payment_method;
  dynamic vat;
  dynamic total;
  String? date;
  String? status;
  // addressData? address;
  // List<productData> products = [];

  OrderDetailsData.fromJson(Map<String , dynamic> json)
  {
    id = json['id'];
    cost = json['cost'];
    discount = json['discount'];
    payment_method = json['payment_method'];
    vat = json['vat'];
    total = json['total'];
    date = json['date'];
    status = json['status'];
    // address = json['address'] != null ? addressData.fromJson(json['address']) : null ;
    // json['products'].forEach((element)
    // {
    //   products.add(productData.fromJson(element));
    // });

  }

}

// class addressData
// {
//
//
//   int? id;
//   String? name;
//   String? city;
//   String? region;
//   String? details;
//   String? notes;
//   dynamic latitude;
//   dynamic longitude;
//
//
//
//
//   addressData.fromJson(Map<String , dynamic> json)
//   {
//     id = json['id'];
//     name = json['name'];
//     city = json['city'];
//     region = json['region'];
//     details = json['details'];
//     notes = json['notes'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//
//   }
//
//
// }
//
//
// class productData
// {
//
//
//   int? id;
//   int? quantity;
//   dynamic price;
//   String? name;
//   String? image;
//
//
//
//
//
//   productData.fromJson(Map<String , dynamic> json)
//   {
//     id = json['id'];
//     quantity = json['quantity'];
//     price = json['price'];
//     name = json['name'];
//     image = json['image'];
//
//   }
//
//
// }