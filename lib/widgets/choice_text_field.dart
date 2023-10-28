import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:flutter/material.dart';

class ChoiceTextField extends StatelessWidget {
  final String value;
  final Function(String)? onChanged;

  const ChoiceTextField({
    required this.value,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: TextField(
        controller: TextEditingController(text: value),
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: kGreyColor),
            borderRadius: BorderRadius.zero,
          ),
          contentPadding: EdgeInsets.all(8),
        ),
        style: const TextStyle(fontSize: 14),
        onChanged: onChanged,
      ),
    );
  }
}
