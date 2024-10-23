import 'package:esas/app/modules/pengajuan/widget/date_field_widget.dart';
import 'package:esas/app/modules/pengajuan/widget/dropdown_field_widget.dart';
import 'package:esas/components/btn_action.dart';
import 'package:esas/components/globat_appbar.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/form_controller.dart';

class FormView extends GetView<FormController> {
  const FormView({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await showBackDialog() ?? false;
        if (context.mounted && shouldPop) {
          Get.offAllNamed('/pengajuan/perubahan-shift/list');
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: GlobatAppbar(
          title: 'Perubahan Shift',
          act: () => Get.offAllNamed('/pengajuan/perubahan-shift/list'),
        ),
        body: Form(
            key: _formKey,
            child: Obx(() => Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(children: [
                    DateFieldWidget(
                      controller: controller.date,
                      hintText: 'Pilih tanggal',
                      icon: Icons.calendar_today,
                      context: context,
                      fillColor: primaryColor.withOpacity(0.1),
                      borderRadius: 10.0,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      onDateSelected: (date) {
                        controller.date.text = date;
                        controller.fetchCurrentShift(date);
                      },
                    ),
                    const SizedBox(height: 16),
                    Obx(() {
                      return controller.isLoading.isTrue
                          ? const Center(child: CircularProgressIndicator())
                          : Column(
                              children: [
                                Obx(
                                  () => controller.isLoading.isTrue
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: primaryColor,
                                          ),
                                        )
                                      : DropdownFieldWidget(
                                          label: 'Pilih group saat ini',
                                          icon: Icons.account_circle_outlined,
                                          value: controller.currentGroup.text
                                                      .isNotEmpty &&
                                                  controller.groupAbsen
                                                      .contains(controller
                                                          .currentGroup.text)
                                              ? controller.currentGroup.text
                                              : null, // Ensure value is valid and exists in the list
                                          items: controller.groupAbsen
                                              .toSet()
                                              .map((item) {
                                            return DropdownMenuItem<String>(
                                              value: item.id.toString(),
                                              child: SizedBox(
                                                width: Get.width / 1.5,
                                                child: Text(
                                                  item.name!,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  softWrap: true,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            if (value != null) {
                                              controller.currentGroup.text =
                                                  value;
                                            }
                                          },
                                          fillColor:
                                              primaryColor.withOpacity(0.1),
                                          borderRadius: 10.0,
                                        ),
                                ),
                                const SizedBox(height: 10),
                                Obx(
                                  () => controller.isLoading.isTrue
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: primaryColor,
                                          ),
                                        )
                                      : DropdownFieldWidget(
                                          label: 'Pilih shift saat ini',
                                          icon: Icons.account_circle_outlined,
                                          value: controller.currentShift.text
                                                      .isNotEmpty &&
                                                  controller.shiftModel
                                                      .contains(controller
                                                          .currentShift.text)
                                              ? controller.currentShift.text
                                              : null, // Ensure value is valid and exists in the list
                                          items: controller.shiftModel
                                              .toSet()
                                              .map((item) {
                                            return DropdownMenuItem<String>(
                                              value: item.id.toString(),
                                              child: SizedBox(
                                                width: Get.width / 1.5,
                                                child: Text(
                                                  item.type!,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  softWrap: true,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            if (value != null) {
                                              controller.currentShift.text =
                                                  value;
                                            }
                                          },
                                          fillColor:
                                              primaryColor.withOpacity(0.1),
                                          borderRadius: 10.0,
                                        ),
                                ),
                                const SizedBox(height: 10),
                                Obx(
                                  () => controller.isLoading.isTrue
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: primaryColor,
                                          ),
                                        )
                                      : DropdownFieldWidget(
                                          label: 'Pilih shift diajukan',
                                          icon: Icons.account_circle_outlined,
                                          value: controller.adjustShift.text
                                                      .isNotEmpty &&
                                                  controller.shiftModel
                                                      .contains(controller
                                                          .adjustShift.text)
                                              ? controller.adjustShift.text
                                              : null, // Ensure value is valid and exists in the list
                                          items: controller.shiftModel
                                              .toSet()
                                              .map((item) {
                                            return DropdownMenuItem<String>(
                                              value: item.id.toString(),
                                              child: SizedBox(
                                                width: Get.width / 1.5,
                                                child: Text(
                                                  item.type!,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  softWrap: true,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            if (value != null) {
                                              controller.adjustShift.text =
                                                  value;
                                            }
                                          },
                                          fillColor:
                                              primaryColor.withOpacity(0.1),
                                          borderRadius: 10.0,
                                        ),
                                ),
                                const SizedBox(height: 10),
                                Obx(
                                  () => controller.isLoading.isTrue
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: primaryColor,
                                          ),
                                        )
                                      : DropdownFieldWidget(
                                          label: 'Pilih approval line',
                                          icon: Icons.account_circle_outlined,
                                          value: controller
                                                      .lineId.text.isNotEmpty &&
                                                  controller.lineOptions
                                                      .contains(controller
                                                          .lineId.text)
                                              ? controller.lineId.text
                                              : null, // Ensure value is valid and exists in the list
                                          items: controller.lineOptions
                                              .toSet()
                                              .map((item) {
                                            return DropdownMenuItem<String>(
                                              value: item.id.toString(),
                                              child: SizedBox(
                                                width: Get.width / 1.5,
                                                child: Text(
                                                  item.name!,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  softWrap: true,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            if (value != null) {
                                              controller.lineId.text = value;
                                            }
                                          },
                                          fillColor:
                                              primaryColor.withOpacity(0.1),
                                          borderRadius: 10.0,
                                        ),
                                ),
                                const SizedBox(height: 10),
                                Obx(
                                  () => controller.isLoading.isTrue
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: primaryColor,
                                          ),
                                        )
                                      : DropdownFieldWidget(
                                          label: 'Pilih approval HR',
                                          icon: Icons.account_circle_outlined,
                                          value: controller
                                                      .hrId.text.isNotEmpty &&
                                                  controller.hrdOptions
                                                      .contains(
                                                          controller.hrId.text)
                                              ? controller.hrId.text
                                              : null, // Ensure value is valid and exists in the list
                                          items: controller.hrdOptions
                                              .toSet()
                                              .map((item) {
                                            return DropdownMenuItem<String>(
                                              value: item.id.toString(),
                                              child: SizedBox(
                                                width: Get.width / 1.5,
                                                child: Text(
                                                  item.name!,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  softWrap: true,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            if (value != null) {
                                              controller.hrId.text = value;
                                            }
                                          },
                                          fillColor:
                                              primaryColor.withOpacity(0.1),
                                          borderRadius: 10.0,
                                        ),
                                ),
                              ],
                            );
                    }),
                  ]),
                ))),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: Obx(() => BtnAction(
                    act: () {
                      if (_formKey.currentState?.validate() ?? false) {
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
}
