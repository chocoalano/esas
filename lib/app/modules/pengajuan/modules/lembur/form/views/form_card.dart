// ignore_for_file: prefer_const_constructors

import 'package:esas/components/forms/date_picker.dart';
import 'package:esas/components/forms/select_options.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/form_controller.dart';

class FormCard extends StatelessWidget {
  final int index;
  final VoidCallback onRemove;
  final ValueChanged<int?> onUserChange;

  const FormCard({
    super.key,
    required this.index,
    required this.onRemove,
    required this.onUserChange,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FormController>();
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 209, 209, 209)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Form lembur users ${index + 1}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              IconButton(
                  onPressed: onRemove,
                  icon: const Icon(
                    Icons.remove,
                    color: dangerColor,
                  ))
            ],
          ),
          const Divider(),
          const SizedBox(
            height: 16,
          ),
          Obx(() => _buildDropdown(
                label: 'Pilih User',
                items: controller.listUser.map(_buildDropdownItem).toList(),
                value: controller.formList[index]['userIdCreated'],
                onChanged: (value) {
                  controller.formList[index]['userIdCreated'] = value!;
                  onUserChange(value);
                },
                isLoading: controller.listUser.isEmpty,
              )),
          const SizedBox(height: 16),
          Obx(() => _buildDropdown(
                label: 'Pilih Departemen',
                items: controller.listOrg.map(_buildDropdownItem).toList(),
                value: controller.formList[index]['organizationId'],
                onChanged: (value) =>
                    controller.formList[index]['organizationId'] = value!,
                isLoading: controller.listOrg.isEmpty,
              )),
          const SizedBox(height: 16),
          Obx(() => _buildDropdown(
                label: 'Pilih Jabatan',
                items: controller.listPosition.map(_buildDropdownItem).toList(),
                value: controller.formList[index]['jobPositionId'],
                onChanged: (value) =>
                    controller.formList[index]['jobPositionId'] = value!,
                isLoading: controller.listPosition.isEmpty,
              )),
          const SizedBox(height: 16),
          DatePickerComponent(
            label: 'Pilih tanggal yang diajukan',
            name: 'dateOvertimeAt_$index',
            primaryColor: primaryColor,
            selectedDate: controller.selectedDate,
            onChanged: (value) {
              controller.formList[index]['dateOvertimeAt'] = formatDate(value);
            },
          ),
          const SizedBox(height: 16),
          Obx(
            () {
              if (controller.listAdm.isNotEmpty ||
                  controller.listLine.isNotEmpty ||
                  controller.listGm.isNotEmpty ||
                  controller.listHrd.isNotEmpty ||
                  controller.listDirektur.isNotEmpty ||
                  controller.listFat.isNotEmpty) {
                return Column(
                  children: [
                    Divider(),
                    const SizedBox(height: 16),
                    _buildDropdown(
                      label: 'Pilih User Admin',
                      items:
                          controller.listAdm.map(_buildDropdownItem).toList(),
                      value: controller.formList[index]['userAdm'],
                      onChanged: (value) =>
                          controller.formList[index]['userAdm'] = value!,
                      isLoading: controller.listAdm.isEmpty,
                    ),
                    const SizedBox(height: 16),
                    _buildDropdown(
                      label: 'Pilih User Line',
                      items:
                          controller.listLine.map(_buildDropdownItem).toList(),
                      value: controller.formList[index]['userLine'],
                      onChanged: (value) =>
                          controller.formList[index]['userLine'] = value!,
                      isLoading: controller.listLine.isEmpty,
                    ),
                    const SizedBox(height: 16),
                    _buildDropdown(
                      label: 'Pilih User GM',
                      items: controller.listGm.map(_buildDropdownItem).toList(),
                      value: controller.formList[index]['userGm'],
                      onChanged: (value) =>
                          controller.formList[index]['userGm'] = value!,
                      isLoading: controller.listGm.isEmpty,
                    ),
                    const SizedBox(height: 16),
                    _buildDropdown(
                      label: 'Pilih User HRD',
                      items:
                          controller.listHrd.map(_buildDropdownItem).toList(),
                      value: controller.formList[index]['userHr'],
                      onChanged: (value) =>
                          controller.formList[index]['userHr'] = value!,
                      isLoading: controller.listHrd.isEmpty,
                    ),
                    const SizedBox(height: 16),
                    _buildDropdown(
                      label: 'Pilih User Direktur',
                      items: controller.listDirektur
                          .map(_buildDropdownItem)
                          .toList(),
                      value: controller.formList[index]['userDirector'],
                      onChanged: (value) =>
                          controller.formList[index]['userDirector'] = value!,
                      isLoading: controller.listDirektur.isEmpty,
                    ),
                    const SizedBox(height: 16),
                    _buildDropdown(
                      label: 'Pilih User FAT',
                      items:
                          controller.listFat.map(_buildDropdownItem).toList(),
                      value: controller.formList[index]['userFat'],
                      onChanged: (value) =>
                          controller.formList[index]['userFat'] = value!,
                      isLoading: controller.listFat.isEmpty,
                    )
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required List<DropdownMenuItem<int>> items,
    required int value,
    required ValueChanged<int?> onChanged,
    required bool isLoading,
  }) {
    return isLoading && items.isEmpty
        ? const Center(child: CircularProgressIndicator(color: primaryColor))
        : DropdownFieldComponent(
            label: label,
            items: items,
            value: value == 0 ? items.first.value!.toInt() : value,
            onChanged: onChanged,
            primaryColor: primaryColor,
          );
  }

  DropdownMenuItem<int> _buildDropdownItem(dynamic item) {
    return DropdownMenuItem<int>(
      value: item.id,
      child: Text(item.name ?? ''),
    );
  }
}
