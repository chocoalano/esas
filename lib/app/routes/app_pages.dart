import 'package:esas/app/routes/modules/pengajuan/cuti.dart';
import 'package:esas/app/routes/modules/pengajuan/koreksi_absen.dart';
import 'package:esas/auth_middleware.dart';
import 'package:get/get.dart';
import '../modules/inbox/bindings/inbox_binding.dart';
import '../modules/inbox/views/inbox_view.dart';
import '../modules/karyawan/bindings/karyawan_binding.dart';
import '../modules/karyawan/views/karyawan_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import 'modules/akun/akun.dart';
import 'modules/akun/info_payroll.dart';
import 'modules/akun/info_pendidikan_pengalaman.dart';
import 'modules/beranda/beranda.dart';
import 'modules/pengajuan/lembur.dart';
import 'modules/pengajuan/pengajuan.dart';
import 'modules/pengajuan/perubahan_shift.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
        name: _Paths.login,
        page: () => const LoginView(),
        binding: LoginBinding(),
        transition: Transition.native),
    GetPage(
        name: _Paths.splash,
        page: () => const SplashView(),
        binding: SplashBinding(),
        transition: Transition.native),
    GetPage(
        name: _Paths.karyawan,
        page: () => const KaryawanView(),
        binding: KaryawanBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.inbox,
        page: () => const InboxView(),
        binding: InboxBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),

    // GROUP ROUTE MODULE BERANDA::START
    ...BerandaRoutes.routes,
    // GROUP ROUTE MODULE BERANDA::END
    // GROUP ROUTE MODULE AKUN::START
    ...AkunRoutes.routes,
    ...InfoPendidikanPengalamanRoutes.routes,
    ...InfoPayrollRoutes.routes,
    // GROUP ROUTE MODULE AKUN::END

    // GROUP ROUTE MODULE PENGAJUAN::START
    ...PengajuanRoutes.routes,
    ...KoreksiAbsenRoutes.routes,
    ...PerubahanShiftRoutes.routes,
    ...LemburRoutes.routes,
    ...CutiRoutes.routes,
    // GROUP ROUTE MODULE PENGAJUAN::END
  ];
}
