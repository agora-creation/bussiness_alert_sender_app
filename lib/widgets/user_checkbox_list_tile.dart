import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:bussiness_alert_sender_app/models/user.dart';
import 'package:flutter/material.dart';

class UserCheckboxListTile extends StatelessWidget {
  final UserModel user;
  final bool value;
  final Function(bool?)? onChanged;

  const UserCheckboxListTile({
    required this.user,
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: kGreyColor)),
      ),
      child: CheckboxListTile(
        title: Text(
          user.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'SourceHanSansJP-Bold',
          ),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
