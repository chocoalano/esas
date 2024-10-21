import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:esas/services/storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../login/controllers/login_controller.dart';

class SplashController extends GetxController {
  final ApiAuth provider = Get.put(ApiAuth());
  final Storage storage = Get.put(Storage());
  final GetStorage getLocalStorage = GetStorage();
  final LoginController loginController = Get.put(LoginController());

  Future<void> cekToken() async {
    if (getLocalStorage.read<String>('token') == null) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        Get.offAllNamed('/login');
      });
    } else {
      await loginController.autoLogin();
    }
  }
}
