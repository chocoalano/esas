import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../display/widget/btn_remove.dart';
import '../../../display/widget/datepicker_field.dart';
import '../../../display/widget/text_field.dart';
import '../controllers/pengalaman_kerja_controller.dart';

class FormCard extends StatelessWidget {
  final int index;
  final VoidCallback onRemove;
  final PengalamanKerjaController controller = Get.find();

  // Constructor
  FormCard({super.key, required this.index, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    // Retrieve current form data
    final formData = controller.formData[index];

    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            RemoveButton(onRemove: onRemove),
            const SizedBox(height: 10),
            CustomTextField(
              controller: TextEditingController(text: formData['company']),
              label: 'Nama perusahaan',
              icon: Icons.account_box,
              onChanged: (value) =>
                  controller.updateForm(index, 'company', value),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: TextEditingController(text: formData['position']),
              label: 'Posisi',
              icon: Icons.account_box,
              onChanged: (value) =>
                  controller.updateForm(index, 'position', value),
            ),
            const SizedBox(height: 10),
            DatePickerInput(
              controller: TextEditingController(text: formData['from']),
              hintText: 'Pilih tanggal mulai',
              icon: Icons.calendar_today,
              onChanged: (date) => controller.updateForm(index, 'from', date),
            ),
            const SizedBox(height: 10),
            DatePickerInput(
              controller: TextEditingController(text: formData['to']),
              hintText: 'Pilih tanggal selesai',
              icon: Icons.calendar_today,
              onChanged: (date) => controller.updateForm(index, 'to', date),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller:
                  TextEditingController(text: formData['length_of_service']),
              label: 'Berapa lama ?',
              icon: Icons.access_time,
              onChanged: (value) =>
                  controller.updateForm(index, 'length_of_service', value),
            ),
          ],
        ),
      ),
    );
  }
}
