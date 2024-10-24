// ignore_for_file: non_constant_identifier_names

import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/action_button_widget.dart';
import '../../widget/date_field_widget.dart';
import '../../widget/text_field_widget.dart';
import '../controllers/pengalaman_kerja_controller.dart';

class FormCard extends StatefulWidget {
  final int index;
  final VoidCallback onRemove;
  final VoidCallback onSave;

  const FormCard(
      {super.key,
      required this.index,
      required this.onRemove,
      required this.onSave});

  @override
  State<FormCard> createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  late final TextEditingController _company;
  late final TextEditingController _position;
  late final TextEditingController _from;
  late final TextEditingController _to;
  late final TextEditingController _length_of_service;

  final _formKey = GlobalKey<FormState>();
  final PengalamanKerjaController controller = Get.find();

  @override
  void initState() {
    super.initState();
    _company = TextEditingController(
        text: controller.formData[widget.index]['company'] ?? '');
    _position = TextEditingController(
        text: controller.formData[widget.index]['position'] ?? '');
    _from = TextEditingController(
        text: controller.formData[widget.index]['from'] ?? '');
    _to = TextEditingController(
        text: controller.formData[widget.index]['to'] ?? '');
    _length_of_service = TextEditingController(
        text: controller.formData[widget.index]['length_of_service'] ?? '');
    // Attach listeners to controllers for automatic form updates
    _company.addListener(() => _updateForm('company', _company.text));
    _position.addListener(() => _updateForm('position', _position.text));
    _from.addListener(() => _updateForm('from', _from.text));
    _to.addListener(() => _updateForm('to', _to.text));
    _length_of_service.addListener(
        () => _updateForm('length_of_service', _length_of_service.text));
  }

  void _updateForm(String key, String value) {
    controller.updateForm(widget.index, key, value);
  }

  void _handleSave() {
    controller.saveProfile(widget.index);
  }

  void _handleRemove() {
    controller.removeForm(widget.index);
  }

  @override
  void dispose() {
    _company.dispose();
    _position.dispose();
    _from.dispose();
    _to.dispose();
    _length_of_service.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ActionButtonWidget(
                formKey: _formKey,
                onSave: _handleSave,
                onRemove: _handleRemove,
                saveIconColor: primaryColor,
                removeIconColor: dangerColor,
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                controller: _company,
                label: "Nama perusahaan",
                icon: Icons.business_center_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama perusahaan tidak boleh kosong';
                  }
                  return null;
                },
                fillColor:
                    primaryColor.withOpacity(0.1), // Optional customization
                borderRadius: 10.0, // Optional customization
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                controller: _position,
                label: 'Posisi',
                icon: Icons.account_box,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Posisi tidak boleh kosong';
                  }
                  return null;
                },
                fillColor:
                    primaryColor.withOpacity(0.1), // Optional customization
                borderRadius: 10.0,
              ),
              const SizedBox(height: 10),
              DateFieldWidget(
                controller: _from,
                hintText: 'Pilih tanggal mulai',
                icon: Icons.calendar_today,
                context: context,
                fillColor: primaryColor.withOpacity(0.1),
                borderRadius: 15.0,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                onDateSelected: (date) {
                  _updateForm('from', date);
                },
              ),
              const SizedBox(height: 10),
              DateFieldWidget(
                controller: _to,
                hintText: 'Pilih tanggal selesai',
                icon: Icons.calendar_today,
                context: context,
                fillColor: primaryColor.withOpacity(0.1),
                borderRadius: 15.0,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                onDateSelected: (date) {
                  _updateForm('to', date);
                },
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                controller: _length_of_service,
                label: 'Berapa lama ?',
                icon: Icons.access_time,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field ini tidak boleh kosong';
                  }
                  return null;
                },
                fillColor:
                    primaryColor.withOpacity(0.1), // Optional customization
                borderRadius: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
