import 'dart:convert';
import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:esas/constant.dart';
import 'package:esas/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final ApiAuth provider = Get.put(ApiAuth());
  final Storage storage = Get.put(Storage());
  final loading = false.obs;
  final isAuth = false.obs;

  Future<void> autoLogin() async {
    loading(true);
    try {
      final response = await provider.getProfile();
      final fetch = jsonDecode(response.body) as Map<String, dynamic>;
      storage.setStorageAuth(fetch);
      Get.offAllNamed('/beranda');
    } catch (e) {
      Get.offAllNamed('/login');
    } finally {
      loading(false);
    }
  }

  Future<void> login(String email, String password) async {
    loading(true);
    try {
      final response =
          await provider.submitLogin({'nik': email, 'password': password});
      if (response.statusCode == 200) {
        final fetch = jsonDecode(response.body) as Map<String, dynamic>;
        storage.setStorageAuth(fetch);
        Get.offAllNamed('/beranda');
      } else {
        showErrorSnackbar('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      loading(false);
    }
  }

  Future<void> getLogout() async {
    loading(true);
    try {
      final response = await provider.submitLogout();
      if (response.statusCode == 200) {
        storage.clearStorage();
        Get.offAllNamed('/login');
      } else {
        showErrorSnackbar('Logout failed: ${response.statusCode}');
      }
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      loading(false);
    }
  }
}
