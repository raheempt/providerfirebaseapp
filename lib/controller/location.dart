import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  String currentAddress = "Location";
  LocationPermission? permission;

  Future<void> getLocation() async {
    bool servicesEnabled;

    // Check if location services are enabled
    servicesEnabled = await Geolocator.isLocationServiceEnabled();
    if (!servicesEnabled) {
      // Handle case where location services are disabled
      // You may want to show a message or request the user to enable location services
      return;
    }

    // Check and request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {

      return;
    }

    Position currentPosition = await Geolocator.getCurrentPosition();

 
    List<Placemark> placeMarks = await placemarkFromCoordinates(
        currentPosition.latitude, currentPosition.longitude);
    Placemark place = placeMarks[0];

    
    currentAddress = "${place.locality}, ${place.country}";

    notifyListeners();

    print(currentAddress);
    print(currentPosition);
  }
  void clearCurrentAddress() {
    currentAddress = "Location";
    notifyListeners();
  }
}
