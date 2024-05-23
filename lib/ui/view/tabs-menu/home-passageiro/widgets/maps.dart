import 'dart:async';

import 'package:batevolta/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsComponent extends StatefulWidget {
  const MapsComponent({super.key});

  @override
  State<MapsComponent> createState() => MapsComponentState();
}

class MapsComponentState extends State<MapsComponent> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-7.1935402, -34.8615718),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 0.9,
      target: LatLng(-7.1935402, -34.8615718),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    HomeController ctrl = Get.put(HomeController());
    final Set<Marker> markers = {};

    markers.add(
      Marker(
        markerId: MarkerId('initial_marker'),
        position: LatLng(-7.1935402, -34.8615718),
        infoWindow: InfoWindow(
          title: 'Initial Position',
          snippet: 'This is the initial position',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );

    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      markers: markers,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
