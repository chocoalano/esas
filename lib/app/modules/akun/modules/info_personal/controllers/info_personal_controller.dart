import 'dart:convert';

import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InfoPersonalController extends GetxController {
  final ApiAuth provider = Get.put(ApiAuth());
  var isloading = false.obs;
  var isBanner = true.obs;
  var imageData = ''.obs;
  final TextEditingController name = TextEditingController();
  final TextEditingController nik = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController placebirth = TextEditingController();
  final TextEditingController datebirth = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController blood = TextEditingController();
  final TextEditingController maritalStatus = TextEditingController();
  final TextEditingController religion = TextEditingController();

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
      if (response.statusCode == 200) {
        var parse = fetch['account'];
        name.text = parse['name'];
        nik.text = parse['nik'];
        email.text = parse['email'];
        phone.text = parse['phone'];
        placebirth.text = parse['placebirth'];
        datebirth.text = parse['datebirth'];
        gender.text = parse['gender'];
        blood.text = parse['blood'];
        maritalStatus.text = parse['maritalStatus'];
        religion.text = parse['religion'];
        imageData.value = parse['image'];
      } else {
        showErrorSnackbar(response.body);
      }
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isloading(false);
    }
  }

  Future<void> submitForm(
      String name,
      String nik,
      String email,
      String phone,
      String placebirth,
      String datebirth,
      String gender,
      String blood,
      String maritalStatus,
      String religion) async {
    isloading(true);
    try {
      final formData = {
        'name': name,
        'nik': nik,
        'email': email,
        'phone': phone,
        'placebirth': placebirth,
        'datebirth': datebirth,
        'gender': gender,
        'blood': blood,
        'maritalStatus': maritalStatus,
        'religion': religion,
      };
      final submit = await provider.saveSubmitDataDiri(formData);
      if (submit == 200) {
        getProfile();
        showSuccessSnackbar('Data berhasil diperbaharui');
      } else {
        showErrorSnackbar('Terjadi kesalahan server!');
      }
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isloading(false);
    }
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      datebirth.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  void showBanner() {
    isBanner.value = !isBanner.value;
  }

  @override
  void onClose() {
    name.dispose();
    nik.dispose();
    email.dispose();
    phone.dispose();
    placebirth.dispose();
    datebirth.dispose();
    gender.dispose();
    blood.dispose();
    maritalStatus.dispose();
    religion.dispose();
    super.onClose();
  }
}
