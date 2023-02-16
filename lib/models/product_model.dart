class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  String description;
  dynamic inFavorites;
  dynamic inCart;

  ProductModel(
      { this.id,
      required this.price,
      required this.oldPrice,
      required this.discount,
      required this.image,
      required this.name,
      required this.description,
      required this.inFavorites,
      required this.inCart});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
      inFavorites: json['in_favorites'],
      inCart: json['in_cart']);
}
