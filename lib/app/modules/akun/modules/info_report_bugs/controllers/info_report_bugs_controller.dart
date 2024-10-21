import 'dart:io';

import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class InfoReportBugsController extends GetxController {
  final ApiAuth provider = Get.put(ApiAuth());

  var isloading = false.obs;
  var selectedFile = Rxn<File>(); // Observable for file
  final TextEditingController descriptions = TextEditingController();

  Future<void> pickFile() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedFile.value = File(pickedFile.path);
      } else {
        showErrorSnackbar('Tidak ada file yang dipilih.');
      }
    } catch (e) {
      showErrorSnackbar('Gagal mengambil gambar: ${e.toString()}');
    }
  }

  Future<void> submitForm() async {
    if (selectedFile.value == null) {
      showErrorSnackbar('Silakan pilih gambar bukti terlebih dahulu');
      return;
    }

    isloading(true); // Start loading
    try {
      final formData = {
        'descriptions': descriptions.text,
        'repairStatus': '0',
        'repairProgres': '0',
      };

      final submit =
          await provider.saveSubmitBugs(formData, selectedFile.value!);
      if (submit == 200) {
        showSuccessSnackbar('Laporan BUG berhasil dilaporkan');
        Get.offAllNamed('/akun');
      } else {
        showErrorSnackbar('Terjadi kesalahan server!');
      }
    } catch (e) {
      showErrorSnackbar('Error: ${e.toString()}');
    } finally {
      isloading(false); // Stop loading
    }
  }

  @override
  void onClose() {
    descriptions.dispose();
    super.onClose();
  }
}
