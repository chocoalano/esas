import 'package:esas/app/data/user/user_model.dart';
import 'package:esas/app/networks/api/api_karyawan.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KaryawanController extends GetxController {
  final ApiKaryawan provider = Get.put(ApiKaryawan());
  var listKaryawan = <UserModel>[].obs;
  var isLoading = true.obs;

  final search = TextEditingController();

  void clearSearch() {
    search.clear();
    fetchUsers('');
  }

  @override
  void onInit() {
    fetchUsers('');
    super.onInit();
  }

  void fetchUsers(String search) async {
    try {
      isLoading(true);
      List<UserModel> response = await provider.fetchList(search);
      listKaryawan.clear();
      listKaryawan.addAll(response);
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
