import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:get/get.dart';

import '../controllers/info_payroll_controller.dart';

class InfoPayrollBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfoPayrollController>(
      () => InfoPayrollController(),
    );
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
  }
}