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
  var isLoading = false.obs;
  var filter = (DateTime.now().month).obs;
  var list = <Detail>[].obs;

  final List<Map<String, String>> months = List.generate(12, (index) {
    final monthName = DateFormat.MMMM().format(DateTime(0, index + 1));
    return {'nama': monthName, 'value': '${index + 1}'};
  });

  void calendarSelected(int date) {
    filter(date);
    loadMoreList(filter.value.toString());
  }

  Future loadMoreList(String filter) async {
    try {
      isLoading(true);
      List<Detail> response = await provider.fetchPaginate(1, 31, filter);
      list.clear();
      list.addAll(response);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      showErrorSnackbar(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future refreshData() async {
    list.value = [];
    await loadMoreList(filter.value.toString());
  }
}
