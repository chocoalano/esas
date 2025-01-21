import 'package:esas/app/modules/login/controllers/login_controller.dart';
import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
