import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleGoogleMapScreen extends StatefulWidget {
  const StyleGoogleMapScreen({super.key});

  @override
  State<StyleGoogleMapScreen> createState() => _StyleGoogleMapScreenState();
}

class _StyleGoogleMapScreenState extends State<StyleGoogleMapScreen> {
  String mapTheme = '';

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
      24.88453,
      67.07886,
    ),
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/retro_theme.json')
        .then((value) {
      mapTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Map themes',
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  _controller.future.then(
                    (value) {
                      DefaultAssetBundle.of(context)
                          .loadString('assets/maptheme/silver_theme.json')
                          .then(
                        (string) {
                          value.setMapStyle(string);
                        },
                      );
                    },
                  );
                },
                child: const Text('Silver'),
              ),
              PopupMenuItem(
                onTap: () {
                  _controller.future.then(
                    (value) {
                      DefaultAssetBundle.of(context)
                          .loadString('assets/maptheme/retro_theme.json')
                          .then(
                        (string) {
                          value.setMapStyle(string);
                        },
                      );
                    },
                  );
                },
                child: const Text('Retro'),
              ),
              PopupMenuItem(
                onTap: () {
                  _controller.future.then(
                    (value) {
                      DefaultAssetBundle.of(context)
                          .loadString('assets/maptheme/night_theme.json')
                          .then(
                        (string) {
                          value.setMapStyle(string);
                        },
                      );
                    },
                  );
                },
                child: const Text('Night'),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            controller.setMapStyle(mapTheme);
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
