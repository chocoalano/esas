import 'package:esas/app/modules/pengajuan/modules/lembur/form/bindings/form_binding.dart';
import 'package:esas/app/modules/pengajuan/modules/lembur/form/views/form_view.dart';
import 'package:esas/app/modules/pengajuan/modules/lembur/list/bindings/list_binding.dart';
import 'package:esas/app/modules/pengajuan/modules/lembur/list/views/list_view.dart';
import 'package:esas/auth_middleware.dart';
import 'package:get/get.dart';

class LemburRoutes {
  static final routes = [
    GetPage(
        name: '/pengajuan/lembur/list',
        page: () => const ListLemburView(),
        binding: ListBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/pengajuan/lembur/form',
        page: () => const FormView(),
        binding: FormBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
  ];
}
