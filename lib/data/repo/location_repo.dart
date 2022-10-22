import 'dart:async';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

abstract class LocationRepoContract {
  Future<double> getDeviceLongitude();

  Future<double> getDeviceLatitude();

  Future<bool> isLocationServicesEnabled();

  Future<bool> isLocationPermissionGranted();

  Future<bool> requestLocationPermission();
}

class LocationRepo extends LocationRepoContract {
  static LocationRepo? _instance;

  static LocationRepo get instance => _instance ??= LocationRepo._();

  LocationRepo._();

  //TODO implement the location asking feature

  Position? position;

  Future<void> _initLocation() async {
    if (position == null) {
      await Future.delayed(const Duration(seconds: 1));
      position = await Geolocator.getCurrentPosition();
    }
  }

  @override
  Future<double> getDeviceLatitude() async {

    await _initLocation();
    return position!.latitude;
  }

  @override
  Future<double> getDeviceLongitude() async {
    await _initLocation();
    return position!.longitude;
  }

  @override
  Future<bool> isLocationPermissionGranted() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  @override
  Future<bool> isLocationServicesEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<bool> requestLocationPermission() async {
    var granted = await Geolocator.requestPermission();
    return granted == LocationPermission.whileInUse ||
        granted == LocationPermission.always;
  }
}
