import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:get/get.dart';

import '../controllers/info_report_bugs_controller.dart';

class InfoReportBugsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfoReportBugsController>(
      () => InfoReportBugsController(),
    );
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
  }
}
