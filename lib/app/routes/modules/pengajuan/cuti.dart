import 'package:esas/app/modules/pengajuan/modules/cuti/form/bindings/form_binding.dart';
import 'package:esas/app/modules/pengajuan/modules/cuti/form/views/form_view.dart';
import 'package:esas/app/modules/pengajuan/modules/cuti/list/bindings/list_binding.dart';
import 'package:esas/app/modules/pengajuan/modules/cuti/list/views/list_view.dart';
import 'package:esas/auth_middleware.dart';
import 'package:get/get.dart';

class CutiRoutes {
  static const path = '/pengajuan';
  static final routes = [
    GetPage(
        name: '$path/cuti/list',
        page: () => const ListCutiView(),
        binding: ListBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '$path/cuti/form',
        page: () => const FormCutiView(),
        binding: FormBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
  ];
}
