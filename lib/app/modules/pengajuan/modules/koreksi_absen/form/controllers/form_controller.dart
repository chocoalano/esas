import 'dart:convert';

import 'package:esas/app/data/hrd_model.dart';
import 'package:esas/app/data/line_model.dart';
import 'package:esas/app/networks/api/pengajuan/api_koreksi_absen.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/attendance_model.dart';

class FormController extends GetxController {
  final ApiKoreksiAbsen provider = Get.put(ApiKoreksiAbsen());

  var lineApproval = <LineModel>[].obs;
  var hrApproval = <HrdModel>[].obs;
  var attendance = AttendanceModel().obs;
  var selectedDate = ''.obs;
  var selectedTimeIn = TimeOfDay.now().obs;
  var selectedTimeOut = TimeOfDay.now().obs;
  var notes = ''.obs;
  var isLoading = false.obs;

  final timeInController = TextEditingController();
  final timeOutController = TextEditingController();
  final notesController = TextEditingController();

  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  RxInt selectedLine = 0.obs;
  RxInt selectedHrd = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch initial approval data on init
    getApproval();
  }

  // Method to select a Line for approval
  void selectLine(LineModel? line) {
    selectedLine.value = line?.id ?? 0;
  }

  // Method to select HR for approval
  void selectHrd(HrdModel? hr) {
    selectedHrd.value = hr?.id ?? 0;
  }

  // Helper function to safely parse double values
  double? safeToDouble(dynamic value) =>
      value == null ? null : double.tryParse(value.toString());

  // Function to update attendance data
  void updateAttendance(Map<String, dynamic> json) {
    attendance.value = AttendanceModel.fromJson(json);
  }

  // Fetch attendance data based on selected date
  Future<void> selectDate(pickedDate) async {
    if (pickedDate != null) {
      selectedDate.value = DateFormat('yyyy-MM-dd').format(pickedDate);
      await _fetchAttendanceForDate(selectedDate.value);
    }
  }

  // Fetch attendance revision data from the provider
  Future<void> _fetchAttendanceForDate(String date) async {
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
      showErrorSnackbar(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Select time using TimePicker
  Future<void> selectTime(BuildContext context, bool isTimeIn) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      if (isTimeIn) {
        selectedTimeIn.value = pickedTime;
        timeInController.text = formatTime(pickedTime);
      } else {
        selectedTimeOut.value = pickedTime;
        timeOutController.text = formatTime(pickedTime);
      }
    }
  }

  // Submit attendance correction request
  Future<void> submitRequest() async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final dataPost = {
        'userId': 328,
        'dateAdjustment': selectedDate.value,
        'timeinAdjustment': formatTime(selectedTimeIn.value),
        'timeoutAdjustment': formatTime(selectedTimeOut.value),
        'notes': notes.value,
        'status': 'w',
        'lineId': selectedLine.value,
        'hrId': selectedHrd.value,
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
