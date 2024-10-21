import 'package:esas/components/btn_action.dart';
import 'package:esas/components/forms/date_picker.dart';
import 'package:esas/components/forms/select_options.dart';
import 'package:esas/components/forms/text_area.dart';
import 'package:esas/components/forms/time_picker.dart';
import 'package:esas/components/globat_appbar.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';

import '../controllers/form_controller.dart';
import 'components/photo_box.dart';

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
          Get.offAllNamed('/pengajuan/koreksi-absen/list');
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: GlobatAppbar(
          title: 'Form Koreksi Absen',
          act: () => Get.offAllNamed('/pengajuan/koreksi-absen/list'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FormBuilder(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DatePickerComponent(
                      name: 'date',
                      selectedDate: controller.selectedDate,
                      primaryColor: primaryColor,
                      label: 'Pilih tanggal diajukan',
                      onChanged: (value) {
                        controller.selectDate(value);
                      }),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  _buildAttendanceInfo(),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  _buildPhotoSection(),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  TimePickerComponent(
                    name: 'time_in',
                    labelText: 'Pilih Waktu Masuk',
                    selectedTime: controller.selectedTimeIn,
                    controller: controller.timeInController,
                    primaryColor: primaryColor,
                    isTimeIn: true,
                  ),
                  const SizedBox(height: 16),
                  TimePickerComponent(
                    name: 'time_out',
                    labelText: 'Pilih Waktu Keluar',
                    selectedTime: controller.selectedTimeOut,
                    controller: controller.timeOutController,
                    primaryColor: primaryColor,
                    isTimeIn: false,
                  ),
                  const SizedBox(height: 16),
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
                            value: controller.selectedLine.value,
                            onChanged: (value) {
                              controller.selectedLine.value = value!;
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
                            value: controller.selectedHrd.value,
                            onChanged: (value) {
                              controller.selectedHrd.value = value!;
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
                    name: 'notes',
                    notes: controller.notes,
                  ),
                  const SizedBox(height: 20),
                  BtnAction(
                    act: () {
                      if (controller.formKey.currentState?.saveAndValidate() ??
                          false) {
                        controller.submitRequest();
                      } else {
                        showErrorSnackbar('Tolong lengkapi form anda!');
                      }
                    },
                    color: primaryColor,
                    icon: Icons.save,
                    isLoading: controller.isLoading,
                    title: 'Ajukan koreksi absen',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceInfo() {
    return Obx(() {
      final attendance = controller.attendance.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('NIK', attendance.nik ?? ''),
          _buildInfoRow('Tanggal', formatDate(attendance.date)),
          _buildInfoRow('Jam Masuk', attendance.timeIn ?? ''),
          _buildInfoRow('Status Masuk', attendance.statusIn ?? ''),
          _buildInfoRow('Jam Pulang', attendance.timeOut ?? ''),
          _buildInfoRow('Status Pulang', attendance.statusOut ?? ''),
        ],
      );
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
    return const TextStyle(
      fontWeight: FontWeight.bold,
    );
  }

  // Build Photo Section for In and Out photos
  Widget _buildPhotoSection() {
    return Obx(() {
      final attendance = controller.attendance.value;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PhotoBox(
            photoUrl: attendance.photoIn ?? '',
          ),
          PhotoBox(
            photoUrl: attendance.photoOut ?? '',
          ),
        ],
      );
    });
  }
}
