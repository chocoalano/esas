import 'package:esas/app/modules/pengajuan/widget/date_field_widget.dart';
import 'package:esas/app/modules/pengajuan/widget/dropdown_field_widget.dart';
import 'package:esas/app/modules/pengajuan/widget/text_field_widget.dart';
import 'package:esas/app/modules/pengajuan/widget/time_field_widget.dart';
import 'package:esas/components/btn_action.dart';
import 'package:esas/components/globat_appbar.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/form_controller.dart';

class FormCutiView extends GetView<FormController> {
  const FormCutiView({super.key});
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
          Get.offAllNamed('/pengajuan/cuti/list');
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: GlobatAppbar(
          title: 'Form Cuti',
          act: () => Get.offAllNamed('/pengajuan/cuti/list'),
        ),
        body: Form(
          key: _formKey,
          child: Obx(() {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  DateFieldWidget(
                    controller: controller.startDate,
                    hintText: 'Pilih tanggal mulai',
                    icon: Icons.calendar_today,
                    context: context,
                    fillColor: primaryColor.withOpacity(0.1),
                    borderRadius: 15.0,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    onDateSelected: (date) => controller.startDate.text = date,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DateFieldWidget(
                    controller: controller.endDate,
                    hintText: 'Pilih tanggal selesai',
                    icon: Icons.calendar_today,
                    context: context,
                    fillColor: primaryColor.withOpacity(0.1),
                    borderRadius: 15.0,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    onDateSelected: (date) => controller.endDate.text = date,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TimeFieldWidget(
                    controller: controller.startTime,
                    hintText: 'Pilih waktu mulai',
                    icon: Icons.access_alarm,
                    context: context,
                    fillColor: primaryColor.withOpacity(0.1),
                    borderRadius: 15.0,
                    initialTime: TimeOfDay.now(),
                    onTimeSelected: (value) =>
                        controller.startTime.text = value,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TimeFieldWidget(
                    controller: controller.endTime,
                    hintText: 'Pilih waktu selesai',
                    icon: Icons.access_alarm,
                    context: context,
                    fillColor: primaryColor.withOpacity(0.1),
                    borderRadius: 15.0,
                    initialTime: TimeOfDay.now(),
                    onTimeSelected: (value) => controller.endTime.text = value,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DropdownFieldWidget(
                    value: controller.type.text,
                    items: controller.cutiTypes.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: SizedBox(
                          width: Get.width / 1.5,
                          child: Text(
                            item,
                            overflow: TextOverflow.visible,
                            softWrap: true,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.type.text = value;
                      }
                    },
                    fillColor: primaryColor.withOpacity(0.1),
                    borderRadius: 10.0,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DropdownFieldWidget(
                    value: controller.category.text,
                    items: controller.cutiCategories.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: SizedBox(
                          width: Get.width / 1.5,
                          child: Text(
                            item,
                            overflow: TextOverflow.visible,
                            softWrap: true,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.category.text = value;
                      }
                    },
                    fillColor: primaryColor.withOpacity(0.1),
                    borderRadius: 10.0,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
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
                            value: controller.userLine.text.isNotEmpty &&
                                    controller.listLineApproval
                                        .contains(controller.userLine.text)
                                ? controller.userLine.text
                                : null, // Ensure value is valid and exists in the list
                            items:
                                controller.listLineApproval.toSet().map((item) {
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
                          ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(
                    () => controller.isLoading.isTrue
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : DropdownFieldWidget(
                            label: 'Pilih approval hr',
                            icon: Icons.account_circle_outlined,
                            value: controller.userHr.text.isNotEmpty &&
                                    controller.listHrApproval
                                        .contains(controller.userHr.text)
                                ? controller.userHr.text
                                : null, // Ensure value is valid and exists in the list
                            items:
                                controller.listHrApproval.toSet().map((item) {
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
                          ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFieldWidget(
                    controller: controller.notes,
                    label: "Keterangan",
                    icon: Icons.description,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Keterangan tidak boleh kosong';
                      }
                      return null;
                    },
                    fillColor:
                        primaryColor.withOpacity(0.1), // Optional customization
                    borderRadius: 10.0, // Optional customization
                  )
                ],
              ),
            );
          }),
        ),
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

  Widget _buildDropdown(
      String label, Rx<String> controllerValue, List<String> items) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        fillColor: primaryColor.withOpacity(0.1),
        filled: true,
      ),
      value: controllerValue.value.isNotEmpty
          ? controllerValue.value
          : null, // Gunakan null jika belum ada nilai awal
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: SizedBox(
            width: Get.width / 1.5,
            child: Text(
              item,
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        controllerValue.value = value!;
      },
    );
  }
}
