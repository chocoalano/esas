import 'dart:convert';
import 'dart:io';
import 'package:esas/app/models/attendance/current_attendance.dart';
import 'package:esas/app/models/auth/timework.dart';
import 'package:esas/app/networks/api/beranda/api_absen.dart';
import 'package:esas/components/widgets/snackbar.dart';
import 'package:esas/services/notif_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AbsensiController extends GetxController {
  final NotifService notifService = Get.put(NotifService());
  final ApiAbsen provider = Get.put(ApiAbsen());
  var isLoading = false.obs;
  var btnIn = false.obs;
  var btnOut = false.obs;
  var listTime = <TimeWork>[].obs;
  var timeId = Rxn<String>();
  var showAlert = false.obs;
  var currentAttendance = CurrentAttendance().obs;

  Rx<int?> selectedShift = Rx<int?>(null);

  void fetchCurrentAttendance() async {
    isLoading(true);
    try {
      final response = await provider.fetchCurrentAbsen();
      if (response.statusCode == 200) {
        final fetch = jsonDecode(response.body) as Map<String, dynamic>;
        currentAttendance.value = CurrentAttendance.fromJson(fetch['data']);
        btnIn.value = currentAttendance.value.timeIn != null ? true : false;
        btnOut.value = currentAttendance.value.timeOut != null ? true : false;
      }
    } on SocketException catch (_) {
      showErrorSnackbar('Waktu jaringan habis. Silahkan coba dilain waktu.');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      notifService.showNotification(
          'Absensi', 'Anda belum melakukan absen hari ini');
    } finally {
      isLoading(false);
    }
  }

  void fetchListTime() async {
    isLoading(true);
    try {
      List<TimeWork> response = await provider.fetchListTimeAbsen();
      listTime.clear();
      listTime.addAll(response);
    } catch (e) {
      showErrorSnackbar("Terjadi kesalahan server : ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }
}
