import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWrapper extends StatefulWidget {
  const GoogleMapWrapper({Key? key, required this.onCameraIdle, required this.onMapCreated})
      : super(key: key);

  final void Function(LatLng?) onCameraIdle;
  final void Function(GoogleMapController controller)onMapCreated;


  @override
  State<GoogleMapWrapper> createState() => _GoogleMapWrapperState();
}

class _GoogleMapWrapperState extends State<GoogleMapWrapper> {

  final CameraPosition _startingPosition = const CameraPosition(
    target: LatLng(1.3033882088016162, 124.9106824813296),
    zoom: 17,
  );


  LatLng pickedPosition = const LatLng(1.3033882088016162, 124.9106824813296);
  bool isCameraIdle = true;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: widget.onMapCreated,
      mapType: MapType.normal,
      initialCameraPosition: _startingPosition,
      minMaxZoomPreference: const MinMaxZoomPreference(14, 19),
      mapToolbarEnabled: false,
      indoorViewEnabled: false,
      tiltGesturesEnabled: false,
      trafficEnabled: false,
      zoomControlsEnabled: false,
      zoomGesturesEnabled: true,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onCameraIdle: () {
        widget.onCameraIdle(pickedPosition);
        isCameraIdle = true;
      },
      onCameraMove: (pos) {
        pickedPosition = pos.target;
        if (isCameraIdle) {
          widget.onCameraIdle(null);
        }
      },
      compassEnabled: false,
      buildingsEnabled: false,
      rotateGesturesEnabled: false,
    );
  }

}