import 'package:esas/app/networks/api/pengajuan/api_perubahan_shift.dart';
import 'package:esas/constant.dart';
import 'package:get/get.dart';

import '../../models/perubahan_shift_model.dart';

class ListController extends GetxController {
  final ApiPerubahanShift provider = Get.put(ApiPerubahanShift());
  var list = <ListPerubahanShifyModel>[].obs;
  var isLoading = true.obs;
  final int limit = 20;
  int page = 1;
  var hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadMoreData();
  }

  Future<void> loadMoreData() async {
    isLoading.value = true;
    try {
      List<ListPerubahanShifyModel> response =
          await provider.fetchPaginate(page, limit);
      if (response.length < limit) {
        hasMore.value = false;
      }
      list.addAll(response);
      page++;
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk reset list jika dibutuhkan (misalnya refresh)
  Future<void> refreshData() async {
    page = 1;
    list.value = [];
    hasMore.value = true;
    await loadMoreData();
  }

  // Fungsi approval
  Future<void> approval(int id, String tablename, String status) async {
    try {
      await provider.approval(id, status, tablename);
    } catch (e) {
      showErrorSnackbar('Error: $e');
    }
    Get.back();
  }
}
