import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/controllers/search/seacrh_state.dart';
import 'package:shopping_app/data/remote/end_point.dart';
import '../../data/local/preferences.dart';
import '../../data/remote/dio_helper.dart';
import '../../models/search_model.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  String? token = Preferences.token;
  SearchModel? searchModel;
  void getSearchData(String searchText){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: ApiConstants.search,
        token: token,
        data: {
          'text':searchText,
        }
    ).then((value){
      searchModel = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());
    });
  }
}