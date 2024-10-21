import 'package:esas/components/btn_action.dart';
import 'package:esas/components/globat_appbar.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/form_controller.dart';

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
          Get.offAllNamed('/pengajuan/perubahan-shift/list');
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: GlobatAppbar(
          title: 'Perubahan Shift',
          act: () => Get.offAllNamed('/pengajuan/perubahan-shift/list'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormBuilder(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDateField(),
                const SizedBox(height: 16),
                Obx(() {
                  return controller.isLoading.isTrue
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            Obx(() => _buildDropdown(
                                  name: 'currentGroup',
                                  label: 'Grup Saat Ini',
                                  items: controller.groupAbsen.map((group) {
                                    return DropdownMenuItem<int>(
                                      value: group.id,
                                      child: Text(group.name ?? ''),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.currentGroup.value = value;
                                    }
                                  },
                                  value: controller
                                      .currentGroup, // Observe changes
                                )),
                            const SizedBox(height: 10),
                            Obx(() => _buildDropdown(
                                  name: 'currentShift',
                                  label: 'Shift Saat Ini',
                                  items: controller.shiftModel.map((shift) {
                                    return DropdownMenuItem<int>(
                                      value: shift.id,
                                      child: Text(shift.type ?? ''),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.currentShift.value = value;
                                    }
                                  },
                                  value: controller
                                      .currentShift, // Observe changes
                                )),
                            const SizedBox(height: 10),
                            Obx(() => _buildDropdown(
                                  name: 'adjustShift',
                                  label: 'Shift Diajukan',
                                  items: controller.shiftModel.map((shift) {
                                    return DropdownMenuItem<int>(
                                      value: shift.id,
                                      child: Text(shift.type ?? ''),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.adjustShift.value = value;
                                    }
                                  },
                                  value:
                                      controller.adjustShift, // Observe changes
                                )),
                            const SizedBox(height: 10),
                            Obx(() => _buildDropdown(
                                  name: 'lineId',
                                  label: 'Approval line',
                                  items: controller.lineOptions.map((line) {
                                    return DropdownMenuItem<int>(
                                      value: line.id,
                                      child: Text(line.name ?? ''),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.lineId.value = value;
                                    }
                                  },
                                  value: controller.lineId, // Observe changes
                                )),
                            const SizedBox(height: 10),
                            Obx(() => _buildDropdown(
                                  name: 'hrId',
                                  label: 'Approval HRD',
                                  items: controller.hrdOptions.map((hr) {
                                    return DropdownMenuItem<int>(
                                      value: hr.id,
                                      child: Text(hr.name ?? ''),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.hrId.value = value;
                                    }
                                  },
                                  value: controller.hrId, // Observe changes
                                )),
                          ],
                        );
                }),
                const SizedBox(height: 20),
                BtnAction(
                  act: () => controller.submitForm(),
                  color: primaryColor,
                  icon: Icons.save_alt_outlined,
                  isLoading: controller.isLoading,
                  title: 'Ajukan sekarang',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return FormBuilderDateTimePicker(
      name: 'date',
      inputType: InputType.date,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        fillColor: primaryColor.withOpacity(0.1),
        filled: true,
        labelText: 'Pilih tanggal diajukan',
        prefixIcon: const Icon(Icons.calendar_month),
      ),
      format: DateFormat('yyyy-MM-dd'),
      onChanged: (value) {
        if (value != null) {
          controller.date.value = DateFormat('yyyy-MM-dd').format(value);
          controller.fetchCurrentShift();
        }
      },
    );
  }

  Widget _buildDropdown({
    required String name,
    required String label,
    required List<DropdownMenuItem<int>> items,
    required Function(int?) onChanged,
    required Rx<int> value, // Bind the value directly to the observable
  }) {
    // Filter items to ensure there's a match with the current value
    final filteredItems =
        items.where((item) => item.value == value.value).isNotEmpty
            ? items
            : [
                DropdownMenuItem<int>(
                  value: null,
                  child: Text('Pilih $label'),
                ),
                ...items
              ];

    return Obx(() {
      return DropdownButtonFormField<int>(
        value: filteredItems
            .firstWhere((item) => item.value == value.value,
                orElse: () => filteredItems[0])
            .value,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          fillColor: primaryColor.withOpacity(0.1),
          filled: true,
          labelText: label,
        ),
        items: filteredItems,
        onChanged: onChanged,
      );
    });
  }
}
