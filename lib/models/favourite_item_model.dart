class FavouriteItemModel {
  final bool status;
  final String? message;

  FavouriteItemModel({required this.status, required this.message});

  factory FavouriteItemModel.fromJson(Map<String, dynamic> json) => FavouriteItemModel(
        status: json['status'],
        message: json['message'],
      );
}
