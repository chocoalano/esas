import 'dart:convert';

import 'package:esas/app/modules/login/controllers/login_controller.dart';
import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:esas/app/networks/api/beranda/api_absen.dart';
import 'package:esas/app/networks/api/beranda/api_beranda.dart';
import 'package:esas/constant.dart';
import 'package:esas/services/storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../absensi/controllers/absensi_controller.dart';
import '../../../absensi/controllers/gps_controller.dart';
import '../../../../data/presence/current_shift_now_model.dart';

class HomeController extends GetxController {
  final ApiBeranda apiBeranda = Get.put(ApiBeranda());
  final ApiAbsen apiAbsenRepository = Get.put(ApiAbsen());
  final ApiAuth apiAuthRepository = Get.put(ApiAuth());
  final Storage storage = Get.put(Storage());
  var userSchedule = CurrentShiftNowModel(
    id: 0,
    groupAttendanceId: 0,
    userId: 0,
    timeAttendanceId: 0,
    date: '',
    status: '',
    timeId: 0,
    timeType: '',
    timeIn: '',
    timeOut: '',
    timePattern: '',
    groupName: '',
    groupPattern: '',
    userIdPrimary: 0,
    userName: '',
    userNik: '',
    userEmail: '',
    userPhone: '',
    userGender: '',
  ).obs;
  final gpsC = Get.put(GpsController());
  final absensiC = Get.put(AbsensiController());
  final loginC = Get.put(LoginController());
  var nama = ''.obs;
  var jabatan = ''.obs;
  var img = ''.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setAccount();
      fetchScheduleAttendance();
      gpsC.checkLocationPermission();
      absensiC.fetchCurrentAttendance();
    });
  }

  Future<void> testNotification() async {
    await apiBeranda.testNotifRequest();
  }

  Future<void> setAccount() async {
    try {
      final response = await apiAuthRepository.getProfile();
      final fetch = jsonDecode(response.body) as Map<String, dynamic>;
      if (kDebugMode) {
        print(fetch);
      }
      storage.setStorageAuth(fetch);
      nama(fetch['account']['name'] ?? '');
      jabatan(fetch['account']['employe']['job']['name'] ?? '');
      img.value = fetch['account']['image'] ?? imgDefault;
    } catch (e) {
      showErrorSnackbar(e.toString());
      logout();
    }
  }

  void logout() {
    loginC.getLogout();
  }

  void fetchScheduleAttendance() async {
    try {
      final response = await apiAbsenRepository.fetchCurrentShift();
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      userSchedule.value = CurrentShiftNowModel.fromJson(jsonData);
    } catch (e) {
      if (kDebugMode) {
        print(
            'Terjadi kesalahan pada controller home dengan pesan : ${e.toString()}');
      }
    }
  }
}
