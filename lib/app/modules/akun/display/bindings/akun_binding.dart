import 'package:esas/app/modules/home/display/controllers/home_controller.dart';
import 'package:esas/app/modules/login/controllers/login_controller.dart';
import 'package:get/get.dart';

import '../controllers/akun_controller.dart';

class AkunBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AkunController>(
      () => AkunController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
