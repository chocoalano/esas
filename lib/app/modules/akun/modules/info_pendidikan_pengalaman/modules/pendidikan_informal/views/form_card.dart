// ignore_for_file: library_private_types_in_public_api

import 'package:esas/app/modules/akun/modules/info_pendidikan_pengalaman/modules/pendidikan_informal/controllers/pendidikan_informal_controller.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/action_button_widget.dart';
import '../../widget/checked_field_widget.dart';
import '../../widget/date_field_widget.dart';
import '../../widget/dropdown_field_widget.dart';
import '../../widget/text_field_widget.dart';

class FormCard extends StatefulWidget {
  final int index;
  final VoidCallback onRemove;
  final VoidCallback onSave;

  const FormCard({
    super.key,
    required this.index,
    required this.onRemove,
    required this.onSave,
  });

  @override
  _FormCardState createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  late final TextEditingController _nameController;
  late final TextEditingController _startController;
  late final TextEditingController _finishController;
  late final TextEditingController _expiredController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _durationController;
  late final TextEditingController _feeController;

  final _formKey = GlobalKey<FormState>();
  final PendidikanInformalController _controller = Get.find();

  @override
  void initState() {
    super.initState();

    // Initialize controllers with values from formData
    _nameController = TextEditingController(
      text: _controller.formData[widget.index]['name'] ?? '',
    );
    _startController = TextEditingController(
      text: _controller.formData[widget.index]['start'] ?? '',
    );
    _finishController = TextEditingController(
      text: _controller.formData[widget.index]['finish'] ?? '',
    );
    _expiredController = TextEditingController(
      text: _controller.formData[widget.index]['expired'] ?? '',
    );
    _descriptionController = TextEditingController(
      text: _controller.formData[widget.index]['description'] ?? '',
    );
    _durationController = TextEditingController(
      text: _controller.formData[widget.index]['duration'] ?? '',
    );
    _feeController = TextEditingController(
      text: _controller.formData[widget.index]['fee'] ?? '',
    );

    // Attach listeners to controllers for automatic form updates
    _nameController
        .addListener(() => _updateForm('name', _nameController.text));
    _startController
        .addListener(() => _updateForm('start', _startController.text));
    _finishController
        .addListener(() => _updateForm('finish', _finishController.text));
    _expiredController
        .addListener(() => _updateForm('expired', _expiredController.text));
    _descriptionController.addListener(
        () => _updateForm('description', _descriptionController.text));
    _durationController
        .addListener(() => _updateForm('duration', _durationController.text));
    _feeController.addListener(() => _updateForm('fee', _feeController.text));
  }

  void _updateForm(String key, String value) {
    _controller.updateForm(widget.index, key, value);
  }

  void _handleSave() {
    _controller.saveProfile(widget.index);
  }

  void _handleRemove() {
    _controller.removeForm(widget.index);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _startController.dispose();
    _finishController.dispose();
    _expiredController.dispose();
    _descriptionController.dispose();
    _durationController.dispose();
    _feeController.dispose();
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
                controller: _nameController,
                label: "Nama",
                icon: Icons.account_box,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
                fillColor:
                    primaryColor.withOpacity(0.1), // Optional customization
                borderRadius: 10.0, // Optional customization
              ),
              const SizedBox(height: 10),
              DropdownFieldWidget(
                value: _controller.formData[widget.index]['type'] ?? 'day',
                items: const [
                  DropdownMenuItem(value: 'day', child: Text('Harian')),
                  DropdownMenuItem(value: 'month', child: Text('Bulanan')),
                  DropdownMenuItem(value: 'year', child: Text('Tahunan')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    _updateForm('type', value);
                  }
                },
                fillColor: primaryColor.withOpacity(0.1),
                borderRadius: 10.0,
              ),
              const SizedBox(height: 10),
              DateFieldWidget(
                controller: _startController,
                hintText: 'Tanggal Mulai',
                icon: Icons.calendar_today,
                context: context,
                fillColor: primaryColor.withOpacity(0.1),
                borderRadius: 15.0,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                onDateSelected: (date) {
                  _updateForm('start', date);
                },
              ),
              const SizedBox(height: 10),
              DateFieldWidget(
                controller: _finishController,
                hintText: 'Tanggal selesai',
                icon: Icons.calendar_today,
                context: context,
                fillColor: primaryColor.withOpacity(0.1),
                borderRadius: 15.0,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                onDateSelected: (date) {
                  _updateForm('finish', date);
                },
              ),
              const SizedBox(height: 10),
              DateFieldWidget(
                controller: _expiredController,
                hintText: 'Tanggal expired',
                icon: Icons.calendar_today,
                context: context,
                fillColor: primaryColor.withOpacity(0.1),
                borderRadius: 15.0,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                onDateSelected: (date) {
                  _updateForm('expired', date);
                },
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                controller: _descriptionController,
                label: "Deskripsi",
                icon: Icons.description_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi tidak boleh kosong';
                  }
                  return null;
                },
                fillColor:
                    primaryColor.withOpacity(0.1), // Optional customization
                borderRadius: 10.0, // Optional customization
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                controller: _durationController,
                label: "Durasi",
                icon: Icons.access_time,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Durasi tidak boleh kosong';
                  }
                  return null;
                },
                fillColor:
                    primaryColor.withOpacity(0.1), // Optional customization
                borderRadius: 10.0, // Optional customization
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                controller: _feeController,
                label: "Biaya",
                icon: Icons.access_time,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Biaya tidak boleh kosong';
                  }
                  return null;
                },
                fillColor:
                    primaryColor.withOpacity(0.1), // Optional customization
                borderRadius: 10.0, // Optional customization
              ),
              const SizedBox(height: 10),
              CheckedFieldWidget(
                isChecked: _controller.formData[widget.index]
                            ['certification'] ==
                        'true'
                    ? true
                    : false,
                label: 'Apakah pendidikan ini tersertifikasi?',
                icon: Icons.verified_user,
                onChanged: (bool? value) {
                  _updateForm('certification', value.toString());
                },
                activeColor: primaryColor,
                checkColor: Colors.white,
                iconColor: primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 0.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
