import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({super.key});

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
      33.738045,
      73.084488,
    ),
    zoom: 14,
  );

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  List<LatLng> latlng = [
    const LatLng(
      33.738045,
      73.084488,
    ),
    const LatLng(
      33.567997728,
      72.635997456,
    )
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < latlng.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId(
            i.toString(),
          ),
          position: latlng[i],
          infoWindow: const InfoWindow(
            title: "Really cool place",
            snippet: "5 star rating",
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      setState(() {});
      _polyline.add(
        Polyline(
          polylineId: const PolylineId('1'),
          points: latlng,
          color: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationEnabled: true,
        mapType: MapType.normal,
        polylines: _polyline,
        initialCameraPosition: _kGooglePlex,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
