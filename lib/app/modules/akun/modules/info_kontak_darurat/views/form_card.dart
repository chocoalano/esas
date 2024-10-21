// ignore_for_file: library_private_types_in_public_api

import 'package:esas/app/modules/akun/modules/info_kontak_darurat/controllers/info_kontak_darurat_controller.dart';
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
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _professionController;

  final InfoKontakDaruratController _controller = Get.find();

  @override
  void initState() {
    super.initState();

    // Initialize controllers with values from formData
    _nameController = TextEditingController(
      text: _controller.formData[widget.index]['name'] ?? '',
    );
    _phoneController = TextEditingController(
      text: _controller.formData[widget.index]['phone'] ?? '',
    );
    _professionController = TextEditingController(
      text: _controller.formData[widget.index]['profession'] ?? '',
    );

    // Attach listeners to controllers for automatic form updates
    _nameController
        .addListener(() => _updateForm('name', _nameController.text));
    _phoneController
        .addListener(() => _updateForm('phone', _phoneController.text));
    _professionController.addListener(
        () => _updateForm('profession', _professionController.text));
  }

  void _updateForm(String key, String value) {
    _controller.updateForm(widget.index, key, value);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _professionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current relationship value
    final relationshipValue = _getValidRelationshipValue(
      _controller.formData[widget.index]['relationship'],
    );

    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            _buildRemoveButton(),
            const SizedBox(height: 10),
            _buildTextField(_nameController, 'Nama', Icons.account_box),
            const SizedBox(height: 10),
            _buildDropdownField(
              value: relationshipValue,
              items: const [
                DropdownMenuItem(value: 'wife', child: Text('Istri')),
                DropdownMenuItem(value: 'husband', child: Text('Suami')),
                DropdownMenuItem(value: 'mother', child: Text('Ibu')),
                DropdownMenuItem(value: 'father', child: Text('Ayah')),
                DropdownMenuItem(
                    value: 'brother', child: Text('Saudara Laki-laki')),
                DropdownMenuItem(
                    value: 'sister', child: Text('Saudara Perempuan')),
                DropdownMenuItem(value: 'child', child: Text('Anak')),
              ],
              onChanged: (value) {
                if (value != null) {
                  _updateForm('relationship', value);
                }
              },
            ),
            const SizedBox(height: 10),
            _buildTextField(
                _phoneController, 'Telpon/HP', Icons.phone_android_outlined),
            const SizedBox(height: 10),
            _buildTextField(
                _professionController, 'Profesi', Icons.work_history_outlined),
            const SizedBox(height: 10),
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
      decoration:
          _inputDecoration('Pilih hubungan', Icons.account_box_outlined),
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
  String? _getValidRelationshipValue(String? value) {
    const validValues = [
      'wife',
      'husband',
      'mother',
      'father',
      'brother',
      'sister',
      'child',
    ];
    return (value != null && validValues.contains(value)) ? value : null;
  }
}
