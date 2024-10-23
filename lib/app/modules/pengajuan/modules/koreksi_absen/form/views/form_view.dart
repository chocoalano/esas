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
import 'components/photo_box.dart';

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
          Get.offAllNamed('/pengajuan/koreksi-absen/list');
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: GlobatAppbar(
          title: 'Form Koreksi Absen',
          act: () => Get.offAllNamed('/pengajuan/koreksi-absen/list'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() => ListView(children: [
                  DateFieldWidget(
                      controller: controller.dateAdjustment,
                      hintText: 'Pilih tanggal mulai',
                      icon: Icons.calendar_today,
                      context: context,
                      fillColor: primaryColor.withOpacity(0.1),
                      borderRadius: 15.0,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      onDateSelected: (date) {
                        controller.dateAdjustment.text = date;
                        controller.fetchAttendanceForDate(
                            controller.dateAdjustment.text);
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
                  TimeFieldWidget(
                    controller: controller.timeinAdjustment,
                    hintText: 'Pilih waktu masuk diajukan',
                    icon: Icons.access_alarm,
                    context: context,
                    fillColor: primaryColor.withOpacity(0.1),
                    borderRadius: 15.0,
                    initialTime: TimeOfDay.now(),
                    onTimeSelected: (value) =>
                        controller.timeinAdjustment.text = value,
                  ),
                  const SizedBox(height: 16),
                  TimeFieldWidget(
                    controller: controller.timeoutAdjustment,
                    hintText: 'Pilih waktu pulang diajukan',
                    icon: Icons.access_alarm,
                    context: context,
                    fillColor: primaryColor.withOpacity(0.1),
                    borderRadius: 15.0,
                    initialTime: TimeOfDay.now(),
                    onTimeSelected: (value) =>
                        controller.timeoutAdjustment.text = value,
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => controller.isLoading.isTrue
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : DropdownFieldWidget(
                            label: 'Pilih approval LIne',
                            icon: Icons.account_circle_outlined,
                            value: controller.lineId.text.isNotEmpty &&
                                    controller.lineApproval
                                        .contains(controller.lineId.text)
                                ? controller.lineId.text
                                : null, // Ensure value is valid and exists in the list
                            items: controller.lineApproval.toSet().map((item) {
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
                                controller.lineId.text = value;
                              }
                            },
                            fillColor: primaryColor.withOpacity(0.1),
                            borderRadius: 10.0,
                          ),
                  ),
                  const SizedBox(height: 16),
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
                            value: controller.hrId.text.isNotEmpty &&
                                    controller.hrApproval
                                        .contains(controller.hrId.text)
                                ? controller.hrId.text
                                : null, // Ensure value is valid and exists in the list
                            items: controller.hrApproval.toSet().map((item) {
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
                                controller.hrId.text = value;
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
                ])),
          ),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: Obx(() => BtnAction(
                    act: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        controller.submitRequest();
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
