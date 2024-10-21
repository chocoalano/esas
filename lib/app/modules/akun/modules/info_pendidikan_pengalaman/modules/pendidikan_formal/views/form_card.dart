// ignore_for_file: library_private_types_in_public_api

import 'package:esas/app/modules/akun/modules/info_pendidikan_pengalaman/modules/pendidikan_formal/controllers/pendidikan_formal_controller.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormCard extends StatefulWidget {
  final int index;
  final VoidCallback onRemove;

  const FormCard({super.key, required this.index, required this.onRemove});

  @override
  _FormCardState createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  late final TextEditingController _institutionController;
  late final TextEditingController _scoreController;
  late final TextEditingController _startController;
  late final TextEditingController _finishController;
  late final TextEditingController _descriptionController;

  final AkunPendidikanFormalController _controller = Get.find();

  @override
  void initState() {
    super.initState();

    // Initialize controllers with values from formData
    _institutionController = TextEditingController(
      text: _controller.formData[widget.index]['institution'] ?? '',
    );
    _scoreController = TextEditingController(
      text: _controller.formData[widget.index]['score'] ?? '',
    );
    _startController = TextEditingController(
      text: _controller.formData[widget.index]['start'] ?? '',
    );
    _finishController = TextEditingController(
      text: _controller.formData[widget.index]['finish'] ?? '',
    );
    _descriptionController = TextEditingController(
      text: _controller.formData[widget.index]['description'] ?? '',
    );

    // Attach listeners to controllers for automatic form updates
    _institutionController.addListener(
        () => _updateForm('institution', _institutionController.text));
    _scoreController
        .addListener(() => _updateForm('score', _scoreController.text));
    _startController
        .addListener(() => _updateForm('start', _startController.text));
    _finishController
        .addListener(() => _updateForm('finish', _finishController.text));
    _descriptionController.addListener(
        () => _updateForm('description', _descriptionController.text));
  }

  void _updateForm(String key, String value) {
    _controller.updateForm(widget.index, key, value);
  }

  @override
  void dispose() {
    _institutionController.dispose();
    _scoreController.dispose();
    _startController.dispose();
    _finishController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current majors value
    final majorsValue =
        _getValidMajorsValue(_controller.formData[widget.index]['majors']);

    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            _buildRemoveButton(),
            const SizedBox(height: 10),
            _buildTextField(_institutionController, 'Nama', Icons.account_box),
            const SizedBox(height: 10),
            _buildDropdownField(
              value: majorsValue,
              items: const [
                DropdownMenuItem(value: 'SD', child: Text('SD')),
                DropdownMenuItem(value: 'SMP', child: Text('SMP')),
                DropdownMenuItem(value: 'SMA/SLTA', child: Text('SMA/SLTA')),
                DropdownMenuItem(value: 'D1', child: Text('D1')),
                DropdownMenuItem(value: 'D2', child: Text('D2')),
                DropdownMenuItem(value: 'D3', child: Text('D3')),
                DropdownMenuItem(value: 'D4', child: Text('D4')),
                DropdownMenuItem(value: 'S1', child: Text('S1')),
                DropdownMenuItem(value: 'S2', child: Text('S2')),
                DropdownMenuItem(value: 'S3', child: Text('S3')),
              ],
              onChanged: (value) {
                if (value != null) {
                  _updateForm('majors', value);
                }
              },
            ),
            const SizedBox(height: 10),
            _buildTextField(
                _scoreController, 'Skor/IPK', Icons.phone_android_outlined),
            const SizedBox(height: 10),
            _buildDatePicker(
                _startController, 'Pilih tanggal mulai', Icons.calendar_today),
            const SizedBox(height: 10),
            _buildDatePicker(_finishController, 'Pilih tanggal selesai',
                Icons.calendar_today),
            const SizedBox(height: 10),
            _buildTextField(_descriptionController, 'Deskripsi',
                Icons.description_outlined),
            const SizedBox(height: 10),
            _buildCheckedField(
              isChecked:
                  _controller.formData[widget.index]['certification'] ?? false,
              label: 'Apakah pendidikan ini tersertifikasi?',
              icon: Icons.check_box,
              onChanged: (value) {
                _updateForm('certification', value.toString());
              },
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Widget for Remove Button
  Widget _buildRemoveButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: widget.onRemove,
          icon: const Icon(Icons.remove_circle_outline, color: dangerColor),
        ),
      ],
    );
  }

  // Reusable Widget for TextField
  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      decoration: _inputDecoration(label, icon),
    );
  }

  // Reusable Widget for DropdownField
  Widget _buildDropdownField({
    required String? value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: _inputDecoration('Pilih jurusan', Icons.school),
    );
  }

  // Reusable Widget for DatePickerInput
  Widget _buildDatePicker(
      TextEditingController controller, String hintText, IconData icon) {
    return TextField(
      controller: controller,
      decoration: _inputDecoration(hintText, icon),
      readOnly: true,
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          controller.text = picked.toIso8601String().substring(0, 10);
        }
      },
    );
  }

  // Reusable Widget for CheckedField
  Widget _buildCheckedField({
    required bool isChecked,
    required String label,
    required IconData icon,
    required ValueChanged<bool?> onChanged,
  }) {
    return CheckboxListTile(
      value: isChecked,
      title: Text(label),
      secondary: Icon(icon),
      onChanged: onChanged,
    );
  }

  // Reusable InputDecoration
  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      fillColor: primaryColor.withOpacity(0.1),
      filled: true,
      prefixIcon: Icon(icon),
    );
  }

  // Ensure value exists in the dropdown options
  String? _getValidMajorsValue(String? value) {
    const validValues = [
      'SD',
      'SMP',
      'SMA/SLTA',
      'D1',
      'D2',
      'D3',
      'D4',
      'S1',
      'S2',
      'S3',
    ];
    return (value != null && validValues.contains(value)) ? value : null;
  }
}
