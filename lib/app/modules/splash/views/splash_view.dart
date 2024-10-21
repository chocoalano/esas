import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: bgColor, // Ubah background status bar
      statusBarIconBrightness: Brightness.dark, // Ubah warna icon status bar
    ));
    controller.cekToken();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Image.asset('assets/images/sas-logo.png'),
        ),
      ),
    );
  }
}
