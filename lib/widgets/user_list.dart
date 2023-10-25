import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:bussiness_alert_sender_app/models/user.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  final UserModel user;

  const UserList({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: kGreyColor)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          user.name,
          style: const TextStyle(
            color: kBlackColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
