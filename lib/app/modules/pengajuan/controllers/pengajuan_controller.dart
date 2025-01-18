import 'package:esas/app/models/Permit/permit_type.dart';
import 'package:esas/app/networks/api/pengajuan/api_permit.dart';
import 'package:esas/components/widgets/snackbar.dart';
import 'package:get/get.dart';

class PengajuanController extends GetxController {
  final ApiPermit provider = Get.find<ApiPermit>();
  var list = <PermitType>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadMoreList();
  }

  Future<void> loadMoreList() async {
    isLoading.value = true;
    try {
      final response = await provider.listType();
      list.addAll(response);
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
