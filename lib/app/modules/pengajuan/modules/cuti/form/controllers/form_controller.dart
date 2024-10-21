import 'dart:convert';

import 'package:esas/app/data/hrd_model.dart';
import 'package:esas/app/data/line_model.dart';
import 'package:esas/app/networks/api/pengajuan/api_cuti.dart';
import 'package:esas/constant.dart';
import 'package:esas/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormController extends GetxController {
  final ApiCuti provider = Get.put(ApiCuti());
  final Storage storage = Get.put(Storage());
  var startDate = ''.obs;
  var endDate = ''.obs;
  var startTime = TimeOfDay.now().obs;
  var endTime = TimeOfDay.now().obs;
  var category = 'full'.obs;
  var type = 'cuti tahunan'.obs;
  var description = ''.obs;
  var userApproved = 'w'.obs;
  var userLine = 0.obs;
  var lineApproved = 'w'.obs;
  var userHr = 0.obs;
  var hrgaApproved = 'w'.obs;

  var isLoading = false.obs;

  final timeInController = TextEditingController();
  final timeOutController = TextEditingController();
  final notesController = TextEditingController();
  var lineApproval = <LineModel>[].obs;
  var hrApproval = <HrdModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch initial approval data on init
    _kelengkapanForm();
  }

  final List<String> cutiTypes = [
    'cuti tahunan',
    'cuti menikah',
    'cuti menikahkan anak',
    'cuti khitan',
    'cuti khitanan anak',
    'cuti baptis',
    'cuti baptis anak',
    'cuti istri melahirkan/keguguran',
    'cuti keluarga meninggal',
    'cuti anggota keluarga serumah meninggal',
    'cuti melahirkan',
    'cuti haid',
    'cuti keguguran',
    'cuti ibadah haji',
  ];

  // Fetch attendance revision data from the provider
  Future<void> _kelengkapanForm() async {
    isLoading(true);
    try {
      final userId = storage.currentAccountId.value;
      final response = await provider.fetchApproval(userId);
      final fetch = jsonDecode(response.body) as Map<String, dynamic>;
      if (response != null) {
        _handleApprovalResponse(fetch);
      } else {
        showErrorSnackbar('Unexpected response format');
      }
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading(false);
    }
  }

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

  Future<void> submitForm() async {
    if (_validateFields()) {
      isLoading(true);
      try {
        final Map<String, dynamic> datapost = {
          'userId': 328,
          'startDate': startDate.value.toString(),
          'endDate': endDate.value.toString(),
          'startTime': formatTime(startTime.value),
          'endTime': formatTime(endTime.value),
          'category': category.value.toString(),
          'type': type.value.toString(),
          'description': description.value.toString(),
          'userApproved': userApproved.value.toString(),
          'userLine': userLine.value.toString(),
          'lineApproved': lineApproved.value.toString(),
          'userHr': userHr.value.toString(),
          'hrgaApproved': hrgaApproved.value.toString(),
        };
        await provider.submitCreate(datapost);
        showSuccessSnackbar('Data berhasil tersimpan');
      } catch (e) {
        showErrorSnackbar(e.toString());
      } finally {
        isLoading(false);
      }
    } else {
      showErrorSnackbar('Lengkapi dulu form anda!');
    }
  }

  bool _validateFields() {
    return storage.currentAccountId.value > 0 &&
        startDate.value.isNotEmpty &&
        endDate.value.isNotEmpty &&
        category.value.isNotEmpty &&
        type.value.isNotEmpty &&
        description.value.isNotEmpty &&
        userApproved.value.isNotEmpty &&
        userLine.value > 0 &&
        lineApproved.value.isNotEmpty &&
        userHr.value > 0 &&
        hrgaApproved.value.isNotEmpty;
  }
}
