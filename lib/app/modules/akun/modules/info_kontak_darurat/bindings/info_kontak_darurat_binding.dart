import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:esas/app/networks/api/akun/api_kontak_darurat.dart';
import 'package:get/get.dart';
import '../controllers/info_kontak_darurat_controller.dart';

class InfoKontakDaruratBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfoKontakDaruratController>(
      () => InfoKontakDaruratController(),
    );
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
    Get.lazyPut<ApiEmergencyContact>(
      () => ApiEmergencyContact(),
    );
  }
}
