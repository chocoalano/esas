import 'dart:convert';
import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:esas/components/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final ApiAuth provider = Get.put(ApiAuth());
  final storage = GetStorage();
  final loading = false.obs;
  final isAuth = false.obs;

  Future<void> autoLogin() async {
    loading(true);
    try {
      final indicatour = storage.read('auth_indicatour');
      final password = storage.read('auth_password');
      login(indicatour, password);
    } catch (e) {
      Get.offAllNamed('/login');
    } finally {
      loading(false);
    }
  }

  Future<void> login(String indicatour, String password) async {
    loading(true);
    try {
      final response = await provider
          .submitLogin({'indicatour': indicatour, 'password': password});
      if (response.statusCode == 200) {
        final fetch = jsonDecode(response.body) as Map<String, dynamic>;
        final info = fetch['data'];
        setStorage(info['token'], info['token_type'], info['name'],
            info['userId'], indicatour, password);
        Get.offAllNamed('/beranda');
      } else {
        showErrorSnackbar('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      showErrorSnackbar(
          'KOmbinasi NIP/email dengan password anda tidak dikenali!');
    } finally {
      loading(false);
    }
  }

  Future<void> getLogout() async {
    await provider.submitLogout({});
    clearStorage();
    Get.offAllNamed('/login');
  }

  void setStorage(String token, String tokenType, String nameAuth, int userId,
      String authIndicatour, String authPassword) {
    storage.write('token', token);
    storage.write('token_type', tokenType);
    storage.write('name', nameAuth);
    storage.write('userId', userId);
    storage.write('auth_indicatour', authIndicatour);
    storage.write('auth_password', authPassword);
  }

  void clearStorage() {
    storage.remove('token');
    storage.remove('token_type');
    storage.remove('name');
    storage.remove('userId');
    storage.remove('auth_indicatour');
    storage.remove('auth_password');
  }
}
