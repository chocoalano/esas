import 'package:esas/app/modules/pengajuan/controllers/pengajuan_create_controller.dart';
import 'package:esas/app/modules/pengajuan/controllers/pengajuan_show_controller.dart';
import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:esas/app/networks/api/pengajuan/api_permit.dart';
import 'package:get/get.dart';

import '../controllers/pengajuan_controller.dart';
import '../controllers/pengajuan_list_controller.dart';

class PengajuanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiPermit>(
      () => ApiPermit(),
    );
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
    Get.lazyPut<PengajuanController>(
      () => PengajuanController(),
    );
    Get.lazyPut<PengajuanListController>(
      () => PengajuanListController(),
    );
    Get.lazyPut<PengajuanShowController>(
      () => PengajuanShowController(),
    );
    Get.lazyPut<PengajuanCreateController>(
      () => PengajuanCreateController(),
    );
  }
}
