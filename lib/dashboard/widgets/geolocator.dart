import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';


class StorageAndGeolocationScreen extends StatefulWidget {
  const StorageAndGeolocationScreen({super.key});

  @override
  _StorageAndGeolocationScreenState createState() =>
      _StorageAndGeolocationScreenState();
}

class _StorageAndGeolocationScreenState
    extends State<StorageAndGeolocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Storage and Geolocation Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Request storage permission
                var status = await Permission.storage.request();
                if (status == PermissionStatus.granted) {
                  print('Storage permission granted');
                } else {
                  print('Storage permission denied');
                }
              },
              child: Text('Request Storage Permission'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Request geolocation permission
                var status = await Permission.locationWhenInUse.request();
                if (status == PermissionStatus.granted) {
                  print('Geolocation permission granted');

                  // Get the current location
                  _getCurrentLocation();
                } else {
                  print('Geolocation permission denied');
                }
              },
              child: Text('Request Geolocation Permission'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print('Current Location: ${position.latitude}, ${position.longitude}');
    } catch (e) {
      print('Error getting current location: $e');
    }
  }
}
