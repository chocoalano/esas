import 'dart:convert';
import 'dart:io';

import 'package:esas/app/data/shift_model.dart';
import 'package:esas/app/networks/api/beranda/api_absen.dart';
import 'package:esas/constant.dart';
import 'package:esas/services/notif_service.dart';
import 'package:get/get.dart';

class AbsensiController extends GetxController {
  final NotifService notifService = Get.put(NotifService());
  final ApiAbsen apiRepository = Get.put(ApiAbsen());
  var isLoading = false.obs;
  var btnIn = false.obs;
  var btnOut = false.obs;

  var timeIn = '--:--:--'.obs;
  var timeOut = '--:--:--'.obs;

  var shifts = <Shift>[].obs;
  Rx<int?> selectedShift = Rx<int?>(null);

  void fetchCurrentAttendance() async {
    isLoading(true);
    try {
      final response = await apiRepository.fetchCurrentAbsen();
      if (response.statusCode == 200) {
        final fetch = jsonDecode(response.body) as Map<String, dynamic>;
        btnIn(fetch['timeIn'] != null ? true : false);
        btnOut(fetch['timeOut'] != null ? true : false);

        timeIn(fetch['timeIn'] ?? '--:--:--');
        timeOut(fetch['timeOut'] ?? '--:--:--');
      }
    } on SocketException catch (_) {
      showErrorSnackbar('Waktu jaringan habis. Silahkan coba dilain waktu.');
    } catch (e) {
      notifService.showNotification(
          'Absensi', 'Anda belum melakukan absen hari ini');
    } finally {
      isLoading(false);
    }
  }
}
