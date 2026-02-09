import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:rent_house/features/booking&payout/screens/booking_screen.dart';
import 'package:rent_house/features/explore/screens/explore_screen.dart';
import 'package:rent_house/features/favourite/screens/favourite_screen.dart';
import 'package:rent_house/features/home/screens/home_screen.dart';
import 'package:rent_house/features/profile/screens/firebase_information.dart';

class MainCubit extends Cubit<int> {
  MainCubit() : super(0);
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(currentIndex);
  }

  final List<Widget> screens = [
    HomeScreen(),
    ExploreScreen(),
    FavouriteScreen(),
    BookingScreen(),
    ProfileScreen(),
  ];
}
