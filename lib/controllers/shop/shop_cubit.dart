import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_app/data/local/preferences.dart';
import 'package:shopping_app/data/remote/dio_helper.dart';
import 'package:shopping_app/data/remote/end_point.dart';
import 'package:shopping_app/models/categories_model.dart';
import 'package:shopping_app/models/favourite_item_model.dart';
import 'package:shopping_app/models/favourite_model.dart';
import 'package:shopping_app/models/home_model.dart';
import '../../models/categories_details_model.dart';
import '../../views/screens/categories_screen.dart';
import '../../views/screens/favorites_screen.dart';
import '../../views/screens/products_screen.dart';
import '../../views/screens/settings_screen.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());
  List screens = const [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScree()
  ];
  int currentScreen = 0;
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  String? token = Preferences.token;
  static ShopCubit get(context) => BlocProvider.of(context);
  Map<int, bool> favourite = {};

  void ChangeScreen(value) {
    currentScreen = value;
    emit(ShopChangeScreenState());
  }

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    String? token = Preferences.token;
    DioHelper.getData(url: ApiConstants.home, token: token).then((value) {

      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favourite.addAll({element.id!: element.inFavorites!});
      });

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error);
    });
  }

  FavoritesModel ? favoritesModel;
  void getFavoriteData() {
    emit(ShopFavoritesLoadingState());
    DioHelper.getData(
      url: ApiConstants.favorites,
      token: token,
    ).then((value){
      favoritesModel = FavoritesModel.fromJson(value.data);
      print('Favorites '+favoritesModel!.status.toString());
      emit(ShopFavoritesSuccessState());
    }).catchError((error){
      emit(ShopFavoritesErrorState());
      print(error.toString());
    });
  }
  FavouriteItemModel ?changeToFavoritesModel;
  void changeToFavorite(int productID) {
    favourite[productID] = !favourite[productID]!;
    emit(ShopChangeFavouriteState());

    DioHelper.postData(
        url: ApiConstants.favorites,
        token: token,
        data: {
          'product_id': productID
        }
    ).then((value){
      changeToFavoritesModel = FavouriteItemModel.fromJson(value.data);
      print(changeToFavoritesModel!.status);
      if(changeToFavoritesModel!.status == false) {
        favourite[productID] = !favourite[productID]!;
      }else{
        getFavoriteData();
      }
      emit(ShopSuccessChangeFavouriteState(changeToFavoritesModel!));
    }).catchError((error) {
      favourite[productID] = !favourite[productID]!;
      emit(ShopSuccessChangeFavouriteState(changeToFavoritesModel!));
      print(error.toString());
    });
  }
      void getCategoriesData() {
    emit(ShopLoadingCategoriesDataState());
    DioHelper.getData(url: ApiConstants.categories, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      print(error);
    });
  }


  CategoryDetailsModel?categoryDetailsModel ;
  void getCategoriesDetailsData(int id) {
    emit(ShopLoadingCategoriesDetailsDataState());

    DioHelper.getData(url: "${ApiConstants.categories}/ $id", token: token).then((value) {
      print("sss${value.data}");
      categoryDetailsModel = CategoryDetailsModel.fromJson(value.data);
      categoryDetailsModel!.data.productData.forEach((element) {
        favourite.addAll({element.id!: element.inFavorites!});
      });
      getFavoriteData();
      emit(ShopSuccessCategoriesDetailsDataState());
    }).catchError((error) {
      print(error);
    });
  }
}
