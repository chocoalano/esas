import 'dart:convert';

import 'package:esas/app/data/hrd_model.dart';
import 'package:esas/app/data/line_model.dart';
import 'package:esas/app/networks/api/pengajuan/api_koreksi_absen.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/attendance_model.dart';

class FormController extends GetxController {
  final ApiKoreksiAbsen provider = Get.put(ApiKoreksiAbsen());

  var lineApproval = <LineModel>[].obs;
  var hrApproval = <HrdModel>[].obs;
  var attendance = AttendanceModel().obs;

  var isLoading = false.obs;

  late final TextEditingController dateAdjustment;
  late final TextEditingController timeinAdjustment;
  late final TextEditingController timeoutAdjustment;
  late final TextEditingController notes;
  late final TextEditingController lineId;
  late final TextEditingController hrId;

  @override
  void onInit() {
    super.onInit();
    dateAdjustment = TextEditingController();
    timeinAdjustment = TextEditingController();
    timeoutAdjustment = TextEditingController();
    notes = TextEditingController();
    lineId = TextEditingController();
    hrId = TextEditingController();
    // Fetch initial approval data on init
    getApproval();
  }

  // Helper function to safely parse double values
  double? safeToDouble(dynamic value) =>
      value == null ? null : double.tryParse(value.toString());

  // Function to update attendance data
  void updateAttendance(Map<String, dynamic> json) {
    attendance.value = AttendanceModel.fromJson(json);
  }

  // Fetch attendance revision data from the provider
  Future<void> fetchAttendanceForDate(String date) async {
    _setLoading(true);
    try {
      final response = await provider.fetchRevision(date);
      final fetch = jsonDecode(response.body) as Map<String, dynamic>;
      if (response != null) {
        updateAttendance(fetch);
      } else {
        showErrorSnackbar('Unexpected response format');
      }
    } catch (e) {
      dateAdjustment.text = '';
      showErrorSnackbar(
          'Data absensi pada tanggal yang dipilih, tidak ditemukan!');
    } finally {
      _setLoading(false);
    }
  }

  // Submit attendance correction request
  Future<void> submitRequest() async {
    final dataPost = {
      'dateAdjustment': dateAdjustment.text,
      'timeinAdjustment': timeinAdjustment.text,
      'timeoutAdjustment': timeoutAdjustment.text,
      'notes': notes.text,
      'status': 'w',
      'lineId': lineId.text,
      'hrId': hrId.text,
    };

    _setLoading(true);
    try {
      final response = await provider.submitCreate(dataPost);
      if (response != null) {
        showSuccessSnackbar('Data berhasil ditambahkan');
      } else {
        showErrorSnackbar('Submission failed.');
      }
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Fetch approval data for lines and HR
  Future<void> getApproval() async {
    try {
      final response = await provider.fetchApproval();
      if (response != null) {
        final fetch = jsonDecode(response.body) as Map<String, dynamic>;
        _handleApprovalResponse(fetch);
      }
    } catch (e) {
      showErrorSnackbar(e.toString());
    }
  }

  // Handle approval data parsing
  void _handleApprovalResponse(Map<String, dynamic> response) {
    // Handling line approval data
    final lineApprovalData = response['line'];
    if (lineApprovalData is List) {
      lineApproval.assignAll(
          lineApprovalData.map((item) => LineModel.fromJson(item)).toList());
    } else {
      showErrorSnackbar('Unexpected format for lineApprovalData');
    }

    // Handling HR approval data
    final hrApprovalData = response['hrga'];
    if (hrApprovalData is List) {
      hrApproval.assignAll(
          hrApprovalData.map((item) => HrdModel.fromJson(item)).toList());
    } else {
      showErrorSnackbar('Unexpected format for hrApprovalData');
    }
  }

  // Helper to set loading state
  void _setLoading(bool loading) {
    isLoading.value = loading;
  }
}
