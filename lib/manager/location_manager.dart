import 'dart:async';

// ignore: library_prefixes
import 'package:geocoding/geocoding.dart' as geoCoding;
import 'package:geolocator/geolocator.dart';

import '../models/location.dart';

class LocationManager {
  ///
  Future<LocationModel> getCurrentLocation() async {
    //============== permission
    final isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      return Future.error('location get error.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('location get error');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('location get error');
    }
    //============== permission

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // best
    // bestForNavigation
    // なんてのも存在する

    final placeMarks = await geoCoding.placemarkFromCoordinates(position.latitude, position.longitude);
    final placeMark = placeMarks.first;
    return Future.value(convert(placeMark, position.latitude, position.longitude));
  }

  ///
  LocationModel convert(geoCoding.Placemark placeMark, double latitude, double longitude) {
    return LocationModel(
      latitude: latitude,
      longitude: longitude,
      country: placeMark.country ?? '',
      state: placeMark.administrativeArea ?? '',
      city: placeMark.locality ?? '',
    );
  }
}
