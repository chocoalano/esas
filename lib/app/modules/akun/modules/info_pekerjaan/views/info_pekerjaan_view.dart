import 'package:esas/components/widgets/globat_appbar.dart';
import 'package:esas/constant.dart';
import 'package:esas/support/support.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/info_pekerjaan_controller.dart';

class InfoPekerjaanView extends GetView<InfoPekerjaanController> {
  const InfoPekerjaanView({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        Get.offAllNamed('/akun');
      },
      child: Scaffold(
        appBar: GlobatAppbar(
          title: 'Info pekerjaan',
          act: () => Get.offAllNamed('/akun'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_buildAttendanceInfo(controller)],
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceInfo(InfoPekerjaanController controller) {
    return Obx(() {
      final data = controller.profile.value;
      if (controller.isloading.isFalse) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Data pekerjaan',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black54),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildInfoRow('NIP', data.nip ?? 'Unknown'),
                  _buildInfoRow('Nama', data.name ?? 'Unknows'),
                  _buildInfoRow(
                      'email', limitString(data.email ?? 'Unknows', 30)),
                  _buildInfoRow('Kantor', data.company ?? 'Unknows'),
                  _buildInfoRow('Departemen', data.departement ?? 'Unknows'),
                  _buildInfoRow('Jabatan', data.position ?? 'Unknows'),
                  _buildInfoRow('Tgl. Bergabung', formatDate(data.joinDate)),
                  _buildInfoRow('Tgl. Masuk', formatDate(data.signDate)),
                ],
              ),
            ),
          ],
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        );
      }
    });
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: _labelStyle()),
          const SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }

  TextStyle _labelStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.grey[600],
    );
  }
}
