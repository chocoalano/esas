import 'package:esas/app/data/pengajuan_model.dart';
import 'package:esas/app/networks/api/api_inbox.dart';
import 'package:esas/constant.dart';
import 'package:get/get.dart';

class PersetujuanController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ApiInbox provider = Get.put(ApiInbox());

  // Pagination Variables
  final int limit = 10;
  int page = 1;
  var hasMore = true.obs;
  var list = <PengajuanModel>[].obs;
  bool isLoading = false;

  Future<void> fetchPengajuan() async {
    isLoading = true;
    try {
      List<PengajuanModel> response =
          await provider.fetchPaginatePengajuan(page, limit);
      if (response.length < limit) {
        hasMore.value = false;
      }

      list.addAll(response);
      page++;
    } finally {
      isLoading = false;
    }
  }

  Future<void> approval(int id, String tablename, String status) async {
    try {
      await provider.approval(id, status, tablename);
    } catch (e) {
      showErrorSnackbar('Error: $e');
    }
    Get.back();
  }
}
