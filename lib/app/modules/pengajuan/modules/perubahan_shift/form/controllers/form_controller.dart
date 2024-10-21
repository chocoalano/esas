import 'dart:convert';

import 'package:esas/app/modules/pengajuan/modules/perubahan_shift/models/hrd_options_model.dart';
import 'package:esas/app/modules/pengajuan/modules/perubahan_shift/models/line_options_model.dart';
import 'package:esas/app/networks/api/pengajuan/api_perubahan_shift.dart';
import 'package:esas/constant.dart';
import 'package:get/get.dart';
import '../../models/group_absensi_model.dart';
import '../../models/shift_model.dart';

class FormController extends GetxController {
  final ApiPerubahanShift provider = Get.put(ApiPerubahanShift());
  var isLoading = false.obs;

  var groupAbsen = <GroupAbsensiModel>[].obs;
  var shiftModel = <GroupShiftModel>[].obs;
  var hrdOptions = <HrdOptionsModel>[].obs;
  var lineOptions = <LineOptionsModel>[].obs;

  // Observables untuk data form
  var date = ''.obs;
  var currentGroup = 0.obs;
  var currentShift = 0.obs;
  var adjustShift = 0.obs;
  var status = 'w'.obs;
  var lineId = 0.obs;
  var lineApprove = 'w'.obs;
  var hrId = 0.obs;
  var hrApprove = 'w'.obs;

  @override
  void onInit() {
    fetchKelengkapan();
    super.onInit();
  }

  Future<void> fetchCurrentShift() async {
    isLoading(true);
    try {
      final response = await provider.fetchSchedule(date.value);
      final fetch = jsonDecode(response.body) as Map<String, dynamic>;
      currentGroup(fetch['groupAttendanceId'] ?? 0);
      currentShift(fetch['timeAttendanceId'] ?? 0);
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchKelengkapan() async {
    isLoading(true);
    try {
      final response = await provider.fetchPrepared();
      final fetch = jsonDecode(response.body) as Map<String, dynamic>;
      _handleFetchOptions(fetch);
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void _handleFetchOptions(Map<String, dynamic> response) {
    final groupData = response['groupAbsenOptions'];
    if (groupData is List) {
      groupAbsen.assignAll(
          groupData.map((item) => GroupAbsensiModel.fromJson(item)).toList());
    } else {
      showErrorSnackbar('Unexpected format for lineApprovalData');
    }
    final shiftData = response['shiftOptions'];
    if (shiftData is List) {
      shiftModel.assignAll(
          shiftData.map((item) => GroupShiftModel.fromJson(item)).toList());
    } else {
      showErrorSnackbar('Unexpected format for lineApprovalData');
    }
    final hrdData = response['HrdOptions'];
    if (hrdData is List) {
      hrdOptions.assignAll(
          hrdData.map((item) => HrdOptionsModel.fromJson(item)).toList());
    } else {
      showErrorSnackbar('Unexpected format for lineApprovalData');
    }
    final lineData = response['lineOptions'];
    if (lineData is List) {
      lineOptions.assignAll(
          lineData.map((item) => LineOptionsModel.fromJson(item)).toList());
    } else {
      showErrorSnackbar('Unexpected format for lineApprovalData');
    }
  }

  /// Method untuk mengirim data form ke backend.
  Future<void> submitForm() async {
    final formData = {
      'userId': 328, // Ambil ID user dari akun
      'date': date.value,
      'currentGroup': currentGroup.value,
      'currentShift': currentShift.value,
      'adjustShift': adjustShift.value,
      'status': status.value,
      'lineId': lineId.value,
      'lineApprove': lineApprove.value,
      'hrId': hrId.value,
      'hrApprove': hrApprove.value,
    };
    isLoading(true);
    try {
      await provider.submitCreate(formData);
      showSuccessSnackbar('Data berhasil ditambahkan');
      resetForm();
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading(false);
    }
  }

  /// Method untuk mereset nilai form ke default.
  void resetForm() {
    date.value = '';
    currentGroup.value = 0;
    currentShift.value = 0;
    adjustShift.value = 0;
    status.value = 'w';
    lineId.value = 0;
    lineApprove.value = 'w';
    hrId.value = 0;
    hrApprove.value = 'w';
  }
}
