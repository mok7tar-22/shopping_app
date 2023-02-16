class CategoriesModel {

  final bool status;
  final CategoriesDataModel  data;

  CategoriesModel({required this.status, required this.data});

  factory CategoriesModel.fromJson(Map<String, dynamic> json)=>
      CategoriesModel(status: json['status'],
          data: CategoriesDataModel.fromJson(json['data']));
}

class CategoriesDataModel {

  List<DataModel> data = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json)
  {
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  int id;
  String name;
  String image;


  DataModel({required this.id,required this.name,required this.image});

 factory DataModel.fromJson(Map<String, dynamic> json)=>DataModel(

    id : json['id'],
    name : json['name'],
    image : json['image']
 );
}