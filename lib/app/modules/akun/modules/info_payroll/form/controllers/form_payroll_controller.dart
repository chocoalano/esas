import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class FormPayrollController extends GetxController {
  final ApiAuth provider = Get.find<ApiAuth>();
  final formKey = GlobalKey<FormBuilderState>();

  var isLoading = false.obs;
  var bankName = ''.obs;
  var bankAccount = ''.obs;
  var bankAccountHolder = ''.obs;

  // Simpan data saat form disubmit
  Future<void> onSubmit() async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      // Ambil nilai dari form
      bankName.value = formKey.currentState?.fields['bankName']?.value;
      bankAccount.value = formKey.currentState?.fields['bankAccount']?.value;
      bankAccountHolder.value =
          formKey.currentState?.fields['bankAccountHolder']?.value;
      Map<String, dynamic> datapost = {
        "bankName": bankName.value,
        "bankAccount": bankAccount.value,
        "bankAccountHolder": bankAccountHolder.value,
      };
      try {
        await provider.saveSubmitBank(datapost);
      } catch (e) {
        showErrorSnackbar('Error : ${e.toString()}');
      }
      // Tampilkan hasil atau kirim ke server
      showSuccessSnackbar('Bank info updated successfully!');
    } else {
      showErrorSnackbar('Tolong lengkapi dulu form anda!');
    }
  }
}
