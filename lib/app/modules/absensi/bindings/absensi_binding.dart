import 'package:esas/app/modules/absensi/controllers/qr_code_controller.dart';
import 'package:get/get.dart';

import 'package:esas/app/modules/absensi/controllers/gps_controller.dart';
import 'package:esas/app/modules/absensi/controllers/list_controller.dart';
import 'package:esas/app/modules/absensi/controllers/photo_controller.dart';
import 'package:esas/app/networks/api/beranda/api_absen.dart';

import '../controllers/absensi_controller.dart';

class AbsensiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListController>(
      () => ListController(),
    );
    Get.lazyPut<GpsController>(
      () => GpsController(),
    );
    Get.lazyPut<PhotoController>(
      () => PhotoController(),
    );
    Get.lazyPut<AbsensiController>(
      () => AbsensiController(),
    );
    Get.lazyPut<QrCodeController>(
      () => QrCodeController(),
    );
    Get.lazyPut<ApiAbsen>(
      () => ApiAbsen(),
    );
  }
}
