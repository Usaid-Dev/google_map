import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(
      24.88453,
      67.07886,
    ),
    zoom: 15,
  );

  List<Marker> _marker = [];

  List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(
        24.88453,
        67.07886,
      ),
      infoWindow: InfoWindow(
        title: 'My current losition',
      ),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(
        24.87049,
        67.05908,
      ),
      infoWindow: InfoWindow(
        title: 'Tariq Road',
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
