import 'package:esas/app/models/attendance/detail.dart';
import 'package:esas/app/networks/api/beranda/api_absen.dart';
import 'package:esas/components/widgets/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ListController extends GetxController {
  final ApiAbsen provider = ApiAbsen();
  final int page = 1;
  final int limit = 15;

  // Reactive variables
  var isLoading = false.obs;
  var filter = (DateTime.now().month).obs;
  var list = <Detail>[].obs;

  // Month names for the calendar
  final List<Map<String, String>> months = List.generate(12, (index) {
    final monthName = DateFormat.MMMM().format(DateTime(0, index + 1));
    return {'nama': monthName, 'value': '${index + 1}'};
  });

  @override
  void onInit() {
    super.onInit();
    loadMoreList(filter.value.toString()); // Load initial data
  }

  void calendarSelected(int date) {
    if (filter.value != date) {
      filter(date); // Update the filter only if it changes
      refreshData(); // Refresh the list with the new filter
    }
  }

  Future<void> loadMoreList(String filter) async {
    try {
      isLoading(true); // Show loading indicator
      // Fetch paginated data from the API
      List<Detail> response = await provider.fetchPaginate(page, limit, filter);

      // Clear the current list and add new data
      list.clear();
      list.addAll(response);

      // Force UI update to prevent stale data (useful for cached widgets)
      list.refresh();
      if (kDebugMode) {
        print("===================>>>>>>>>${list[1].timeOut}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error in loadMoreList: ${e.toString()}");
      }
      showErrorSnackbar(
          "Terjadi kesalahan pada controller list absen: ${e.toString()}");
    } finally {
      isLoading(false); // Hide loading indicator
    }
  }

  Future<void> refreshData() async {
    try {
      isLoading(true); // Show loading indicator
      list.clear(); // Clear the current list
      await loadMoreList(filter.value.toString()); // Reload data
    } catch (e) {
      if (kDebugMode) {
        print("Error in refreshData: ${e.toString()}");
      }
      showErrorSnackbar("Gagal memuat ulang data: ${e.toString()}");
    } finally {
      isLoading(false); // Hide loading indicator
    }
  }
}
