import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:get/get.dart';

import '../controllers/ubah_password_controller.dart';

class UbahPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UbahPasswordController>(
      () => UbahPasswordController(),
    );
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
  }
}
