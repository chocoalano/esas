import 'package:esas/app/modules/absensi/controllers/gps_controller.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../absensi/controllers/absensi_controller.dart';

class Absencard extends StatelessWidget {
  const Absencard({super.key});

  @override
  Widget build(BuildContext context) {
    final GpsController gpsC = Get.put(GpsController());
    final AbsensiController absensiC = Get.put(AbsensiController());
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildAbsenceTime(absensiC),
          const SizedBox(height: 20),
          Center(
              child: Obx(
            () => gpsC.isWithinRange.isFalse
                ? Text(
                    "Jarak anda dengan lokasi absen adalah ${gpsC.currentDistance.round()} m")
                : _buildActionButtons(gpsC, absensiC),
          )),
          const SizedBox(height: 20),
          _buildViewAbsenceButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Absen Masuk',
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Text(
          'Absen Keluar',
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildAbsenceTime(AbsensiController absensiC) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => Text(
              absensiC.timeIn.value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
        Obx(() => Text(
              absensiC.timeOut.value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Widget _buildViewAbsenceButton() {
    return TextButton(
      child: const Text(
        "Riwayat Absensi",
        style: TextStyle(fontSize: 13, color: primaryColor),
      ),
      onPressed: () => Get.offAllNamed('/beranda/absen'),
    );
  }

  Widget _buildActionButtons(GpsController gpsC, AbsensiController absensiC) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildAbsenceInButton(gpsC, absensiC),
            _buildAbsenceOutButton(gpsC, absensiC),
          ],
        ));
  }

  Widget _buildAbsenceInButton(GpsController gpsC, AbsensiController absensiC) {
    return ElevatedButton.icon(
      onPressed: gpsC.isWithinRange.value || absensiC.btnIn.isFalse
          ? () => Get.offAllNamed('/beranda/absen/photo',
              arguments: {'initial': 'in'})
          : null,
      icon: const Icon(Icons.login, color: bgColor),
      label: const Text('Absen Masuk', style: TextStyle(color: bgColor)),
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _buildAbsenceOutButton(
      GpsController controller, AbsensiController absensiC) {
    return ElevatedButton.icon(
      onPressed: controller.isWithinRange.value || absensiC.btnOut.isFalse
          ? () => Get.offAllNamed('/beranda/absen/photo',
              arguments: {'initial': 'out'})
          : null,
      icon: const Icon(Icons.logout, color: bgColor),
      label: const Text('Absen Pulang', style: TextStyle(color: bgColor)),
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
