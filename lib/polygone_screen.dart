import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygoneScreen extends StatefulWidget {
  const PolygoneScreen({super.key});

  @override
  State<PolygoneScreen> createState() => _PolygoneScreenState();
}

class _PolygoneScreenState extends State<PolygoneScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.654235, 73.073000),
    zoom: 14,
  );
  final Set<Marker> _markers = {};
  final Set<Polygon> _polygone = HashSet<Polygon>();

  List<LatLng> points = [
    const LatLng(33.654235, 73.073000),
    const LatLng(33.647326, 72.820175),
    const LatLng(33.689531, 72.763160),
    const LatLng(34.131452, 72.662334),
    const LatLng(33.654235, 73.073000),
  ];

  void _setPolygone() {
    _polygone.add(Polygon(
        polygonId: const PolygonId('1'),
        points: points,
        strokeColor: Colors.deepOrange,
        strokeWidth: 5,
        fillColor: Colors.deepOrange.withOpacity(0.1),
        geodesic: true));
  }

  @override
  void initState() {
    super.initState();
    _setPolygone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polygone'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        myLocationButtonEnabled: true,
        myLocationEnabled: false,
        markers: _markers,
        polygons: _polygone,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
