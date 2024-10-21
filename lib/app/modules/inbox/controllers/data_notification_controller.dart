import 'package:esas/app/data/notification_model.dart';
import 'package:esas/app/networks/api/api_inbox.dart';
import 'package:esas/constant.dart';
import 'package:get/get.dart';

class DataNotificationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ApiInbox provider = Get.put(ApiInbox());

  // Pagination Variables
  final int limit = 10;
  int page = 1;
  var hasMore = true.obs;
  var list = <NotificationModel>[].obs;
  bool isLoading = false;

  Future<void> fetchPemberitahuan() async {
    isLoading = true;
    try {
      List<NotificationModel> response =
          await provider.fetchPaginateNotification(page, limit);
      if (response.length < limit) {
        hasMore.value = false;
      }
      list.addAll(response);
      page++;
    } catch (e) {
      showErrorSnackbar('Error: $e');
    } finally {
      isLoading = false;
    }
  }

  Future<void> isreadInformation(int id, String type) async {
    try {
      final notification = list.firstWhere((item) => item.id == id);
      await provider.isreadNotificationAction(id);
      notification.isRead = 'y';
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
