import 'dart:convert';
import 'dart:io';

import 'package:esas/app/modules/login/controllers/login_controller.dart';
import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:esas/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AkunController extends GetxController {
  final ApiAuth provider = Get.put(ApiAuth());
  final loginC = Get.put(LoginController());
  var isLoading = false.obs;
  var imageData = ''.obs;
  var nameData = ''.obs;
  var nikData = ''.obs;
  var positionData = ''.obs;

  Future<void> getProfileImg() async {
    isLoading(true);
    try {
      final response = await provider.getProfile();
      final fetch = jsonDecode(response.body) as Map<String, dynamic>;
      var parse = fetch['account'];
      imageData.value = parse['image'] ?? imgDefault;
      nameData.value = parse['name'];
      nikData.value = parse['nik'];
      positionData.value = parse['employe']['org']['name'];
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> submitAvatar(File file) async {
    try {
      final formData = {
        'nik': nikData.value,
      };
      final submit = await provider.saveChangeAvatar(formData, file);
      if (submit == 200) {
        getProfileImg();
        showSuccessSnackbar('Data berhasil diperbaharui');
      } else {
        showErrorSnackbar('Terjadi kesalahan server!');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void movePage(String page) {
    Get.offAllNamed('/akun/$page');
  }

  void logout() {
    loginC.getLogout();
  }
}
