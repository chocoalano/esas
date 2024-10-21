import 'package:esas/app/networks/api/pengajuan/api_cuti.dart';
import 'package:esas/constant.dart';
import 'package:get/get.dart';

import '../../models/list_cuti_model.dart';

class ListController extends GetxController {
  final ApiCuti provider = ApiCuti();
  final int _limit = 15;
  int _page = 1;
  var hasMore = true.obs;
  var list = <ListCutiModel>[].obs;

  Future loadMoreList() async {
    try {
      List<ListCutiModel> response =
          await provider.fetchPaginate(_page, _limit);
      if (response.length < _limit) {
        hasMore.value = false;
      }

      list.addAll(response);
      _page++;
    } catch (e) {
      showErrorSnackbar(e.toString());
    }
  }

  Future refreshData() async {
    _page = 1;
    hasMore.value = true;
    list.value = [];
    await loadMoreList();
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
