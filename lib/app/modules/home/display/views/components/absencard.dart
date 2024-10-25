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
            ),
          ),
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
        Obx(() => _buildTimeText(absensiC.timeIn.value,
            absensiC.statusIn.value == 'late' ? false : true)),
        Obx(() => _buildTimeText(absensiC.timeOut.value,
            absensiC.statusOut.value == 'late' ? false : true)),
      ],
    );
  }

  Widget _buildTimeText(String time, bool status) {
    return Text(
      time,
      style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: status ? Colors.black : dangerColor),
    );
  }

  Widget _buildViewAbsenceButton() {
    return TextButton(
      onPressed: () => Get.offAllNamed('/beranda/absen'),
      child: const Text(
        "Riwayat Absensi",
        style: TextStyle(fontSize: 13, color: primaryColor),
      ),
    );
  }

  Widget _buildActionButtons(GpsController gpsC, AbsensiController absensiC) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildAbsenceButton(
          label: 'Absen Masuk',
          icon: Icons.login,
          isVisible: absensiC.btnIn.isFalse,
          onPressed: gpsC.isWithinRange.value
              ? () => Get.offAllNamed('/beranda/absen/photo',
                  arguments: {'initial': 'in'})
              : null,
        ),
        _buildAbsenceButton(
          label: 'Absen Pulang',
          icon: Icons.logout,
          isVisible: absensiC.btnOut.isFalse,
          onPressed: gpsC.isWithinRange.value
              ? () => Get.offAllNamed('/beranda/absen/photo',
                  arguments: {'initial': 'out'})
              : null,
        ),
      ],
    );
  }

  Widget _buildAbsenceButton({
    required String label,
    required IconData icon,
    required bool isVisible,
    required VoidCallback? onPressed,
  }) {
    return isVisible
        ? ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon, color: bgColor),
            label: Text(label, style: const TextStyle(color: bgColor)),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
