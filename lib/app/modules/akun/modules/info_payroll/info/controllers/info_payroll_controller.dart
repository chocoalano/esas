import 'dart:convert';

import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:esas/constant.dart';
import 'package:get/get.dart';

import '../../../../models/account_model.dart';

class InfoPayrollController extends GetxController {
  final ApiAuth provider = Get.find<ApiAuth>();
  var isloading = false.obs;
  var visibilityBanner = true.obs;
  var accountModel = AccountModel(
          account: Account(employe: Employe(), salary: Salary(), bank: Bank()))
      .obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    isloading(true);
    try {
      final response = await provider.getProfile();
      if (response.statusCode == 200) {
        final fetch = jsonDecode(response.body) as Map<String, dynamic>;
        accountModel.value = AccountModel.fromJson(fetch);
      } else {
        showErrorSnackbar('Error: ${response.statusCode}');
      }
    } catch (e) {
      showErrorSnackbar('Error: $e');
    } finally {
      isloading(false);
    }
  }

  void setBanner() {
    visibilityBanner.value = !visibilityBanner.value;
  }
}
