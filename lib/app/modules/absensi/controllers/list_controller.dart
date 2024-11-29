import 'package:esas/app/data/attendance_model.dart';
import 'package:esas/app/networks/api/beranda/api_absen.dart';
import 'package:esas/constant.dart';
import 'package:get/get.dart';

class ListController extends GetxController {
  final ApiAbsen provider = ApiAbsen();
  final int limit = 15;
  var isLoading = false.obs;
  int page = 1;
  var filter = (DateTime.now().month).toString().obs;
  var hasMore = true.obs;
  var list = <AttendanceModel>[].obs;

  final List<Map<String, String>> months = [
    {'nama': 'January', 'value': '1'},
    {'nama': 'February', 'value': '2'},
    {'nama': 'March', 'value': '3'},
    {'nama': 'April', 'value': '4'},
    {'nama': 'May', 'value': '5'},
    {'nama': 'June', 'value': '6'},
    {'nama': 'July', 'value': '7'},
    {'nama': 'August', 'value': '8'},
    {'nama': 'September', 'value': '9'},
    {'nama': 'October', 'value': '10'},
    {'nama': 'November', 'value': '11'},
    {'nama': 'December', 'value': '12'},
  ];

  Future loadMoreList() async {
    try {
      isLoading(true);
      List<AttendanceModel> response =
          await provider.fetchPaginate(page, limit, filter.value);
      if (response.length < limit) {
        hasMore.value = false;
      }

      list.addAll(response);
      page++;
    } catch (e) {
      showErrorSnackbar(e.toString());
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
}
