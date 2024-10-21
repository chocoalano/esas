import 'package:esas/app/modules/akun/modules/info_pendidikan_pengalaman/modules/pendidikan_informal/controllers/pendidikan_informal_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../display/widget/btn_remove.dart';
import '../../../display/widget/checked_field.dart';
import '../../../display/widget/datepicker_field.dart';
import '../../../display/widget/dropdown_field.dart';
import '../../../display/widget/text_field.dart';

class FormCard extends StatelessWidget {
  final int index;
  final VoidCallback onRemove;
  final PendidikanInformalController controller = Get.find();

  // Constructor
  FormCard({super.key, required this.index, required this.onRemove});

  @override
  Widget build(BuildContext context) {
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
              controller: TextEditingController(
                  text: controller.formData[index]['name']),
              label: 'Nama',
              icon: Icons.account_box,
              onChanged: (value) => controller.updateForm(index, 'name', value),
            ),
            const SizedBox(height: 10),
            DropdownField(
              value: controller.formData[index]['type'] ?? 'day',
              items: const [
                DropdownMenuItem(value: 'day', child: Text('Harian')),
                DropdownMenuItem(value: 'month', child: Text('Bulanan')),
                DropdownMenuItem(value: 'year', child: Text('Tahunan')),
              ],
              onChanged: (value) {
                if (value != null) {
                  controller.updateForm(index, 'type', value);
                }
              },
            ),
            const SizedBox(height: 10),
            DatePickerInput(
              controller: TextEditingController(
                  text: controller.formData[index]['start']),
              hintText: 'Pilih tanggal mulai',
              icon: Icons.calendar_today,
              onChanged: (date) => controller.updateForm(index, 'start', date),
            ),
            const SizedBox(height: 10),
            DatePickerInput(
              controller: TextEditingController(
                  text: controller.formData[index]['finish']),
              hintText: 'Pilih tanggal selesai',
              icon: Icons.calendar_today,
              onChanged: (date) => controller.updateForm(index, 'finish', date),
            ),
            const SizedBox(height: 10),
            DatePickerInput(
              controller: TextEditingController(
                  text: controller.formData[index]['expired']),
              hintText: 'Berlaku sampai dengan tanggal?',
              icon: Icons.calendar_today,
              onChanged: (date) =>
                  controller.updateForm(index, 'expired', date),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: TextEditingController(
                  text: controller.formData[index]['description']),
              label: 'Deskripsi',
              icon: Icons.description_outlined,
              onChanged: (value) =>
                  controller.updateForm(index, 'description', value),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: TextEditingController(
                  text: controller.formData[index]['duration']),
              label: 'Durasi',
              icon: Icons.access_time,
              onChanged: (value) =>
                  controller.updateForm(index, 'duration', value),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: TextEditingController(
                  text: controller.formData[index]['fee']),
              label: 'Biaya',
              icon: Icons.attach_money,
              onChanged: (value) => controller.updateForm(index, 'fee', value),
            ),
            const SizedBox(height: 10),
            CheckedField(
              isChecked: controller.formData[index]['certification'] ?? false,
              label: 'Apakah pendidikan ini tersertifikasi?',
              icon: Icons.check_box,
              onChanged: (value) {
                controller.updateForm(index, 'certification', value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
