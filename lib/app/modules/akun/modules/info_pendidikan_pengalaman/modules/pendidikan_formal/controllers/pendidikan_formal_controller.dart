import 'dart:convert';

import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:esas/app/networks/api/akun/api_info_pendidikan_pengalaman.dart';
import 'package:esas/constant.dart';
import 'package:get/get.dart';

class AkunPendidikanFormalController extends GetxController {
  final ApiAuth provider = Get.find<ApiAuth>();
  final ApiInfoPendidikanPengalaman apiRepositories =
      Get.find<ApiInfoPendidikanPengalaman>();
  var formData = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    addForm();
    getProfile();
  }

  // Fungsi untuk mendapatkan ID terakhir dalam formData
  int getLastId() {
    if (formData.isNotEmpty) {
      // Mengambil ID terbesar dari formData
      return formData
          .map((e) => int.tryParse(e['id'].toString()) ?? 0)
          .reduce((a, b) => a > b ? a : b);
    }
    return 0;
  }

  // Tambahkan form baru
  void addForm() {
    formData.add({
      'id': getLastId() + 1,
      'institution': '',
      'majors': '',
      'score': '',
      'start': '',
      'finish': '',
      'description': '',
      'certification': false,
    });
  }

  // Hapus form berdasarkan index jika lebih dari satu form
  Future<void> removeForm(int index) async {
    if (formData.length <= 1) return; // Early return jika hanya ada satu data

    final dataToRemove = formData[index];
    int? idToRemove;
    if (dataToRemove['id'] is String) {
      idToRemove = int.tryParse(dataToRemove['id']);
    } else if (dataToRemove['id'] is int) {
      idToRemove = dataToRemove['id'];
    }
    // Jika ID valid, lakukan penghapusan
    if (idToRemove != null && idToRemove > 0) {
      await provider.removeProfile('pendidikan_normal', idToRemove);
      formData.removeAt(index);
    }
  }

  // Update form berdasarkan key dan value
  void updateForm(int index, String key, dynamic value) {
    if (key == 'certification' && value is bool) {
      formData[index][key] = value;
    } else if (value is String) {
      formData[index][key] = value;
    }
    formData.refresh();
  }

  // Ambil data profil pengguna
  Future<void> getProfile() async {
    isLoading(true);
    try {
      final response = await provider.getProfile();
      if (response.statusCode == 200) {
        final formal = jsonDecode(response.body)['account']['formalEducation'];
        if (formal is List) {
          formData.clear();
          for (var e in formal) {
            formData.add({
              'id': e['id']?.toString() ?? (getLastId() + 1).toString(),
              'institution': e['institution'] ?? '',
              'majors': e['majors'] ?? '',
              'score': e['score'].toString(),
              'start': e['start'] ?? '',
              'finish': e['finish'] ?? '',
              'description': e['description'] ?? '',
              'certification': e['certification'] > 0 ? true : false,
            });
          }
        }
      } else {
        showErrorSnackbar('Error: ${response.statusCode}');
      }
    } catch (e) {
      showErrorSnackbar('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  // Simpan profil ke server
  Future<void> saveProfile() async {
    isLoading(true);
    try {
      final response = await apiRepositories.saveSubmit(formData, 'p_formal');
      if (response.statusCode == 200) {
        showSuccessSnackbar('Data berhasil diperbarui');
      } else {
        showErrorSnackbar('Error: $response');
      }
    } catch (e) {
      showErrorSnackbar('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
