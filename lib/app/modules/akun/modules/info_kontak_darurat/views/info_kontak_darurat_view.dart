import 'package:esas/components/btn_action.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/info_kontak_darurat_controller.dart';
import 'form_card.dart';

class InfoKontakDaruratView extends GetView<InfoKontakDaruratController> {
  const InfoKontakDaruratView({super.key});
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          title: const Text(
            'Info kontak darurat',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () => Get.offAllNamed('/akun'),
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              )),
          actions: [
            IconButton(
                onPressed: controller.addForm,
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ))
          ],
        ),
        body: Obx(() {
          return ListView.builder(
            itemCount: controller.formData.length,
            itemBuilder: (context, index) {
              return FormCard(
                index: index,
                onRemove: () => controller.removeForm(index),
              );
            },
          );
        }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity, // Mengisi lebar penuh
            child: BtnAction(
                act: () => controller.saveProfile(),
                color: primaryColor,
                icon: Icons.save_as_outlined,
                isLoading: controller.isLoading,
                title: 'Simpan data'),
          ),
        ),
      ),
    );
  }
}
