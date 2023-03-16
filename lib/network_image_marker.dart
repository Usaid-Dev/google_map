import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NetworkImageMarker extends StatefulWidget {
  const NetworkImageMarker({super.key});

  @override
  State<NetworkImageMarker> createState() => _NetworkImageMarkerState();
}

class _NetworkImageMarkerState extends State<NetworkImageMarker> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
      24.8825,
      67.0694,
    ),
    zoom: 14,
  );

  final List<Marker> _markers = [];

  final List<LatLng> _latLang = <LatLng>[
    const LatLng(24.8825, 67.0694),
    const LatLng(24.871641, 67.059906),
    const LatLng(24.8937, 67.2163),
    const LatLng(24.8784, 67.0103),
    const LatLng(24.9047, 67.0472),
    const LatLng(24.8779, 67.0874)
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < _latLang.length; i++) {
      Uint8List? image = await loadNetWorkImage(
        'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg',
      );

      final ui.Codec markerImageCodec = await instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetHeight: 100,
        targetWidth: 100,
      );

      final ui.FrameInfo frameinfo = await markerImageCodec.getNextFrame();

      final ByteData? byteData = await frameinfo.image.toByteData(
        format: ImageByteFormat.png,
      );

      final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();

      _markers.add(
        Marker(
          markerId: MarkerId(
            i.toString(),
          ),
          position: _latLang[i],
          icon: BitmapDescriptor.fromBytes(
            resizedImageMarker,
          ),
          infoWindow: InfoWindow(
            title: 'Title of marker $i',
          ),
        ),
      );

      setState(() {});
    }
  }

  Future<Uint8List?> loadNetWorkImage(String path) async {
    final completer = Completer<ImageInfo>();

    var image = NetworkImage(path);

    image.resolve(const ImageConfiguration()).addListener(
          ImageStreamListener(
            (info, _) => completer.complete(info),
          ),
        );

    final imageInfo = await completer.future;

    final byteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
