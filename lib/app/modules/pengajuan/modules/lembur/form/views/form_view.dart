import 'package:esas/components/btn_action.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/form_controller.dart';
import 'form_card.dart';

class FormView extends GetView<FormController> {
  const FormView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await showBackDialog() ?? false;
        if (context.mounted && shouldPop) {
          Get.offAllNamed('/pengajuan/lembur/form');
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: _buildAppBar(),
        body: Obx(
          () => ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              ..._buildFormList(),
              const SizedBox(height: 20),
              BtnAction(
                act: controller.submitForm,
                color: primaryColor,
                icon: Icons.save_alt_outlined,
                isLoading: controller.isLoading,
                title: 'Ajukan sekarang',
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: primaryColor,
      title: const Text('Form Lembur', style: TextStyle(color: Colors.white)),
      leading: IconButton(
        onPressed: () => Get.offAllNamed('/pengajuan/lembur/list'),
        icon: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      actions: [
        IconButton(
          onPressed: controller.addForm,
          icon: const Icon(Icons.add, color: Colors.white),
        ),
      ],
    );
  }

  List<Widget> _buildFormList() {
    return List.generate(controller.formList.length, (index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FormCard(
          index: index,
          onRemove: () => controller.removeForm(index),
          onUserChange: (value) => controller.fetchUserData(value!),
        ),
      );
    });
  }
}
