import 'package:esas/app/data/inbox/pengajuan/pengajuan_model.dart';
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
  var isLoading = false.obs;

  Future<void> loadMoreList() async {
    isLoading(true);
    try {
      List<PengajuanModel> response =
          await provider.fetchPaginatePengajuan(page, limit);
      if (response.length < limit) {
        hasMore.value = false;
      }
      list.addAll(response);
      page++;
    } finally {
      isLoading(false);
    }
  }

  Future refreshData() async {
    page = 1;
    hasMore.value = true;
    list.value = [];
    await loadMoreList();
  }

  Future<void> approval(int id, String tablename, String status) async {
    try {
      await provider.approval(id, status, tablename);
      refreshData();
    } catch (e) {
      showErrorSnackbar('Error: $e');
    }
    Get.back();
  }
}
