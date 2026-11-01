import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_house/features/home/cubit/cubit/home_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_house/features/home/model/house_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState()) {
    getHouses();
  }

  Future<void> getHouses() async {
    emit(HomeLoadingState());
    try {
      final collection = await FirebaseFirestore.instance
          .collection("houses")
          .get();
      List<HouseModel> data = [];
      data = collection.docs
          .map((element) => HouseModel.fromDocument(element))
          .toList();
      emit(HomeSuccessState(houses: data));
    } on FirebaseException catch (e) {
      print('Firebase exception $e');
      emit(HomeErrorState(error: e.message ?? 'Server xatosi'));
    } on SocketException catch (_) {
      emit(
        HomeErrorState(error: 'Internetni tekshiring va qayta urinib ko‘ring'),
      );
    } on TimeoutException catch (_) {
      emit(HomeErrorState(error: 'Server javob bermadi, qayta urinib ko‘ring'));
    } catch (error) {
      emit(HomeErrorState(error: 'Xatolik yuz berdi'));
    }
  }
}
