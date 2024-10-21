import 'package:esas/components/btn_action.dart';
import 'package:esas/components/forms/date_picker.dart';
import 'package:esas/components/forms/select_options.dart';
import 'package:esas/components/forms/text_area.dart';
import 'package:esas/components/forms/time_picker.dart';
import 'package:esas/components/globat_appbar.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/form_controller.dart';

class FormCutiView extends GetView<FormController> {
  const FormCutiView({super.key});
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
          Get.offAllNamed('/pengajuan/cuti/list');
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: GlobatAppbar(
          title: 'Form Cuti',
          act: () => Get.offAllNamed('/pengajuan/cuti/list'),
        ),
        body: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                DatePickerComponent(
                  label: 'Tgl. Mulai',
                  name: 'startDate',
                  primaryColor: primaryColor,
                  selectedDate: controller.startDate,
                ),
                const SizedBox(
                  height: 16,
                ),
                DatePickerComponent(
                  label: 'Tgl. Selesai',
                  name: 'endDate',
                  primaryColor: primaryColor,
                  selectedDate: controller.endDate,
                ),
                const SizedBox(
                  height: 16,
                ),
                TimePickerComponent(
                  name: 'time_in',
                  labelText: 'Waktu Mulai',
                  selectedTime: controller.startTime,
                  controller: controller.timeInController,
                  primaryColor: primaryColor,
                  isTimeIn: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                TimePickerComponent(
                  name: 'time_out',
                  labelText: 'Waktu Selesai',
                  selectedTime: controller.endTime,
                  controller: controller.timeOutController,
                  primaryColor: primaryColor,
                  isTimeIn: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(() => _buildDropdown(
                    'Jenis Cuti', controller.type, controller.cutiTypes)),
                const SizedBox(
                  height: 16,
                ),
                Obx(() => _buildDropdown('Kategori Cuti', controller.category,
                    ['half', 'full', 'suddenly'])),
                const SizedBox(
                  height: 16,
                ),
                Obx(
                  () => controller.lineApproval.isNotEmpty
                      ? DropdownFieldComponent(
                          label: 'Pilih Line Approval',
                          items: controller.lineApproval.map((line) {
                            return DropdownMenuItem<int>(
                              value: line.id,
                              child: Text(line.name ?? ''),
                            );
                          }).toList(),
                          value: controller.userLine.value,
                          onChanged: (value) {
                            controller.userLine.value = value!;
                          },
                          primaryColor: primaryColor,
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => controller.hrApproval.isNotEmpty
                      ? DropdownFieldComponent(
                          label: 'Pilih HRD Approval',
                          items: controller.hrApproval.map((hr) {
                            return DropdownMenuItem<int>(
                              value: hr.id,
                              child: Text(hr.name ?? ''),
                            );
                          }).toList(),
                          value: controller.userHr.value,
                          onChanged: (value) {
                            controller.userHr.value = value!;
                          },
                          primaryColor: primaryColor,
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                ),
                const SizedBox(height: 16),
                TextAreaComponent(
                  controller: controller.notesController,
                  labelText: 'Keterangan',
                  name: 'description',
                  notes: controller.description,
                ),
                const SizedBox(height: 20),
                BtnAction(
                  act: controller.submitForm,
                  color: primaryColor,
                  icon: Icons.save,
                  isLoading: controller.isLoading,
                  title: controller.isLoading.isFalse
                      ? 'Ajukan koreksi absen'
                      : 'proses',
                )
              ],
            ),
          );
        }),
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
