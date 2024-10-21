import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:esas/app/networks/api/akun/api_auth_family.dart';
import 'package:get/get.dart';
import '../controllers/info_keluarga_controller.dart';

class InfoKeluargaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfoKeluargaController>(
      () => InfoKeluargaController(),
    );
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
    Get.lazyPut<ApiAuthFamily>(
      () => ApiAuthFamily(),
    );
  }
}
