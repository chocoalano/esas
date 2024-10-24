import 'package:esas/app/modules/pengajuan/widget/date_field_widget.dart';
import 'package:esas/app/modules/pengajuan/widget/dropdown_field_widget.dart';
import 'package:esas/components/btn_action.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/form_controller.dart';

class FormView extends GetView<FormController> {
  const FormView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await showBackDialog() ?? false;
        if (context.mounted && shouldPop) {
          Get.offAllNamed('/pengajuan/lembur/list');
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: _buildAppBar(),
        body: Obx(() {
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    DateFieldWidget(
                        controller: controller.dateOvertimeAt,
                        hintText: 'Pilih tanggal diajukan',
                        icon: Icons.calendar_today,
                        context: context,
                        fillColor: primaryColor.withOpacity(0.1),
                        borderRadius: 15.0,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        onDateSelected: (date) {
                          controller.dateOvertimeAt.text = date;
                          controller.fetchUserData();
                        }),
                    const SizedBox(height: 16),
                    Obx(() => controller.listAdm.isNotEmpty
                        ? DropdownFieldWidget(
                            label: 'Pilih approval adm',
                            icon: Icons.account_circle_outlined,
                            value: controller.userAdm.text.isNotEmpty &&
                                    controller.listAdm.any((item) =>
                                        item.id.toString() ==
                                        controller.userAdm.text)
                                ? controller.userAdm.text
                                : null, // Ensure value is valid and exists in the list
                            items: controller.listAdm.toSet().map((item) {
                              return DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: SizedBox(
                                  width: Get.width / 1.5,
                                  child: Text(
                                    item.name!,
                                    overflow: TextOverflow.visible,
                                    softWrap: true,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                controller.userAdm.text = value;
                              }
                            },
                            fillColor: primaryColor.withOpacity(0.1),
                            borderRadius: 10.0,
                          )
                        : const SizedBox.shrink()),
                    const SizedBox(height: 16),
                    Obx(() => controller.listLine.isNotEmpty
                        ? DropdownFieldWidget(
                            label: 'Pilih approval line',
                            icon: Icons.account_circle_outlined,
                            value: controller.userLine.text.isNotEmpty &&
                                    controller.listAdm.any((item) =>
                                        item.id.toString() ==
                                        controller.userLine.text)
                                ? controller.userLine.text
                                : null, // Ensure value is valid and exists in the list
                            items: controller.listLine.toSet().map((item) {
                              return DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: SizedBox(
                                  width: Get.width / 1.5,
                                  child: Text(
                                    item.name!,
                                    overflow: TextOverflow.visible,
                                    softWrap: true,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                controller.userLine.text = value;
                              }
                            },
                            fillColor: primaryColor.withOpacity(0.1),
                            borderRadius: 10.0,
                          )
                        : const SizedBox.shrink()),
                    const SizedBox(height: 16),
                    Obx(() => controller.listLine.isNotEmpty
                        ? DropdownFieldWidget(
                            label: 'Pilih approval GM',
                            icon: Icons.account_circle_outlined,
                            value: controller.userGm.text.isNotEmpty &&
                                    controller.listAdm.any((item) =>
                                        item.id.toString() ==
                                        controller.userGm.text)
                                ? controller.userGm.text
                                : null, // Ensure value is valid and exists in the list
                            items: controller.listGm.toSet().map((item) {
                              return DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: SizedBox(
                                  width: Get.width / 1.5,
                                  child: Text(
                                    item.name!,
                                    overflow: TextOverflow.visible,
                                    softWrap: true,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                controller.userGm.text = value;
                              }
                            },
                            fillColor: primaryColor.withOpacity(0.1),
                            borderRadius: 10.0,
                          )
                        : const SizedBox.shrink()),
                    const SizedBox(height: 16),
                    Obx(() => controller.listLine.isNotEmpty
                        ? DropdownFieldWidget(
                            label: 'Pilih approval HR',
                            icon: Icons.account_circle_outlined,
                            value: controller.userHr.text.isNotEmpty &&
                                    controller.listAdm.any((item) =>
                                        item.id.toString() ==
                                        controller.userHr.text)
                                ? controller.userHr.text
                                : null, // Ensure value is valid and exists in the list
                            items: controller.listHrd.toSet().map((item) {
                              return DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: SizedBox(
                                  width: Get.width / 1.5,
                                  child: Text(
                                    item.name!,
                                    overflow: TextOverflow.visible,
                                    softWrap: true,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                controller.userHr.text = value;
                              }
                            },
                            fillColor: primaryColor.withOpacity(0.1),
                            borderRadius: 10.0,
                          )
                        : const SizedBox.shrink()),
                    const SizedBox(height: 16),
                    Obx(() => controller.listLine.isNotEmpty
                        ? DropdownFieldWidget(
                            label: 'Pilih approval Director',
                            icon: Icons.account_circle_outlined,
                            value: controller.userDirector.text.isNotEmpty &&
                                    controller.listAdm.any((item) =>
                                        item.id.toString() ==
                                        controller.userDirector.text)
                                ? controller.userDirector.text
                                : null, // Ensure value is valid and exists in the list
                            items: controller.listDirektur.toSet().map((item) {
                              return DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: SizedBox(
                                  width: Get.width / 1.5,
                                  child: Text(
                                    item.name!,
                                    overflow: TextOverflow.visible,
                                    softWrap: true,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                controller.userDirector.text = value;
                              }
                            },
                            fillColor: primaryColor.withOpacity(0.1),
                            borderRadius: 10.0,
                          )
                        : const SizedBox.shrink()),
                    const SizedBox(height: 16),
                    Obx(() => controller.listLine.isNotEmpty
                        ? DropdownFieldWidget(
                            label: 'Pilih approval FAT',
                            icon: Icons.account_circle_outlined,
                            value: controller.userFat.text.isNotEmpty &&
                                    controller.listAdm.any((item) =>
                                        item.id.toString() ==
                                        controller.userFat.text)
                                ? controller.userFat.text
                                : null, // Ensure value is valid and exists in the list
                            items: controller.listFat.toSet().map((item) {
                              return DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: SizedBox(
                                  width: Get.width / 1.5,
                                  child: Text(
                                    item.name!,
                                    overflow: TextOverflow.visible,
                                    softWrap: true,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                controller.userFat.text = value;
                              }
                            },
                            fillColor: primaryColor.withOpacity(0.1),
                            borderRadius: 10.0,
                          )
                        : const SizedBox.shrink()),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        }),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: Obx(() => BtnAction(
                    act: () {
                      if (formKey.currentState?.validate() ?? false) {
                        controller.submitForm();
                      }
                    },
                    color: primaryColor,
                    icon: Icons.save,
                    isLoading: controller.isLoading,
                    title: controller.isLoading.isFalse
                        ? 'Ajukan permintaan'
                        : 'proses',
                  )),
            )),
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
    );
  }
}
