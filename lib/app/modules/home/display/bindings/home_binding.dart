import 'package:esas/app/modules/login/controllers/login_controller.dart';
import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:esas/app/networks/api/beranda/api_beranda.dart';
import 'package:get/get.dart';

import '../../../absensi/controllers/photo_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<PhotoController>(
      () => PhotoController(),
    );
    Get.lazyPut<ApiBeranda>(
      () => ApiBeranda(),
    );
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
  }
}
