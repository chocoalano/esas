import 'package:esas/app/modules/home/models/anouncement_model.dart';
import 'package:esas/app/networks/api/beranda/api_beranda.dart';
import 'package:esas/constant.dart';
import 'package:get/get.dart';

class AnouncementController extends GetxController {
  final ApiBeranda provider = Get.put(ApiBeranda());
  final int limit = 15;
  int page = 1;
  var hasMore = true.obs;
  var list = <AnouncementModel>[].obs;

  Future loadMoreList() async {
    try {
      List<AnouncementModel> response =
          await provider.announcementRequest(page, limit);
      if (response.length < limit) {
        hasMore.value = false;
      }

      list.addAll(response);
      page++;
    } catch (e) {
      showErrorSnackbar(e.toString());
    }
  }

  Future refreshData() async {
    page = 1;
    hasMore.value = true;
    list.value = [];
    await loadMoreList();
  }
}
