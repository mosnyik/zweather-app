// import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  Location({
    this.latitude = 0.0,
    this.longitude = 0.0,
  });
  double latitude;
  double longitude;

  // getLocation;

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
