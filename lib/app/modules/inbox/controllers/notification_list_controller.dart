import 'package:esas/app/data/inbox/notification/notification_model.dart';
import 'package:esas/app/networks/api/api_inbox.dart';
import 'package:esas/constant.dart';
import 'package:get/get.dart';

class NotificationListController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ApiInbox provider = Get.put(ApiInbox());

  // Pagination Variables
  final int limit = 10;
  int page = 1;
  var hasMore = true.obs;
  var list = <NotificationListModel>[].obs;
  var isLoading = false.obs;

  Future<void> loadMoreList() async {
    isLoading(true);
    try {
      List<NotificationListModel> response =
          await provider.fetchPaginateNotification(page, limit);
      if (response.length < limit) {
        hasMore.value = false;
      }
      list.addAll(response);
      page++;
    } catch (e) {
      showErrorSnackbar('Error: $e');
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

  Future<void> isreadInformation(int id, String type) async {
    try {
      final notification = list.firstWhere((item) => item.id == id);
      await provider.isreadNotificationAction(id);
      notification.isread = 'y';
      list.refresh();
      switch (type) {
        case 'pengajuan-cuti':
          Get.offAllNamed('/pengajuan/cuti/list');
        case 'pengajuan-korbsen':
          Get.offAllNamed('/pengajuan/koreksi-absen/list');
        case 'pengajuan-lembur':
          Get.offAllNamed('/pengajuan/lembur/list');
        case 'perubahan-shift':
          Get.offAllNamed('/pengajuan/perubahan-shift/list');
      }
    } catch (e) {
      showErrorSnackbar('Error: $e');
    }
  }
}
