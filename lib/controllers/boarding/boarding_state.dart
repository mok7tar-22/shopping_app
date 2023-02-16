part of 'boarding_cubit.dart';

abstract class BoardingState extends Equatable {
  const BoardingState();
}

class BoardingInitial extends BoardingState {
  @override
  List<Object> get props => [];
}

class ChangeScreen extends  BoardingState {

  @override
  List<Object?> get props =>[];
}
class NavigatorToLoginScreen extends  BoardingState {
  @override
  List<Object?> get props => throw UnimplementedError();
}
