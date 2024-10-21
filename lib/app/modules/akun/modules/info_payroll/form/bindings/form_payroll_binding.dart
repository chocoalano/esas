import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:get/get.dart';

import '../controllers/form_payroll_controller.dart';

class FormPayrollBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormPayrollController>(
      () => FormPayrollController(),
    );
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
  }
}
