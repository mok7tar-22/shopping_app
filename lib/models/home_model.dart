import 'package:shopping_app/models/product_model.dart';

class HomeModel {
  final bool status;
  final HomeDataModel? data;

  HomeModel({required this.status, required this.data});

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
      status: json['status'], data: HomeDataModel.fromJson(json['data']));
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel {
  int? id;
  String? image;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

