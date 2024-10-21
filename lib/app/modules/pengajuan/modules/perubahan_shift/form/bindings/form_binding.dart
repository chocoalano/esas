import 'package:esas/app/networks/api/pengajuan/api_perubahan_shift.dart';
import 'package:get/get.dart';

import '../controllers/form_controller.dart';

class FormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormController>(
      () => FormController(),
    );
    Get.lazyPut<ApiPerubahanShift>(
      () => ApiPerubahanShift(),
    );
  }
}
