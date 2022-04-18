import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWrapper extends StatefulWidget {
  const GoogleMapWrapper({Key? key, required this.onCameraIdle})
      : super(key: key);

  final void Function(LatLng?) onCameraIdle;

  @override
  State<GoogleMapWrapper> createState() => _GoogleMapWrapperState();
}

class _GoogleMapWrapperState extends State<GoogleMapWrapper> {
  // final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _startingPosition = const CameraPosition(
    target: LatLng(1.3033882088016162, 124.9106824813296),
    zoom: 17,
  );

  // final CameraPosition _kLake = const CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     zoom: 19.151926040649414);

  LatLng pickedPosition = const LatLng(1.3033882088016162, 124.9106824813296);
  bool isCameraIdle = true;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
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
      // onMapCreated: (GoogleMapController controller) {
      //   _controller.complete(controller);
      // },
    );
  }

// Future<void> _goToTheLake() async {
//   final GoogleMapController controller = await _controller.future;
//   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
// }
}