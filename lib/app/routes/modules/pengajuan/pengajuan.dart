import 'package:esas/app/modules/pengajuan/bindings/pengajuan_binding.dart';
import 'package:esas/app/modules/pengajuan/views/pengajuan_create_view.dart';
import 'package:esas/app/modules/pengajuan/views/pengajuan_list_view.dart';
import 'package:esas/app/modules/pengajuan/views/pengajuan_show_view.dart';
import 'package:esas/app/modules/pengajuan/views/pengajuan_view.dart';
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
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '$path/cuti',
        page: () => const PengajuanListView(),
        binding: PengajuanBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '$path/cuti/create',
        page: () => const PengajuanCreateView(),
        binding: PengajuanBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '$path/cuti/show',
        page: () => const PengajuanShowView(),
        binding: PengajuanBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
  ];
}
