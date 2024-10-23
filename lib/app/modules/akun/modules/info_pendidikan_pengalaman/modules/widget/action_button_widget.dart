import 'package:flutter/material.dart';

class ActionButtonWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onSave;
  final VoidCallback onRemove;
  final Color saveIconColor;
  final Color removeIconColor;

  const ActionButtonWidget({
    super.key,
    required this.formKey,
    required this.onSave,
    required this.onRemove,
    this.saveIconColor = Colors.blue,
    this.removeIconColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              onSave();
            }
          },
          icon: Icon(Icons.save_alt_outlined, color: saveIconColor),
        ),
        IconButton(
          onPressed: onRemove,
          icon: Icon(Icons.remove_circle_outline, color: removeIconColor),
        ),
      ],
    );
  }
}
