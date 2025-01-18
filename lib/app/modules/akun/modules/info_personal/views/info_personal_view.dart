import 'package:esas/components/widgets/globat_appbar.dart';
import 'package:esas/constant.dart';
import 'package:esas/support/support.dart';
import 'package:esas/support/typography.dart';
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
        backgroundColor: bgColor,
        appBar: GlobatAppbar(
          title: 'Info Personal',
          act: () => Get.offAllNamed('/akun'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: _buildInfo(controller),
              ),
              const SizedBox(
                height: 30,
              ),
              Obx(() => controller.isBanner.isTrue
                  ? MaterialBanner(
                      elevation: 0,
                      forceActionsBelow: true,
                      backgroundColor: primaryColor,
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Jika terdapat ketidak sesuaian data, anda dapat menghubungi Dept. HR untuk merevisinya hingga sesuai dengan data diri anda. sesuaikan data anda untuk penggunaan yang lebih nyaman.',
                          style: textWhite,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => controller.isBanner(false),
                          child: Text(
                            'Ya, saya mengerti.',
                            style: textWhite,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink()),
            ],
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
                  _buildInfoRow('Tanggal lahir',
                      formatDate(controller.profile.value.datebirth)),
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
