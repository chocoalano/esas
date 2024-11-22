import 'dart:async';
import 'dart:convert';

import 'package:esas/app/networks/api/beranda/api_absen.dart';
import 'package:esas/constant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GpsController extends GetxController {
  final ApiAbsen provider = ApiAbsen();
  var isWithinRange = false.obs;
  var currentDistance = 0.0.obs;
  var isMockedLocation = false.obs;

  RxDouble targetLatitude = 0.0.obs;
  RxDouble targetLongitude = 0.0.obs;
  RxDouble rangeLimit = 0.0.obs;

  StreamSubscription<Position>? positionStream;

  @override
  void onClose() {
    positionStream?.cancel(); // Cancel the stream when the controller is closed
    super.onClose();
  }

  void checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showErrorSnackbar('Location permissions are denied');
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showErrorSnackbar('Location permissions are permanently denied');
      return;
    }
    getLocationData();
  }

  Future<void> getLocationData() async {
    try {
      final response = await provider.fetchLocationAbsen();
      final fetch = jsonDecode(response.body) as Map<String, dynamic>;
      targetLatitude(fetch['latitude'] != null
          ? double.tryParse(fetch['latitude'].toString()) ?? 0.0
          : 0.0);
      targetLongitude(fetch['longitude'] != null
          ? double.tryParse(fetch['longitude'].toString()) ?? 0.0
          : 0.0);
      rangeLimit(fetch['radius'] != null
          ? double.tryParse(fetch['radius'].toString()) ?? 0.0
          : 0.0);

      // Start location stream only if valid data is present
      if (targetLatitude.value != 0.0 &&
          targetLongitude.value != 0.0 &&
          rangeLimit.value != 0.0) {
        _startLocationStream();
      } else {
        showErrorSnackbar('Data lokasi absen tidak berhasil dimuat');
      }
    } catch (e) {
      showErrorSnackbar(e.toString());
    }
  }

  void _startLocationStream() {
    // Jika stream sudah ada, batalkan dulu untuk menghindari multiple listeners
    positionStream?.cancel();

    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
      ),
    ).listen((Position position) async {
      // Menghitung jarak antara posisi saat ini dan target
      final distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        targetLatitude.value,
        targetLongitude.value,
      );

      // Periksa apakah lokasi menggunakan mock
      final mockDetected = await isMockLocation(position);

      // Memperbarui jarak saat ini dan status apakah dalam jangkauan
      currentDistance.value = distance;
      isWithinRange.value = distance <= rangeLimit.value;
      isMockedLocation.value = mockDetected;

      if (mockDetected) {
        showErrorSnackbar('Fake GPS terdeteksi! Harap matikan lokasi palsu.');
        positionStream?.cancel(); // Stop stream to prevent further updates
      }
    });
  }

  Future<bool> isMockLocation(Position position) async {
    // Properti isMocked mendeteksi lokasi palsu
    return position.isMocked;
  }
}
