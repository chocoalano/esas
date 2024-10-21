import 'dart:convert';

import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:esas/app/networks/api/akun/api_kontak_darurat.dart';
import 'package:esas/constant.dart';
import 'package:get/get.dart';

class InfoKontakDaruratController extends GetxController {
  final ApiAuth provider = Get.find<ApiAuth>();
  final ApiEmergencyContact apiKontakDarurat = Get.find<ApiEmergencyContact>();
  var formData = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
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
      'name': '',
      'relationship': '',
      'phone': '',
      'profession': ''
    });
  }

  // Hapus form berdasarkan index jika lebih dari satu form
  Future<void> removeForm(int index) async {
    if (formData.length > 1) {
      final dataToRemove = formData[index];
      int idToRemove;
      if (dataToRemove['id'] is String) {
        idToRemove = int.tryParse(dataToRemove['id']) ?? 0;
        await provider.removeProfile('kontak_darurat', idToRemove);
      } else if (dataToRemove['id'] is int) {
        idToRemove = dataToRemove['id'];
        await provider.removeProfile('kontak_darurat', idToRemove);
      }
      formData.removeAt(index);
    }
  }

  // Update form berdasarkan key dan value
  void updateForm(int index, String key, String value) {
    formData[index][key] = value;
    formData.refresh();
  }

  // Ambil data profil pengguna
  Future<void> getProfile() async {
    isLoading(true);
    try {
      final response = await provider.getProfile();
      if (response.statusCode == 200) {
        final fetch = jsonDecode(response.body) as Map<String, dynamic>;
        final emergencyContacts = fetch['account']['emergencyContact'];
        if (emergencyContacts is List) {
          formData.clear(); // Kosongkan formData sebelum menambahkan data baru
          for (var contact in emergencyContacts) {
            formData.add({
              'id': contact['id']?.toString() ?? (getLastId() + 1).toString(),
              'name': contact['name'] ?? '',
              'relationship': contact['relationship'] ?? '',
              'phone': contact['phone'] ?? '',
              'profession': contact['profesion'] ?? '',
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
      await apiKontakDarurat.saveSubmit(formData);
      getProfile();
      showSuccessSnackbar('Data berhasil diperbarui');
    } catch (e) {
      showErrorSnackbar('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
