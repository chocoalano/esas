import 'dart:convert';
import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:esas/app/networks/api/akun/api_auth_family.dart';
import 'package:esas/constant.dart';
import 'package:get/get.dart';

class InfoKeluargaController extends GetxController {
  final ApiAuth provider = Get.find<ApiAuth>();
  final ApiAuthFamily apiFamily = Get.find<ApiAuthFamily>();

  var formData = <Map<String, dynamic>>[]
      .obs; // Menggunakan dynamic untuk fleksibilitas data
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    addForm(); // Menambahkan form kosong pada saat inisialisasi
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
    return 0; // Jika formData kosong, kembalikan 0
  }

  // Tambahkan form baru
  void addForm() {
    formData.add({
      'id': getLastId() + 1, // Menggunakan getLastId untuk id dinamis
      'fullname': '',
      'relationship': '',
      'birthdate': '',
      'marital_status': '',
      'job': ''
    });
  }

  // Hapus form berdasarkan index jika lebih dari satu form
  Future<void> removeForm(int index) async {
    if (formData.length > 1) {
      final dataToRemove = formData[index];
      int idToRemove;
      if (dataToRemove['id'] is String) {
        idToRemove = int.tryParse(dataToRemove['id']) ?? 0;
        await provider.removeProfile('kontak_keluarga', idToRemove);
      } else if (dataToRemove['id'] is int) {
        idToRemove = dataToRemove['id'];
        await provider.removeProfile('kontak_keluarga', idToRemove);
      }
      formData.removeAt(index);
    }
  }

  Future<void> saveForm(int index) async {
    final dataToSave = formData[index];
    if (dataToSave['fullname'] != '' &&
        dataToSave['relationship'] != '' &&
        dataToSave['birthdate'] != '' &&
        dataToSave['marital_status'] != '' &&
        dataToSave['job'] != '') {
      isLoading(true);
      try {
        final response = await apiFamily.saveSubmit(formData);
        if (response.statusCode == 200) {
          getProfile();
          showSuccessSnackbar('Data berhasil diperbarui');
        } else {
          showErrorSnackbar('Error: ${response.body}');
        }
      } catch (e) {
        showErrorSnackbar('Error: $e');
      } finally {
        isLoading(false);
      }
    } else {
      showErrorSnackbar(
          'Form tidak valid, pastikan anda menghisi form dengan benar!');
    }
  }

  // Update form berdasarkan key dan value
  void updateForm(int index, String key, dynamic value) {
    formData[index][key] = value;
    formData.refresh(); // Memperbarui UI setelah data diubah
  }

  // Ambil data profil pengguna
  Future<void> getProfile() async {
    isLoading(true);
    try {
      final response = await provider.getProfile();
      if (response.statusCode == 200) {
        final fetch = jsonDecode(response.body) as Map<String, dynamic>;
        final family = fetch['account']['family'];
        formData.clear();
        for (var contact in family) {
          formData.add({
            'id': contact['id']?.toString() ??
                (getLastId() + 1).toString(), // Menangani id null
            'fullname': contact['fullname'] ?? '',
            'relationship': contact['relationship'] ?? '',
            'birthdate': contact['birthdate'] ?? '',
            'marital_status': contact['maritalStatus'] ?? '',
            'job': contact['job'] ?? '',
          });
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
}
