import 'package:shopping_app/models/home_model.dart';
import 'package:shopping_app/models/product_model.dart';

class CategoryDetailsModel {
  bool status;
  Data data;

  CategoryDetailsModel({required this.status, required this.data});

  factory  CategoryDetailsModel.fromJson(Map<String, dynamic> json) =>
      CategoryDetailsModel(status: json['status'], data: Data.fromJson(json['data']));
}

class Data {

  late List<ProductModel> productData;


  Data.fromJson(Map<String, dynamic> json) {
    productData = [];
    json['data'].forEach((element) {
      productData.add(ProductModel.fromJson(element));
    });

  }
}

