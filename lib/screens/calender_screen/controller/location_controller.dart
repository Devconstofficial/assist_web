import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class LocationController extends GetxController {
  final googleApiKey = 'AIzaSyA1JnjZafh_CgyaxNvLOkaVLVuLN2hHQ7M';

  var currentAddress = ''.obs;
  Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  var searchQuery = ''.obs;
  var predictions = [].obs;

  TextEditingController searchController = TextEditingController();
  GoogleMapController? mapController;
  RxString darkMapStyle = "".obs;

  void setMapController(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _determinePosition();
  }

  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Location Error", "Location services are disabled.");
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Permission Denied", "Location permission is denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Permission Denied",
        "Location permission is permanently denied. Please enable it in settings.",
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    final latLng = LatLng(position.latitude, position.longitude);
    currentLocation.value = latLng;
    await getAddressFromLatLng(latLng);
  }

  Future<void> getAddressFromLatLng(LatLng position) async {
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleApiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'] != null && data['results'].isNotEmpty) {
        currentAddress.value = data['results'][0]['formatted_address'];
      } else {
        currentAddress.value = 'No address found';
      }
    } else {
      currentAddress.value = 'Failed to fetch address';
    }
  }

  void updateSearch(String query) async {
    searchQuery.value = query;

    if (query.isEmpty) {
      predictions.clear();
      return;
    }

    final String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$googleApiKey";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      predictions.value = json.decode(response.body)['predictions'];
    } else {
      predictions.clear();
    }
  }

  void selectPrediction(String placeId, String description) async {
    stopSearch();

    final url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleApiKey";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final result = json.decode(response.body)['result'];
      final lat = result['geometry']['location']['lat'];
      final lng = result['geometry']['location']['lng'];

      final selectedLocation = LatLng(lat, lng);
      updateLocationAndMarker(selectedLocation);
    }
  }

  void stopSearch() {
    searchQuery.value = '';
    predictions.clear();
    searchController.clear();
  }

  void updateLocationAndMarker(LatLng location) {
    currentLocation.value = location;
    mapController?.animateCamera(CameraUpdate.newLatLng(location));
    getAddressFromLatLng(location);
  }

  @override
  void onClose() {
    mapController = null; // avoid accessing disposed controller
    searchController.dispose();
    super.onClose();
  }
}
