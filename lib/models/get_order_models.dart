
class GetOrderModels
{

  bool? status;
  GetOrderData? data;

  GetOrderModels.fromJson(Map<String , dynamic> json)
  {
    status = json['status'];
    data = json['data'] != null ? GetOrderData.fromJson(json['data']) : null ;
  }

}

class GetOrderData
{

  List<GetOrderDataModels> data = [];

  GetOrderData.fromJson(Map<String , dynamic> json)
  {
    json['data'].forEach((element)
    {
      data.add(GetOrderDataModels.fromJson(element));
    });
  }

}

class GetOrderDataModels
{

  int? id;
  dynamic total;
  String? date;
  String? status;

  GetOrderDataModels.fromJson(Map<String , dynamic> json)
  {
    id = json['id'];
    total = json['total'];
    date = json['date'];
    status = json['status'];
  }

}

