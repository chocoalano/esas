import 'dart:io';

import 'package:esas/app/models/auth/work_schedule.dart';
import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:esas/app/networks/api/pengajuan/api_permit.dart';
import 'package:esas/components/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PengajuanCreateController extends GetxController {
  final ApiAuth provider = Get.find<ApiAuth>();
  final ApiPermit providerPermit = Get.find<ApiPermit>();
  final formKey = GlobalKey<FormBuilderState>();
  var listJadwalKerja = <WorkSchedule>[].obs;
  final isLoading = false.obs;
  var showInfo = true.obs;

  // File input state
  final selectedFile = Rxn<File>();

  @override
  void onInit() {
    super.onInit();
    loadSchedule(); // Memuat data saat controller diinisialisasi
  }

  Future<void> loadSchedule() async {
    isLoading.value = true;
    try {
      final response = await provider.listJadwalKerja();
      listJadwalKerja.addAll(response);
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectFile() async {
    try {
      final ImagePicker picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedFile.value = File(image.path);
      }
    } catch (e) {
      showErrorSnackbar("Gagal memilih file: $e");
    }
  }

  // Form submission
  void submitForm(int permitTypeId) async {
    isLoading(true);
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final formData = formKey.currentState!.value;
      try {
        final payload = {
          'type': 'mobile',
          'user_timework_schedule_id':
              formData['user_timework_schedule_id'].toString(),
          'start_date': (formData['start_date'] as DateTime)
              .toIso8601String()
              .split('T')[0], // Format: yyyy-MM-dd
          'end_date': (formData['end_date'] as DateTime)
              .toIso8601String()
              .split('T')[0], // Format: yyyy-MM-dd
          'start_time': (formData['start_time'] as DateTime)
              .toIso8601String()
              .split('T')[1]
              .substring(0, 8), // Format: HH:mm:ss
          'end_time': (formData['end_time'] as DateTime)
              .toIso8601String()
              .split('T')[1]
              .substring(0, 8), // Format: HH:mm:ss
          'notes': formData['notes'],
          'permit_type_id': permitTypeId.toString(),
        };

        // Ensure selectedFile is not null
        final fileToSubmit = selectedFile.value;
        if (fileToSubmit == null) {
          showErrorSnackbar('File tidak boleh kosong.');
        } else {
          // Submit data to API
          final response =
              await providerPermit.saveSubmit(payload, fileToSubmit);
          if (response == 200) {
            showSuccessSnackbar('Pengajuan berhasil disimpan!');
          } else {
            showErrorSnackbar('Terjadi kesalahan server!');
          }
        }
      } catch (e) {
        showErrorSnackbar('Terjadi kesalahan server!');
      } finally {
        isLoading(false);
      }
    } else {
      isLoading(false);
      showErrorSnackbar('Periksa kembali form anda dengan benar!');
    }
  }

  void hideAlert() {
    showInfo.value = !showInfo.value;
  }
}
