import 'package:esas/app/modules/pengajuan/modules/perubahan_shift/form/bindings/form_binding.dart';
import 'package:esas/app/modules/pengajuan/modules/perubahan_shift/form/views/form_view.dart';
import 'package:esas/app/modules/pengajuan/modules/perubahan_shift/list/bindings/list_binding.dart';
import 'package:esas/app/modules/pengajuan/modules/perubahan_shift/list/views/list_view.dart';
import 'package:esas/auth_middleware.dart';
import 'package:get/get.dart';

class PerubahanShiftRoutes {
  static final routes = [
    GetPage(
        name: '/pengajuan/perubahan-shift/list',
        page: () => const ListPerubahanShiftView(),
        binding: ListBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/pengajuan/perubahan-shift/form',
        page: () => const FormView(),
        binding: FormBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
  ];
}
