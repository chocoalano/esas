import 'package:esas/app/models/notification/notification_model.dart';
import 'package:esas/app/networks/api/api_inbox.dart';
import 'package:esas/components/widgets/snackbar.dart';
import 'package:get/get.dart';

class InboxController extends GetxController {
  final ApiInbox provider = Get.find<ApiInbox>();

  var list = <NotificationModel>[].obs;
  var isLoading = false.obs;
  final int limit = 10;
  var page = 1.obs;
  var hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadMoreList();
  }

  Future<void> loadMoreList() async {
    if (isLoading.value || !hasMore.value) {
      return;
    }
    isLoading.value = true;
    try {
      final response = await provider.fetchPaginate(page.value, limit);
      if (response.length < limit) {
        hasMore.value = false;
      }
      list.addAll(response);
      page.value++;
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    page.value = 1;
    hasMore.value = true;
    list.clear();
    await loadMoreList();
  }

  Future<void> read(int notifId) async {
    isLoading.value = true;
    try {
      final response = await provider.isread(notifId);
      if (response == 200) {
        refreshData();
      } else {
        showErrorSnackbar(
            'Terjadi kesalahan server ketika membaca data pemberitahuan!');
      }
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> clearData() async {
    isLoading.value = true;
    try {
      final response = await provider.clear();
      if (response == 200) {
        refreshData();
      } else {
        showErrorSnackbar(
            'Terjadi kesalahan server ketika membersihkan data pemberitahuan!');
      }
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
