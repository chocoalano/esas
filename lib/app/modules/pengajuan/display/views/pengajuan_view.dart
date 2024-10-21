import 'package:esas/components/BottomNavigation/bot_nav_view.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pengajuan_controller.dart';

class PengajuanView extends GetView<PengajuanController> {
  const PengajuanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: const Text(
          'Pengajuan',
          style: TextStyle(color: bgColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              const Text(
                'Ajukan untuk',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 16),
              _buildPengajuanOption(
                context,
                icon: Icons.location_on,
                text: 'Koreksi Absensi',
                onTap: () => Get.offAllNamed('/pengajuan/koreksi-absen/list'),
              ),
              _buildPengajuanOption(
                context,
                icon: Icons.swap_horiz,
                text: 'Perubahan Shift',
                onTap: () => Get.offAllNamed('/pengajuan/perubahan-shift/list'),
              ),
              _buildPengajuanOption(
                context,
                icon: Icons.timer,
                text: 'Lembur',
                onTap: () => Get.offAllNamed('/pengajuan/lembur/list'),
              ),
              _buildPengajuanOption(
                context,
                icon: Icons.watch_later,
                text: 'Cuti',
                onTap: () => Get.offAllNamed('/pengajuan/cuti/list'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BotNavView(),
    );
  }

  Widget _buildPengajuanOption(BuildContext context,
      {required IconData icon, required String text, VoidCallback? onTap}) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      elevation: 0,
      child: ListTile(
        leading: Icon(icon, color: Colors.black54),
        title: Text(text, style: const TextStyle(fontSize: 16)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
