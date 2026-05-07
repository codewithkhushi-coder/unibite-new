import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class LiveTrackingScreen extends StatefulWidget {
  const LiveTrackingScreen({super.key});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  GoogleMapController? mapController;
  StreamSubscription<Position>? positionStream;

  LatLng currentLatLng = const LatLng(31.1048, 77.1734); // Shimla default
  final LatLng dropLocation = const LatLng(31.1060, 77.1750);

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    startLiveTracking();
  }

  Future<void> startLiveTracking() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      final newLatLng = LatLng(position.latitude, position.longitude);

      setState(() {
        currentLatLng = newLatLng;

        markers = {
          Marker(
            markerId: const MarkerId("rider"),
            position: currentLatLng,
            infoWindow: const InfoWindow(title: "You 🛵"),
          ),
          Marker(
            markerId: const MarkerId("drop"),
            position: dropLocation,
            infoWindow: const InfoWindow(title: "Customer 📍"),
          ),
        };

        polylines = {
          Polyline(
            polylineId: const PolylineId("route"),
            points: [currentLatLng, dropLocation],
            width: 5,
          ),
        };
      });

      mapController?.animateCamera(
        CameraUpdate.newLatLng(currentLatLng),
      );
    });
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final distanceInMeters = Geolocator.distanceBetween(
      currentLatLng.latitude,
      currentLatLng.longitude,
      dropLocation.latitude,
      dropLocation.longitude,
    );

    final etaMinutes = (distanceInMeters / 400).ceil();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Delivery Tracking 🗺️"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentLatLng,
                zoom: 15,
              ),
              myLocationEnabled: true,
              markers: markers,
              polylines: polylines,
              onMapCreated: (controller) {
                mapController = controller;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "ETA: $etaMinutes mins",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Distance: ${(distanceInMeters / 1000).toStringAsFixed(2)} km",
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Delivered ✅"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
