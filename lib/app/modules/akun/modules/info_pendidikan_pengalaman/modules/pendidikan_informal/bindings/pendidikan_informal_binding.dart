import 'package:esas/app/networks/api/akun/api_auth.dart';
import 'package:esas/app/networks/api/akun/api_info_pendidikan_pengalaman.dart';
import 'package:get/get.dart';

import '../controllers/pendidikan_informal_controller.dart';

class PendidikanInformalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendidikanInformalController>(
      () => PendidikanInformalController(),
    );
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
    Get.lazyPut<ApiInfoPendidikanPengalaman>(
      () => ApiInfoPendidikanPengalaman(),
    );
  }
}
