import 'dart:convert';

import 'package:esas/app/models/Permit/permit_detail.dart';
import 'package:esas/app/networks/api/pengajuan/api_permit.dart';
import 'package:esas/components/widgets/snackbar.dart';
import 'package:get/get.dart';

class PengajuanShowController extends GetxController {
  final ApiPermit provider = Get.find<ApiPermit>();
  var detail = PermitDetail().obs;
  var isLoading = false.obs;

  Future<void> loadDetail(int permitId) async {
    isLoading.value = true;
    try {
      final response = await provider.detailPermit(permitId);
      final fetch = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        detail.value = PermitDetail.fromJson(fetch['data']);
      } else {
        showErrorSnackbar('Terjadi kesalahan ketika memuat data dari server');
      }
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
