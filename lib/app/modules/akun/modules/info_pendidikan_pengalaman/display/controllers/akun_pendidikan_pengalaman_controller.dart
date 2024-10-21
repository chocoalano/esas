import 'dart:convert';

import 'package:esas/app/modules/akun/modules/info_pendidikan_pengalaman/display/controllers/models.dart';
import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:esas/constant.dart';
import 'package:get/get.dart';

class AkunPendidikanPengalamanController extends GetxController {
  final ApiAuth provider = Get.find<ApiAuth>();
  var isLoading = false.obs;

  // Data yang akan disimpan setelah di-parsing
  List<FormalEducation> formalEducation = [];
  List<InformalEducation> informalEducation = [];
  List<WorkExperience> workExperience = [];

  void movePage(String page) {
    Get.offAllNamed('/akun/pendidikan-pengalaman/$page');
  }

  Future<void> getProfile() async {
    isLoading(true);
    try {
      final response = await provider.getProfile();
      if (response.statusCode == 200) {
        final fetch = jsonDecode(response.body) as Map<String, dynamic>;
        // Mengambil data formalEducation dari response dan casting ke List
        final formal = (fetch['account']['formalEducation'] as List)
            .cast<Map<String, dynamic>>();
        final informal = (fetch['account']['informalEducation'] as List)
            .cast<Map<String, dynamic>>();
        final pengalaman = (fetch['account']['workExperience'] as List)
            .cast<Map<String, dynamic>>();

        // Parsing data ke model menggunakan map
        formalEducation = formal
            .map<FormalEducation>((e) => FormalEducation.fromJson(e))
            .toList();
        informalEducation = informal
            .map<InformalEducation>((e) => InformalEducation.fromJson(e))
            .toList();
        workExperience = pengalaman
            .map<WorkExperience>((e) => WorkExperience.fromJson(e))
            .toList();
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
