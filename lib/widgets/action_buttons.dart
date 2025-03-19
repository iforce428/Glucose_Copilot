import 'package:flutter/material.dart';

class ActionButton {
  final String label;
  final VoidCallback onTap;

  ActionButton({
    required this.label,
    required this.onTap,
  });
}

class ActionButtonsRow extends StatelessWidget {
  final List<ActionButton> buttons;

  const ActionButtonsRow({
    super.key,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: buttons.map((button) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ElevatedButton(
            onPressed: button.onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0ABAB5),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              minimumSize: const Size(double.infinity, 40),
            ),
            child: Text(button.label),
          ),
        );
      }).toList(),
    );
  }
}

