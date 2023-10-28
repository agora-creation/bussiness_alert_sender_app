import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:flutter/material.dart';

class AnswerCheckboxListTile extends StatelessWidget {
  final bool? value;
  final Function(bool?)? onChanged;

  const AnswerCheckboxListTile({
    this.value,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: kGreyColor),
          bottom: BorderSide(color: kGreyColor),
        ),
      ),
      child: CheckboxListTile(
        title: const Text('回答を求める'),
        value: value,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
