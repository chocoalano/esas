import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:get/get.dart';

import '../controllers/akun_pendidikan_pengalaman_controller.dart';

class PendidikanPengalamanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AkunPendidikanPengalamanController>(
      () => AkunPendidikanPengalamanController(),
    );
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
  }
}
