import 'package:esas/components/alert_banner.dart';
import 'package:esas/components/globat_appbar.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/info_personal_controller.dart';

class InfoPersonalView extends GetView<InfoPersonalController> {
  const InfoPersonalView({super.key});

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
          title: 'Info Personal',
          act: () => Get.offAllNamed('/akun'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_buildInfo(controller)],
          ),
        ),
      ),
    );
  }

  Widget _buildInfo(InfoPersonalController controller) {
    return Obx(() {
      if (controller.isloading.isFalse) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Data Pribadi',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black54),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildInfoRow(
                      'Nama',
                      limitString(
                          controller.profile.value.name ?? 'Unknown', 20)),
                  _buildInfoRow(
                      'NIP', controller.profile.value.nip ?? 'Unknown'),
                  _buildInfoRow(
                      'Email',
                      limitString(
                          controller.profile.value.email ?? 'Unknown', 30)),
                  _buildInfoRow(
                      'Tlp/HP', controller.profile.value.phone ?? 'Unknown'),
                  _buildInfoRow(
                      'Tempat lahir',
                      limitString(
                          controller.profile.value.placebirth ?? 'Unknown',
                          30)),
                  _buildInfoRow(
                      'Tanggal lahir',
                      formatDate(controller.profile.value.datebirth) ??
                          'Unknown'),
                  _buildInfoRow('Jenis Kelamin',
                      jenisKelamin(controller.profile.value.gender ?? 'm')),
                  _buildInfoRow('Gol. Darah',
                      controller.profile.value.blood ?? 'Unknown'),
                  _buildInfoRow(
                      'Status pernikahan',
                      statusPernikahan(
                          controller.profile.value.maritalStatus ?? 'single')),
                  _buildInfoRow(
                      'Agama', controller.profile.value.religion ?? 'Unknown'),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AlertBanner(
              act: controller.showBanner,
              color: infoColor,
              msg:
                  'Jika terdapat ketidaksesuaian data, anda dapat menghubungi Dept. HR!',
              show: controller.isBanner,
            )
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
