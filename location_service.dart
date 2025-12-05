import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static StreamSubscription<Position>? _positionStream;

  /// Start sending live location updates to Firestore
  static Future<void> startLocationUpdates() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check GPS
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled.");
    }

    // Check permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permission permanently denied.");
    }

    // Start streaming live location
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      FirebaseFirestore.instance.collection('bus_locations').doc('driver1').set({
        "latitude": position.latitude,
        "longitude": position.longitude,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      });
    });
  }

  /// Stop sending location updates
  static void stopLocationUpdates() {
    _positionStream?.cancel();
    _positionStream = null;
  }
}
