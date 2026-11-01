import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class UserPlace {
  final String shortName;
  final String address;
  final double latitude;
  final double longitude;

  const UserPlace({
    required this.shortName,
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}

class LocationService {
  Future<bool> checkPermission({required Function onRequestCanceled}) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      onRequestCanceled();
      return false;
    }

    permission = await Geolocator.checkPermission();

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
      const locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
      );
      final userPosition = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      latitudeListen.value = userPosition.latitude;
      longTitudeListen.value = userPosition.longitude;
      onSuccess();
      return userPosition;
    } catch (e) {
      throw Exception();
    }
  }

  Future<UserPlace> resolveCurrentPlace() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      throw Exception('location-disabled');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw Exception('permission-denied');
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      throw Exception('permission-denied-forever');
    }

    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
    );
    final position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    latitudeListen.value = position.latitude;
    longTitudeListen.value = position.longitude;

    await setLocaleIdentifier('uz_UZ');
    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isEmpty) {
      return UserPlace(
        shortName: 'Joriy joy',
        address:
            '${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}',
        latitude: position.latitude,
        longitude: position.longitude,
      );
    }

    final place = placemarks.first;
    final shortName = _firstNonEmpty([
      place.locality,
      place.subAdministrativeArea,
      place.administrativeArea,
      place.subLocality,
    ]) ?? 'Joriy joy';

    final address = _firstNonEmpty([
      [
        place.street,
        place.subLocality,
        place.locality,
        place.administrativeArea,
        place.country,
      ].where((part) => part != null && part.trim().isNotEmpty).join(', '),
    ]) ?? shortName;

    return UserPlace(
      shortName: shortName,
      address: address,
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  String? _firstNonEmpty(List<String?> values) {
    for (final value in values) {
      if (value != null && value.trim().isNotEmpty) {
        return value.trim();
      }
    }
    return null;
  }
}

ValueNotifier<double> latitudeListen = ValueNotifier(0);
ValueNotifier<double> longTitudeListen = ValueNotifier(0);
