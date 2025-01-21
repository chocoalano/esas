import 'dart:convert';

import 'package:esas/app/models/auth/user_detail.dart';
import 'package:esas/app/models/auth/work_schedule.dart';
import 'package:esas/app/modules/login/controllers/login_controller.dart';
import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:esas/app/networks/api/beranda/api_absen.dart';
import 'package:esas/app/networks/api/beranda/api_beranda.dart';
import 'package:esas/components/widgets/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../absensi/controllers/absensi_controller.dart';
import '../../../absensi/controllers/gps_controller.dart';

class HomeController extends GetxController {
  final ApiBeranda apiBeranda = Get.put(ApiBeranda());
  final ApiAbsen apiAbsenRepository = Get.put(ApiAbsen());
  final ApiAuth apiAuthRepository = Get.put(ApiAuth());
  var isLoading = false.obs;
  var userSchedule = WorkSchedule(
    id: null,
    userId: null,
    timeWorkId: null,
    workDay: null,
    createdAt: null,
    updatedAt: null,
    timeWork: null,
  ).obs;
  var userDetail = UserDetail(
    id: null,
    companyId: null,
    name: null,
    nip: null,
    email: null,
    emailVerifiedAt: null,
    avatar: null,
    status: null,
    createdAt: null,
    updatedAt: null,
    details: null,
    address: null,
    salaries: null,
    families: null,
    formalEducations: null,
    informalEducations: null,
    workExperiences: null,
    employee: null,
  ).obs;
  final gpsC = Get.put(GpsController());
  final absensiC = Get.put(AbsensiController());
  final loginC = Get.put(LoginController());

  @override
  void onInit() {
    super.onInit();
    setAccount();
    fetchScheduleAttendance();
    gpsC.checkLocationPermission();
    absensiC.fetchCurrentAttendance();
  }

  Future<void> testNotification() async {
    await apiBeranda.testNotifRequest();
  }

  Future<void> setAccount() async {
    isLoading(true);
    try {
      final response = await apiAuthRepository.getProfile();
      final fetch = jsonDecode(response.body) as Map<String, dynamic>;
      userDetail.value = UserDetail.fromJson(fetch['data']);
    } catch (e) {
      showErrorSnackbar("Error ketika memuat akun ${e.toString()}");
      logout();
    } finally {
      isLoading(false);
    }
  }

  void logout() {
    loginC.getLogout();
  }

  void fetchScheduleAttendance() async {
    try {
      final response = await apiAbsenRepository.fetchCurrentShift();
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      userSchedule.value = WorkSchedule.fromJson(jsonData['data']);
    } catch (e) {
      if (kDebugMode) {
        print(
            'Terjadi kesalahan pada controller home dengan pesan : ${e.toString()}');
      }
    }
  }
}
