// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWrapper extends StatefulWidget {
  const GoogleMapWrapper({
    Key? key,
    required this.onCameraIdle,
    required this.onMapCreated,
    required this.defaultPosition,
    this.onMoveCamera,
  }) : super(key: key);

  final void Function(LatLng?) onCameraIdle;
  final void Function(GoogleMapController controller) onMapCreated;
  final void Function(double latitude, double longitude)? onMoveCamera;
  final LatLng defaultPosition;

  @override
  State<GoogleMapWrapper> createState() => _GoogleMapWrapperState();
}

class _GoogleMapWrapperState extends State<GoogleMapWrapper> {
  CameraPosition get _startingPosition => CameraPosition(
        target: widget.defaultPosition,
        zoom: 16,
      );

  LatLng pickedPosition = const LatLng(1.3033882088016162, 124.9106824813296);
  bool isCameraIdle = true;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: widget.onMapCreated,
      mapType: MapType.normal,
      initialCameraPosition: _startingPosition,
      minMaxZoomPreference: const MinMaxZoomPreference(5, 19),
      mapToolbarEnabled: false,
      indoorViewEnabled: false,
      tiltGesturesEnabled: false,
      trafficEnabled: false,
      zoomControlsEnabled: false,
      zoomGesturesEnabled: true,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      compassEnabled: false,
      buildingsEnabled: false,
      rotateGesturesEnabled: false,
      onCameraIdle: () {
        widget.onCameraIdle(pickedPosition);
        isCameraIdle = true;
      },
      onCameraMove: (pos) {
        pickedPosition = pos.target;
        if (widget.onMoveCamera != null) {
          widget.onMoveCamera!(pos.target.latitude, pos.target.latitude);
        }
        if (isCameraIdle) {
          widget.onCameraIdle(null);
        }
      },
    );
  }
}
