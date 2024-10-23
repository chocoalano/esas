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

  var isLoading = false.obs;

  late final TextEditingController startDate;
  late final TextEditingController endDate;
  late final TextEditingController startTime;
  late final TextEditingController endTime;
  late final TextEditingController category;
  late final TextEditingController type;
  late final TextEditingController description;
  late final TextEditingController userLine;
  late final TextEditingController userHr;
  late final TextEditingController notes;

  var listLineApproval = <LineModel>[].obs;
  var listHrApproval = <HrdModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    startDate = TextEditingController();
    endDate = TextEditingController();
    startTime = TextEditingController();
    endTime = TextEditingController();
    category = TextEditingController();
    type = TextEditingController();
    description = TextEditingController();
    userLine = TextEditingController();
    userHr = TextEditingController();
    notes = TextEditingController();
    // Fetch initial approval data on init
    _kelengkapanForm();

    category.text = cutiCategories[0];
    type.text = cutiTypes[0];
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
  final List<String> cutiCategories = ['half', 'full', 'suddenly'];

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
      listLineApproval.assignAll(
          lineApprovalData.map((item) => LineModel.fromJson(item)).toList());
    } else {
      showErrorSnackbar('Unexpected format for lineApprovalData');
    }

    // Handling HR approval data
    final hrApprovalData = response['hrga'];
    if (hrApprovalData is List) {
      listHrApproval.assignAll(
          hrApprovalData.map((item) => HrdModel.fromJson(item)).toList());
    } else {
      showErrorSnackbar('Unexpected format for hrApprovalData');
    }
  }

  Future<void> submitForm() async {
    isLoading(true);
    try {
      final Map<String, dynamic> datapost = {
        'startDate': startDate.text,
        'endDate': endDate.text,
        'startTime': startTime.text,
        'endTime': endTime.text,
        'category': category.text,
        'type': type.text,
        'description': notes.text,
        'userApproved': 'y',
        'userLine': userLine.text,
        'lineApproved': 'w',
        'userHr': userHr.text,
        'hrgaApproved': 'w',
      };
      await provider.submitCreate(datapost);
      showSuccessSnackbar('Data berhasil tersimpan');
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
