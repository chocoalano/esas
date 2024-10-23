import 'dart:convert';

import 'package:esas/app/modules/pengajuan/modules/perubahan_shift/models/hrd_options_model.dart';
import 'package:esas/app/modules/pengajuan/modules/perubahan_shift/models/line_options_model.dart';
import 'package:esas/app/networks/api/pengajuan/api_perubahan_shift.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
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
  late final TextEditingController date;
  late final TextEditingController currentGroup;
  late final TextEditingController currentShift;
  late final TextEditingController adjustShift;
  late final TextEditingController lineId;
  late final TextEditingController hrId;

  @override
  void onInit() {
    fetchKelengkapan();
    super.onInit();
    date = TextEditingController();
    currentGroup = TextEditingController();
    currentShift = TextEditingController();
    adjustShift = TextEditingController();
    lineId = TextEditingController();
    hrId = TextEditingController();
  }

  Future<void> fetchCurrentShift(String date) async {
    isLoading(true);
    try {
      final response = await provider.fetchSchedule(date);
      final fetch = jsonDecode(response.body) as Map<String, dynamic>;
      currentGroup.text = fetch['groupAttendanceId'] ?? '0';
      currentShift.text = fetch['timeAttendanceId'] ?? '0';
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
      'date': date.text,
      'currentGroup': currentGroup.text,
      'currentShift': currentShift.text,
      'adjustShift': adjustShift.text,
      'status': 'w',
      'lineId': lineId.text,
      'lineApprove': 'w',
      'hrId': hrId.text,
      'hrApprove': 'w',
    };
    isLoading(true);
    try {
      await provider.submitCreate(formData);
      showSuccessSnackbar('Data berhasil ditambahkan');
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
