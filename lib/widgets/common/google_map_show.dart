import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapShow extends StatefulWidget {
  final double latitude;
  final double longitude;
  final double initialZoom;

  GoogleMapShow({
    @required this.latitude,
    @required this.longitude,
    this.initialZoom = 15,
  });

  @override
  _GoogleMapShowState createState() => _GoogleMapShowState();
}

class _GoogleMapShowState extends State<GoogleMapShow> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onTap: (argument) {
        print(argument.latitude);
        print(argument.longitude);
      },
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.latitude, widget.longitude),
        zoom: widget.initialZoom,
      ),
      onMapCreated: (controller) {
        _controller.complete(controller);
      },
      markers: {
        Marker(
          markerId: MarkerId('test'),
          draggable: true,
          position: LatLng(widget.latitude, widget.longitude),
        ),
      },
    );
  }
}
