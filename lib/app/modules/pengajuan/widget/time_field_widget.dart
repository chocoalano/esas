import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For DateFormat

class TimeFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final BuildContext context;
  final Color fillColor;
  final double borderRadius;
  final TimeOfDay? initialTime;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onTimeSelected;

  const TimeFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.context,
    this.fillColor = const Color(0xFFEEEEEE), // Default fill color
    this.borderRadius = 10.0,
    this.initialTime,
    this.validator,
    this.onTimeSelected,
  });

  InputDecoration _inputDecoration() {
    return InputDecoration(
      labelText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide.none,
      ),
      fillColor: fillColor,
      filled: true,
      prefixIcon: Icon(icon),
    );
  }

  Future<void> _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final selectedTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      String formattedTime = DateFormat('HH:mm').format(selectedTime);
      controller.text = formattedTime;

      if (onTimeSelected != null) {
        onTimeSelected!(formattedTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectTime,
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          decoration: _inputDecoration(),
          validator: validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Waktu $hintText tidak boleh kosong';
                }
                return null;
              },
        ),
      ),
    );
  }
}
