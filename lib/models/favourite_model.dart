class FavoritesModel {
  bool ?status;
  Data? data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<FavoritesData> data = [];


  Data.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(FavoritesData.fromJson(element));
    });
  }
}
class FavoritesData {
  int? id;
  FavoriteProduct? product;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = FavoriteProduct.fromJson(json['product']);
  }
}

class FavoriteProduct {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int ?discount;
  String? image;
  String ?name;
  String ?description;

  FavoriteProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }


}
