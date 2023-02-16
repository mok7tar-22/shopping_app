import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/local/boarding_data.dart';
import '../../models/boarding_model.dart';
part 'boarding_state.dart';

class BoardingCubit extends Cubit<BoardingState> {
  final PageController boardController = PageController();
  bool isLast = false;

  static BoardingCubit get(context) => BlocProvider.of(context);

  BoardingCubit() : super(BoardingInitial());

  void changeScreen(index, context) {
    if (index == boarding.length - 1) {
      BoardingCubit.get(context).isLast = true;
      emit(NavigatorToLoginScreen());
    } else {
      BoardingCubit.get(context).isLast = false;
      emit(ChangeScreen());
    }
  }
}
