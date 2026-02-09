import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  // * permission
  Future<bool> checkPermission({required Function onRequestCanceled}) async {
    bool serviceEnabled; // ! qurilmada location bormi
    LocationPermission permission; // * permmsion ->

    serviceEnabled = await Geolocator.isLocationServiceEnabled(); //
    if (!serviceEnabled) {
      print('Device does not support geo locator ❌');
      return false;
    }

    permission = await Geolocator.checkPermission();
    print('permissiont type $permission');

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      onRequestCanceled();
      return false;
    } else {
      return true;
    }
  }

  Future<bool> getPermission() async {
    try {
      final permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future<Position> getCurrentLocation({required Function onSuccess}) async {
    try {
      final locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
      );
      final userPosition = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      print('User possiont keldi ${userPosition}');
      latitudeListen.value = userPosition.latitude;
      longTitudeListen.value = userPosition.longitude;
      onSuccess();
      return userPosition;
    } catch (e) {
      print('ERROR LOCATION $e');
      throw Exception();
    }
  }
}

ValueNotifier<double> latitudeListen = ValueNotifier(0);
ValueNotifier<double> longTitudeListen = ValueNotifier(0);