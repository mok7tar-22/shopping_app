part of 'shop_cubit.dart';

@immutable
abstract class ShopState {}

class ShopInitial extends ShopState {}
class ShopChangeScreenState extends ShopState {}
class ShopLoadingHomeDataState extends ShopState {}
class ShopSuccessHomeDataState extends ShopState {}
class ShopErrorHomeDataState extends ShopState {}

class ShopLoadingCategoriesDataState extends ShopState {}
class ShopSuccessCategoriesDataState extends ShopState {}
class ShopLoadingCategoriesDetailsDataState extends ShopState {}
class ShopSuccessCategoriesDetailsDataState extends ShopState {
}
class ShopChangeFavouriteState extends ShopState {}
class ShopSuccessChangeFavouriteState extends ShopState {
  final FavouriteItemModel favouriteModel;

  ShopSuccessChangeFavouriteState(this.favouriteModel);
}
class ShopErrorChangeFavouriteState extends ShopState {}
class ShopFavoritesLoadingState extends ShopState {}
class ShopFavoritesSuccessState extends ShopState {}
class ShopFavoritesErrorState extends ShopState {}
