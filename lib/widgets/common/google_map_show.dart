import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapShow extends StatefulWidget {
  final double latitude;
  final double longitude;
  final double initialZoom;
  final MapType mapType;

  GoogleMapShow({
    @required this.latitude,
    @required this.longitude,
    this.initialZoom = 15,
    this.mapType = MapType.normal,
  });

  @override
  _GoogleMapShowState createState() => _GoogleMapShowState();
}

class _GoogleMapShowState extends State<GoogleMapShow> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: widget.mapType,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.latitude, widget.longitude),
        zoom: widget.initialZoom,
      ),
      onMapCreated: (controller) {
        _controller.complete(controller);
      },
      markers: {
        Marker(
          markerId: MarkerId('Ad location'),
          position: LatLng(widget.latitude, widget.longitude),
        ),
      },
    );
  }
}
