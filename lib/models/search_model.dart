import 'package:shopping_app/models/product_model.dart';

class SearchModel {
  late bool status;
  late Data data;

  SearchModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}
class Data {
  int? currentPage;
  late List<ProductModel> data;
  int ?total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data =  [];
    json['data'].forEach((element){data.add(ProductModel.fromJson(element));});
    total = json['total'];
  }
}


