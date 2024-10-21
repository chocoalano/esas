import 'package:esas/components/btn_action.dart';
import 'package:esas/components/globat_appbar.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import '../controllers/info_report_bugs_controller.dart';

class InfoReportBugsView extends StatelessWidget {
  InfoReportBugsView({super.key});
  final InfoReportBugsController controller =
      Get.put(InfoReportBugsController());

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
          title: 'Laporan Bugs',
          act: () => Get.offAllNamed('/akun'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // Field for descriptions
                FormBuilderTextField(
                  name: 'descriptions',
                  controller: controller.descriptions,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: primaryColor.withOpacity(0.1),
                    filled: true,
                    labelText: 'Keterangan detail Bug',
                  ),
                  maxLines: 10,
                  validator: FormBuilderValidators.required(
                    errorText: 'Keterangan detail Bug bug harus diisi',
                  ),
                ),
                const SizedBox(height: 20),
                // Image display and picker
                Obx(() => controller.selectedFile.value != null
                    ? ClipOval(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Obx(() => Image.file(
                                controller.selectedFile.value!,
                                fit: BoxFit.cover,
                              )),
                        ),
                      )
                    : const Text('Belum ada gambar bukti disisipkan.')),
                const SizedBox(height: 10),
                // Button to pick image
                TextButton.icon(
                  onPressed: controller.pickFile,
                  icon: const Icon(
                    Icons.camera_alt,
                    color: primaryColor,
                  ),
                  label: const Text(
                    'Pilih gambar',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Submit button at the bottom of the screen
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: BtnAction(
                act: () {
                  controller.submitForm();
                },
                color: primaryColor,
                icon: Icons.save_alt,
                isLoading: controller.isloading,
                title: 'Laporkan Bug',
              ),
            )),
      ),
    );
  }
}
