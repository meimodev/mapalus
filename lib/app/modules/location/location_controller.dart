import 'package:get/get.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class LocationController extends GetxController {
  LocationRepoContract locationRepo = LocationRepo.instance;
  GoogleMapController? googleMapController;

  RxBool isLocationNoteEnabled = false.obs;
  RxBool dragging = false.obs;
  RxBool loading = true.obs;

  LatLng? origin;

  LatLng? destination;

  Location fallbackLocation = const Location(
    place: "Tondano",
    latitude: 1.3020014,
    longitude: 124.9030992,
  );

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args == null) {
      return;
    }
    final initLocation = Location.fromJson(args as Map<String, dynamic>);

    //origin set with partner location
    origin = LatLng(initLocation.latitude, initLocation.longitude);
  }

  void onPressedSelectLocation() async {
    final res = Location(
      place: 'Lokasi terpilih',
      latitude: destination!.latitude,
      longitude: destination!.longitude,
    );
    Get.back(result: res);
  }

  void onCameraIdle(LatLng? pos) {
    if (pos != null) {
      destination = pos;
      dragging.value = false;
      return;
    }
    dragging.value = true;
  }

  void onMapCreated(GoogleMapController controller) async {
    googleMapController = controller;
    loading.value = false;
    initLocation();
  }

  void initLocation() async {
    var locationEnabled = await locationRepo.isLocationServicesEnabled();
    if (!locationEnabled) {
      isLocationNoteEnabled.value = true;
      if (origin == null) {
        googleMapController!.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(
              fallbackLocation.latitude,
              fallbackLocation.longitude,
            ),
          ),
        );
      }
      return;
    }
    var locationPermissionGranted =
        await locationRepo.isLocationPermissionGranted();

    if (!locationPermissionGranted) {
      var granted = await locationRepo.requestLocationPermission();
      if (!granted) {
        return;
      }
      initLocation();
      return;
    }

    if (origin != null) {
      googleMapController!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(
            origin!.latitude,
            origin!.longitude,
          ),
        ),
      );
      return;
    }

    LatLng currLocation = LatLng(
      await locationRepo.getDeviceLatitude(),
      await locationRepo.getDeviceLongitude(),
    );
    googleMapController!.animateCamera(CameraUpdate.newLatLng(currLocation));

    if (isLocationNoteEnabled.isTrue) {
      isLocationNoteEnabled.toggle();
    }
  }
}
