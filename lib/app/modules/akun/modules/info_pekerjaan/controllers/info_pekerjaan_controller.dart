import 'dart:convert';

import 'package:esas/app/models/users/user_view.dart';
import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:get/get.dart';

class InfoPekerjaanController extends GetxController {
  final ApiAuth provider = Get.find<ApiAuth>();
  var isloading = false.obs;
  var profile = UserView().obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    isloading(true);
    try {
      final response = await provider.getProfile();
      final fetch = jsonDecode(response.body) as Map<String, dynamic>;
      profile.value = UserView.fromJson(fetch['data']);
    } catch (e) {
      showErrorSnackbar('Error: $e');
    } finally {
      isloading(false);
    }
  }

  void showErrorSnackbar(String message) {
    Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
  }
}
