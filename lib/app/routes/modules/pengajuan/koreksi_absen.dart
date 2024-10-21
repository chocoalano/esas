import 'package:esas/app/modules/pengajuan/modules/koreksi_absen/form/bindings/form_binding.dart';
import 'package:esas/app/modules/pengajuan/modules/koreksi_absen/form/views/form_view.dart';
import 'package:esas/app/modules/pengajuan/modules/koreksi_absen/list/bindings/list_binding.dart';
import 'package:esas/app/modules/pengajuan/modules/koreksi_absen/list/views/list_view.dart';
import 'package:esas/auth_middleware.dart';
import 'package:get/get.dart';

class KoreksiAbsenRoutes {
  static const path = '/pengajuan';
  static final routes = [
    GetPage(
        name: '$path/koreksi-absen/list',
        page: () => const ListKoreksiAbsenView(),
        binding: ListBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '$path/koreksi-absen/form',
        page: () => const FormView(),
        binding: FormBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
  ];
}
