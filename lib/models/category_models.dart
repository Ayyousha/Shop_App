class CategoryModels {

  bool? status;
  Data? data;

  CategoryModels.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data =  Data.fromJson(json['data']) ;
  }

}

class Data {

  int? current_page;
  List<CategoryData> data = [];

  Data.fromJson(Map<String, dynamic> json)
  {
    current_page = json['current_page'];
    json['data'].forEach((element)
    {
      data.add(CategoryData.fromJson(element));
    });
  }

}

class CategoryData {

  int? id;
  String? name;
  String? image;

  CategoryData.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    image = images[id];
  }

  Map<int, String> images = {
    44: 'https://static.vecteezy.com/system/resources/previews/000/146/332/non_2x/flat-electronic-vectors.jpg',
    43: 'https://student.valuxapps.com/storage/uploads/categories/1630142480dvQxx.3658058.jpg',
    42: 'https://image.freepik.com/free-vector/hand-drawn-national-sports-day-illustration_52683-67356.jpg',
    40: 'https://image.freepik.com/free-vector/set-sixteen-isolated-electricity-isometric-icons-with-images-various-domestic-industrial-electrical-infrastructure-elements_1284-32117.jpg'
  };

}