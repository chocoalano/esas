import 'package:esas/app/modules/pengajuan/display/bindings/pengajuan_binding.dart';
import 'package:esas/app/modules/pengajuan/display/views/pengajuan_view.dart';
import 'package:esas/auth_middleware.dart';
import 'package:get/get.dart';

class PengajuanRoutes {
  static const path = '/pengajuan';
  static final routes = [
    GetPage(
        name: path,
        page: () => const PengajuanView(),
        binding: PengajuanBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()])
  ];
}
