import 'package:rent_house/features/home/model/house_model.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {
  String error;

  HomeErrorState({required this.error});
}

class HomeSuccessState extends HomeState {
  List<HouseModel> houses;
  HomeSuccessState({required this.houses});
}
